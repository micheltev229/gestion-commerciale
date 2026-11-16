import os
from datetime import date

import pymysql
from dotenv import load_dotenv
from flask import Flask, flash, redirect, render_template, request, url_for

load_dotenv()  # lit le fichier .env en local, sans effet sur Render

app = Flask(__name__)
app.secret_key = os.getenv("SECRET_KEY", "cle-de-developpement")


# Connexion à MySQL : tous les paramètres viennent des variables d'environnement
def get_db():
    return pymysql.connect(
        host=os.getenv("DB_HOST"),
        port=int(os.getenv("DB_PORT", "3306")),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME"),
        cursorclass=pymysql.cursors.DictCursor,
        autocommit=True,
        connect_timeout=10,
    )


# Exécute une requête paramétrée et renvoie les lignes (ou la première)
def query(sql, params=(), one=False):
    conn = get_db()
    try:
        with conn.cursor() as cur:
            cur.execute(sql, params)
            rows = cur.fetchall()
    finally:
        conn.close()
    if one:
        return rows[0] if rows else None
    return rows


# Filtre d'affichage des montants : 12500 -> "12 500 FCFA"
@app.template_filter("fcfa")
def fcfa(montant):
    return f"{float(montant or 0):,.0f}".replace(",", " ") + " FCFA"


# === Catégories ===

@app.route("/categories")
def categories():
    lignes = query(
        "SELECT c.id_categorie, c.libelle, COUNT(p.id_produit) AS nb_produits "
        "FROM CATEGORIE_PRODUIT c LEFT JOIN PRODUIT p ON p.id_categorie = c.id_categorie "
        "GROUP BY c.id_categorie, c.libelle ORDER BY c.libelle"
    )
    return render_template("categories.html", categories=lignes)


@app.route("/categories/ajouter", methods=["POST"])
def ajouter_categorie():
    libelle = request.form.get("libelle", "").strip()
    if not libelle:
        flash("Le libellé est obligatoire.", "danger")
    else:
        try:
            query("INSERT INTO CATEGORIE_PRODUIT (libelle) VALUES (%s)", (libelle,))
            flash(f"Catégorie « {libelle} » ajoutée.", "success")
        except pymysql.err.IntegrityError:
            flash(f"La catégorie « {libelle} » existe déjà.", "warning")
    return redirect(url_for("categories"))


@app.route("/categories/<int:id_categorie>/modifier", methods=["GET", "POST"])
def modifier_categorie(id_categorie):
    categorie = query("SELECT * FROM CATEGORIE_PRODUIT WHERE id_categorie = %s", (id_categorie,), one=True)
    if categorie is None:
        flash("Catégorie introuvable.", "danger")
        return redirect(url_for("categories"))
    if request.method == "POST":
        libelle = request.form.get("libelle", "").strip()
        if not libelle:
            flash("Le libellé est obligatoire.", "danger")
        else:
            try:
                query("UPDATE CATEGORIE_PRODUIT SET libelle = %s WHERE id_categorie = %s", (libelle, id_categorie))
                flash("Catégorie modifiée.", "success")
                return redirect(url_for("categories"))
            except pymysql.err.IntegrityError:
                flash(f"La catégorie « {libelle} » existe déjà.", "warning")
    return render_template("categorie_form.html", categorie=categorie)


@app.route("/categories/<int:id_categorie>/supprimer", methods=["POST"])
def supprimer_categorie(id_categorie):
    try:
        query("DELETE FROM CATEGORIE_PRODUIT WHERE id_categorie = %s", (id_categorie,))
        flash("Catégorie supprimée.", "success")
    except pymysql.err.IntegrityError:
        # La clé étrangère (ON DELETE RESTRICT) bloque la suppression
        flash("Suppression impossible : des produits appartiennent à cette catégorie.", "danger")
    return redirect(url_for("categories"))


# === Produits ===

@app.route("/produits")
def produits():
    lignes = query(
        "SELECT p.id_produit, p.designation, p.prix_vente, c.libelle AS categorie "
        "FROM PRODUIT p JOIN CATEGORIE_PRODUIT c ON c.id_categorie = p.id_categorie "
        "ORDER BY c.libelle, p.designation"
    )
    return render_template("produits.html", produits=lignes)


# Lit et contrôle les champs du formulaire produit
def lire_formulaire_produit():
    designation = request.form.get("designation", "").strip()
    id_categorie = request.form.get("id_categorie", type=int)
    prix_vente = request.form.get("prix_vente", type=float)
    erreurs = []
    if not designation:
        erreurs.append("La désignation est obligatoire.")
    if prix_vente is None or prix_vente < 0:
        erreurs.append("Le prix de vente doit être un nombre positif.")
    if id_categorie is None:
        erreurs.append("Choisissez une catégorie.")
    return (designation, prix_vente, id_categorie), erreurs


@app.route("/produits/ajouter", methods=["GET", "POST"])
def ajouter_produit():
    if request.method == "POST":
        valeurs, erreurs = lire_formulaire_produit()
        if not erreurs:
            query("INSERT INTO PRODUIT (designation, prix_vente, id_categorie) VALUES (%s, %s, %s)", valeurs)
            flash(f"Produit « {valeurs[0]} » ajouté.", "success")
            return redirect(url_for("produits"))
        for e in erreurs:
            flash(e, "danger")
    cats = query("SELECT * FROM CATEGORIE_PRODUIT ORDER BY libelle")
    return render_template("produit_form.html", produit=None, categories=cats)


@app.route("/produits/<int:id_produit>/modifier", methods=["GET", "POST"])
def modifier_produit(id_produit):
    produit = query("SELECT * FROM PRODUIT WHERE id_produit = %s", (id_produit,), one=True)
    if produit is None:
        flash("Produit introuvable.", "danger")
        return redirect(url_for("produits"))
    if request.method == "POST":
        valeurs, erreurs = lire_formulaire_produit()
        if not erreurs:
            query(
                "UPDATE PRODUIT SET designation = %s, prix_vente = %s, id_categorie = %s WHERE id_produit = %s",
                (*valeurs, id_produit),
            )
            flash("Produit modifié.", "success")
            return redirect(url_for("produits"))
        for e in erreurs:
            flash(e, "danger")
    cats = query("SELECT * FROM CATEGORIE_PRODUIT ORDER BY libelle")
    return render_template("produit_form.html", produit=produit, categories=cats)


@app.route("/produits/<int:id_produit>/supprimer", methods=["POST"])
def supprimer_produit(id_produit):
    try:
        query("DELETE FROM PRODUIT WHERE id_produit = %s", (id_produit,))
        flash("Produit supprimé.", "success")
    except pymysql.err.IntegrityError:
        flash("Suppression impossible : ce produit figure dans des ventes ou des approvisionnements.", "danger")
    return redirect(url_for("produits"))


# === Stock : entrées, sorties et coût moyen unitaire pondéré (CMUP) ===

SQL_STOCK = """
    WITH entrees AS (
        SELECT id_produit, SUM(quantite) AS qte,
               SUM(quantite * prix_achat) / SUM(quantite) AS cmup
        FROM APPROVISIONNEMENT GROUP BY id_produit
    ),
    sorties AS (
        SELECT id_produit, SUM(quantite) AS qte FROM VENTE GROUP BY id_produit
    )
    SELECT p.id_produit, p.designation, p.prix_vente,
           COALESCE(e.qte, 0) AS entrees, COALESCE(s.qte, 0) AS sorties,
           COALESCE(e.qte, 0) - COALESCE(s.qte, 0) AS stock, e.cmup
    FROM PRODUIT p
    LEFT JOIN entrees e ON e.id_produit = p.id_produit
    LEFT JOIN sorties s ON s.id_produit = p.id_produit
"""


def stock_produit(id_produit):
    ligne = query(SQL_STOCK + " WHERE p.id_produit = %s", (id_produit,), one=True)
    return int(ligne["stock"]) if ligne else 0


# Lit les champs communs aux opérations (date, produit, quantité, prix)
def lire_operation(champ_prix):
    erreurs = []
    try:
        jour = date.fromisoformat(request.form.get("date", ""))
    except ValueError:
        jour = None
        erreurs.append("La date est invalide.")
    id_produit = request.form.get("id_produit", type=int)
    quantite = request.form.get("quantite", type=int)
    prix = request.form.get(champ_prix, type=float)
    if id_produit is None:
        erreurs.append("Choisissez un produit.")
    if quantite is None or quantite <= 0:
        erreurs.append("La quantité doit être un entier strictement positif.")
    if prix is None or prix < 0:
        erreurs.append("Le prix doit être un nombre positif.")
    return (jour, id_produit, quantite, prix), erreurs


# Période choisie dans les filtres (par défaut : toute la période)
def lire_periode():
    debut = request.args.get("debut") or "2000-01-01"
    fin = request.args.get("fin") or "2100-12-31"
    return debut, fin


# === Tableau de bord ===

@app.route("/")
def accueil():
    debut, fin = lire_periode()
    p = (debut, fin)
    totaux = query(
        "SELECT "
        "(SELECT COALESCE(SUM(quantite * prix_unitaire), 0) FROM VENTE WHERE date_vente BETWEEN %s AND %s) AS ca, "
        "(SELECT COUNT(*) FROM VENTE WHERE date_vente BETWEEN %s AND %s) AS nb_ventes, "
        "(SELECT COALESCE(SUM(quantite * prix_achat), 0) FROM APPROVISIONNEMENT WHERE date_appro BETWEEN %s AND %s) AS achats, "
        "(SELECT COALESCE(SUM(montant), 0) FROM DEPENSE WHERE date_depense BETWEEN %s AND %s) AS depenses",
        p * 4, one=True,
    )
    cout = query(
        "WITH cm AS (SELECT id_produit, SUM(quantite * prix_achat) / SUM(quantite) AS cmup "
        "FROM APPROVISIONNEMENT GROUP BY id_produit) "
        "SELECT COALESCE(SUM(v.quantite * cm.cmup), 0) AS cout_ventes "
        "FROM VENTE v JOIN cm ON cm.id_produit = v.id_produit WHERE v.date_vente BETWEEN %s AND %s",
        p, one=True,
    )
    stocks = query(SQL_STOCK + " ORDER BY stock, p.designation")

    # Indicateurs calculés à partir des totaux
    ca, achats, depenses = float(totaux["ca"]), float(totaux["achats"]), float(totaux["depenses"])
    marge = ca - float(cout["cout_ventes"])
    kpi = {
        "ca": ca, "achats": achats, "depenses": depenses, "marge": marge,
        "taux_marge": 100 * marge / ca if ca else 0,
        "resultat": marge - depenses,
        "tresorerie": ca - achats - depenses,
        "nb_ventes": totaux["nb_ventes"],
        "panier": ca / totaux["nb_ventes"] if totaux["nb_ventes"] else 0,
        "valeur_stock": sum(float(s["stock"]) * float(s["cmup"] or 0) for s in stocks),
    }

    mois = query(
        "SELECT mois, SUM(ca) AS ca, SUM(achats) AS achats, SUM(depenses) AS depenses FROM ("
        " SELECT DATE_FORMAT(date_vente, '%%Y-%%m') AS mois, quantite * prix_unitaire AS ca, 0 AS achats, 0 AS depenses"
        " FROM VENTE WHERE date_vente BETWEEN %s AND %s"
        " UNION ALL SELECT DATE_FORMAT(date_appro, '%%Y-%%m'), 0, quantite * prix_achat, 0"
        " FROM APPROVISIONNEMENT WHERE date_appro BETWEEN %s AND %s"
        " UNION ALL SELECT DATE_FORMAT(date_depense, '%%Y-%%m'), 0, 0, montant"
        " FROM DEPENSE WHERE date_depense BETWEEN %s AND %s"
        ") t GROUP BY mois ORDER BY mois",
        p * 3,
    )
    par_categorie = query(
        "SELECT c.libelle, SUM(v.quantite * v.prix_unitaire) AS ca FROM VENTE v "
        "JOIN PRODUIT pr ON pr.id_produit = v.id_produit "
        "JOIN CATEGORIE_PRODUIT c ON c.id_categorie = pr.id_categorie "
        "WHERE v.date_vente BETWEEN %s AND %s GROUP BY c.libelle ORDER BY ca DESC",
        p,
    )
    top = query(
        "WITH cm AS (SELECT id_produit, SUM(quantite * prix_achat) / SUM(quantite) AS cmup "
        "FROM APPROVISIONNEMENT GROUP BY id_produit) "
        "SELECT pr.designation, SUM(v.quantite) AS qte, SUM(v.quantite * v.prix_unitaire) AS ca, "
        "SUM(v.quantite * (v.prix_unitaire - cm.cmup)) AS marge "
        "FROM VENTE v JOIN PRODUIT pr ON pr.id_produit = v.id_produit "
        "LEFT JOIN cm ON cm.id_produit = v.id_produit "
        "WHERE v.date_vente BETWEEN %s AND %s GROUP BY pr.id_produit, pr.designation "
        "ORDER BY ca DESC LIMIT 5",
        p,
    )
    graph = {
        "mois": [m["mois"] for m in mois],
        "ca": [float(m["ca"]) for m in mois],
        "achats": [float(m["achats"]) for m in mois],
        "depenses": [float(m["depenses"]) for m in mois],
        "cat_libelles": [c["libelle"] for c in par_categorie],
        "cat_ca": [float(c["ca"]) for c in par_categorie],
    }
    return render_template(
        "index.html", kpi=kpi, graph=graph, top=top, stocks=stocks,
        debut=request.args.get("debut", ""), fin=request.args.get("fin", ""),
    )


# === Approvisionnements ===

@app.route("/approvisionnements", methods=["GET", "POST"])
def approvisionnements():
    if request.method == "POST":
        valeurs, erreurs = lire_operation("prix_achat")
        if not erreurs:
            query(
                "INSERT INTO APPROVISIONNEMENT (date_appro, id_produit, quantite, prix_achat) "
                "VALUES (%s, %s, %s, %s)", valeurs,
            )
            flash("Approvisionnement enregistré.", "success")
            return redirect(url_for("approvisionnements"))
        for e in erreurs:
            flash(e, "danger")
    lignes = query(
        "SELECT a.id_appro, a.date_appro, p.designation, a.quantite, a.prix_achat, "
        "a.quantite * a.prix_achat AS montant "
        "FROM APPROVISIONNEMENT a JOIN PRODUIT p ON p.id_produit = a.id_produit "
        "ORDER BY a.date_appro DESC, a.id_appro DESC"
    )
    return render_template(
        "approvisionnements.html", lignes=lignes, produits=query(SQL_STOCK + " ORDER BY p.designation"),
        aujourdhui=date.today().isoformat(),
    )


@app.route("/approvisionnements/<int:id_appro>/supprimer", methods=["POST"])
def supprimer_approvisionnement(id_appro):
    appro = query("SELECT * FROM APPROVISIONNEMENT WHERE id_appro = %s", (id_appro,), one=True)
    if appro and stock_produit(appro["id_produit"]) < appro["quantite"]:
        # Supprimer cette entrée rendrait le stock négatif
        flash("Suppression impossible : une partie de cette marchandise a déjà été vendue.", "danger")
    elif appro:
        query("DELETE FROM APPROVISIONNEMENT WHERE id_appro = %s", (id_appro,))
        flash("Approvisionnement supprimé.", "success")
    return redirect(url_for("approvisionnements"))


# === Ventes ===

@app.route("/ventes", methods=["GET", "POST"])
def ventes():
    if request.method == "POST":
        valeurs, erreurs = lire_operation("prix_unitaire")
        if not erreurs and valeurs[2] > stock_produit(valeurs[1]):
            erreurs.append(f"Stock insuffisant : il reste {stock_produit(valeurs[1])} unité(s) de ce produit.")
        if not erreurs:
            query(
                "INSERT INTO VENTE (date_vente, id_produit, quantite, prix_unitaire) VALUES (%s, %s, %s, %s)",
                valeurs,
            )
            flash("Vente enregistrée.", "success")
            return redirect(url_for("ventes"))
        for e in erreurs:
            flash(e, "danger")
    lignes = query(
        "SELECT v.id_vente, v.date_vente, p.designation, v.quantite, v.prix_unitaire, "
        "v.quantite * v.prix_unitaire AS montant "
        "FROM VENTE v JOIN PRODUIT p ON p.id_produit = v.id_produit "
        "ORDER BY v.date_vente DESC, v.id_vente DESC"
    )
    return render_template(
        "ventes.html", lignes=lignes, produits=query(SQL_STOCK + " ORDER BY p.designation"),
        aujourdhui=date.today().isoformat(),
    )


@app.route("/ventes/<int:id_vente>/supprimer", methods=["POST"])
def supprimer_vente(id_vente):
    query("DELETE FROM VENTE WHERE id_vente = %s", (id_vente,))
    flash("Vente supprimée.", "success")
    return redirect(url_for("ventes"))


# === Dépenses ===

@app.route("/depenses", methods=["GET", "POST"])
def depenses():
    if request.method == "POST":
        erreurs = []
        try:
            jour = date.fromisoformat(request.form.get("date", ""))
        except ValueError:
            jour = None
            erreurs.append("La date est invalide.")
        libelle = request.form.get("libelle", "").strip()
        montant = request.form.get("montant", type=float)
        if not libelle:
            erreurs.append("Le libellé est obligatoire.")
        if montant is None or montant < 0:
            erreurs.append("Le montant doit être un nombre positif.")
        if not erreurs:
            query("INSERT INTO DEPENSE (date_depense, libelle, montant) VALUES (%s, %s, %s)", (jour, libelle, montant))
            flash("Dépense enregistrée.", "success")
            return redirect(url_for("depenses"))
        for e in erreurs:
            flash(e, "danger")
    lignes = query("SELECT * FROM DEPENSE ORDER BY date_depense DESC, id_depense DESC")
    return render_template("depenses.html", lignes=lignes, aujourdhui=date.today().isoformat())


@app.route("/depenses/<int:id_depense>/supprimer", methods=["POST"])
def supprimer_depense(id_depense):
    query("DELETE FROM DEPENSE WHERE id_depense = %s", (id_depense,))
    flash("Dépense supprimée.", "success")
    return redirect(url_for("depenses"))


# === Journal : toutes les opérations réunies par UNION ALL ===

@app.route("/journal")
def journal():
    debut, fin = lire_periode()
    lignes = query(
        "SELECT 'Vente' AS type, v.date_vente AS date_op, p.designation AS libelle, v.quantite, "
        "v.quantite * v.prix_unitaire AS montant, 1 AS sens "
        "FROM VENTE v JOIN PRODUIT p ON p.id_produit = v.id_produit WHERE v.date_vente BETWEEN %s AND %s "
        "UNION ALL "
        "SELECT 'Approvisionnement', a.date_appro, p.designation, a.quantite, a.quantite * a.prix_achat, -1 "
        "FROM APPROVISIONNEMENT a JOIN PRODUIT p ON p.id_produit = a.id_produit WHERE a.date_appro BETWEEN %s AND %s "
        "UNION ALL "
        "SELECT 'Dépense', d.date_depense, d.libelle, NULL, d.montant, -1 "
        "FROM DEPENSE d WHERE d.date_depense BETWEEN %s AND %s "
        "ORDER BY date_op, type",
        (debut, fin) * 3,
    )
    # Solde de trésorerie cumulé, puis affichage du plus récent au plus ancien
    solde = 0
    for ligne in lignes:
        solde += ligne["sens"] * float(ligne["montant"])
        ligne["solde"] = solde
    return render_template(
        "journal.html", lignes=list(reversed(lignes)),
        debut=request.args.get("debut", ""), fin=request.args.get("fin", ""),
    )


if __name__ == "__main__":
    app.run(debug=True)

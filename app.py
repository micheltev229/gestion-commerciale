import os

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


@app.route("/")
def accueil():
    stats = query(
        "SELECT (SELECT COUNT(*) FROM CATEGORIE_PRODUIT) AS nb_categories, "
        "(SELECT COUNT(*) FROM PRODUIT) AS nb_produits",
        one=True,
    )
    return render_template("index.html", stats=stats)


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
    query("DELETE FROM PRODUIT WHERE id_produit = %s", (id_produit,))
    flash("Produit supprimé.", "success")
    return redirect(url_for("produits"))


if __name__ == "__main__":
    app.run(debug=True)

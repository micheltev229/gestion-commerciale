# Gestion commerciale pour le secteur informel

Application web Flask qui permet à un commerçant de suivre ses produits, ses approvisionnements, ses ventes et ses dépenses.
Les données sont stockées dans une base MySQL distante hébergée sur FreeDB.
L'application est déployée sur Render.

TP de bases de données, ISE 2, ENSAE Pierre-Ndiaye (Dakar).

## Modules

- Catégories et produits : ajout, consultation, modification, suppression.
- Approvisionnements : produit, quantité achetée, prix d'achat unitaire, historique.
- Ventes : produit, quantité vendue, prix de vente unitaire, contrôle du stock, historique.
- Dépenses : date, libellé, montant, historique.
- Journal : toutes les opérations réunies, avec le solde de trésorerie cumulé.
- Tableau de bord : chiffre d'affaires, marge brute, dépenses, résultat, stocks et graphiques.

## Lancer le projet en local

1. Installer les dépendances : `pip install -r requirements.txt`
2. Copier `.env.example` en `.env` et renseigner les paramètres de la base.
3. Créer les tables avec `sql/schema.sql` puis `sql/schema_v2.sql`.
4. Charger si besoin les données fictives de `sql/donnees_demo.sql`.
5. Lancer l'application : `python app.py`, puis ouvrir http://127.0.0.1:5000

## Déploiement sur Render

- Build command : `pip install -r requirements.txt`
- Start command : `gunicorn app:app`
- Variables d'environnement : `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `SECRET_KEY`

Le fichier `.env` n'est jamais publié : il est exclu par `.gitignore`.

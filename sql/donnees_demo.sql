/* Données fictives de démonstration (août à novembre 2026) */

INSERT IGNORE INTO CATEGORIE_PRODUIT (libelle) VALUES ('Boissons'), ('Céréales'), ('Huiles et condiments'), ('Hygiène'), ('Produits laitiers');

INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Riz parfumé (sac de 25 kg)', 18000, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Céréales' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Riz parfumé (sac de 25 kg)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Riz brisé (kg)', 450, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Céréales' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Riz brisé (kg)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Mil (kg)', 500, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Céréales' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Mil (kg)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 1800, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Boissons' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Eau minérale (pack de 6 bouteilles de 1,5 L)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Jus de bissap (bouteille de 1 L)', 1000, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Boissons' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Jus de bissap (bouteille de 1 L)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Huile végétale (bidon de 5 L)', 6500, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Huiles et condiments' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Huile végétale (bidon de 5 L)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Sucre en poudre (kg)', 700, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Huiles et condiments' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Sucre en poudre (kg)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Bouillon (boîte de 100 cubes)', 2500, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Huiles et condiments' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Bouillon (boîte de 100 cubes)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Lait en poudre (sachet de 400 g)', 2200, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Produits laitiers' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Lait en poudre (sachet de 400 g)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Lait caillé (pot de 500 ml)', 700, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Produits laitiers' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Lait caillé (pot de 500 ml)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Savon de ménage (morceau)', 300, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Hygiène' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Savon de ménage (morceau)');
INSERT INTO PRODUIT (designation, prix_vente, id_categorie) SELECT 'Lessive en poudre (sachet de 1 kg)', 1200, id_categorie FROM CATEGORIE_PRODUIT WHERE libelle = 'Hygiène' AND NOT EXISTS (SELECT 1 FROM PRODUIT WHERE designation = 'Lessive en poudre (sachet de 1 kg)');

INSERT INTO APPROVISIONNEMENT (date_appro, id_produit, quantite, prix_achat)
SELECT t.d, p.id_produit, t.q, t.px FROM (
SELECT '2026-08-17' AS d, 'Riz parfumé (sac de 25 kg)' AS des, 8 AS q, 16000 AS px
    UNION ALL SELECT '2026-08-17', 'Riz brisé (kg)', 100, 380
    UNION ALL SELECT '2026-08-17', 'Mil (kg)', 60, 420
    UNION ALL SELECT '2026-08-17', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 30, 1450
    UNION ALL SELECT '2026-08-17', 'Jus de bissap (bouteille de 1 L)', 30, 650
    UNION ALL SELECT '2026-08-17', 'Huile végétale (bidon de 5 L)', 10, 5800
    UNION ALL SELECT '2026-08-17', 'Sucre en poudre (kg)', 50, 600
    UNION ALL SELECT '2026-08-17', 'Bouillon (boîte de 100 cubes)', 12, 2100
    UNION ALL SELECT '2026-08-17', 'Lait en poudre (sachet de 400 g)', 20, 1900
    UNION ALL SELECT '2026-08-17', 'Lait caillé (pot de 500 ml)', 30, 550
    UNION ALL SELECT '2026-08-17', 'Savon de ménage (morceau)', 60, 220
    UNION ALL SELECT '2026-08-17', 'Lessive en poudre (sachet de 1 kg)', 20, 1000
    UNION ALL SELECT '2026-08-24', 'Sucre en poudre (kg)', 50, 600
    UNION ALL SELECT '2026-08-24', 'Lait caillé (pot de 500 ml)', 30, 550
    UNION ALL SELECT '2026-08-31', 'Riz brisé (kg)', 100, 380
    UNION ALL SELECT '2026-08-31', 'Mil (kg)', 60, 420
    UNION ALL SELECT '2026-08-31', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 30, 1450
    UNION ALL SELECT '2026-08-31', 'Lait caillé (pot de 500 ml)', 30, 550
    UNION ALL SELECT '2026-08-31', 'Savon de ménage (morceau)', 60, 220
    UNION ALL SELECT '2026-09-07', 'Riz parfumé (sac de 25 kg)', 8, 16000
    UNION ALL SELECT '2026-09-07', 'Jus de bissap (bouteille de 1 L)', 30, 650
    UNION ALL SELECT '2026-09-07', 'Huile végétale (bidon de 5 L)', 10, 5800
    UNION ALL SELECT '2026-09-07', 'Lait en poudre (sachet de 400 g)', 20, 1900
    UNION ALL SELECT '2026-09-14', 'Riz parfumé (sac de 25 kg)', 8, 16000
    UNION ALL SELECT '2026-09-14', 'Sucre en poudre (kg)', 50, 600
    UNION ALL SELECT '2026-09-14', 'Lait caillé (pot de 500 ml)', 30, 550
    UNION ALL SELECT '2026-09-14', 'Lessive en poudre (sachet de 1 kg)', 20, 1000
    UNION ALL SELECT '2026-09-21', 'Riz brisé (kg)', 100, 380
    UNION ALL SELECT '2026-09-21', 'Lait en poudre (sachet de 400 g)', 20, 1900
    UNION ALL SELECT '2026-09-21', 'Lait caillé (pot de 500 ml)', 30, 550
    UNION ALL SELECT '2026-09-28', 'Mil (kg)', 60, 420
    UNION ALL SELECT '2026-09-28', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 30, 1450
    UNION ALL SELECT '2026-09-28', 'Jus de bissap (bouteille de 1 L)', 30, 650
    UNION ALL SELECT '2026-09-28', 'Huile végétale (bidon de 5 L)', 10, 5800
    UNION ALL SELECT '2026-09-28', 'Bouillon (boîte de 100 cubes)', 12, 2100
    UNION ALL SELECT '2026-09-28', 'Lessive en poudre (sachet de 1 kg)', 20, 1000
    UNION ALL SELECT '2026-10-05', 'Riz brisé (kg)', 100, 390
    UNION ALL SELECT '2026-10-05', 'Sucre en poudre (kg)', 50, 620
    UNION ALL SELECT '2026-10-05', 'Savon de ménage (morceau)', 60, 230
    UNION ALL SELECT '2026-10-12', 'Riz parfumé (sac de 25 kg)', 8, 16300
    UNION ALL SELECT '2026-10-12', 'Mil (kg)', 60, 420
    UNION ALL SELECT '2026-10-12', 'Lait caillé (pot de 500 ml)', 30, 550
    UNION ALL SELECT '2026-10-19', 'Riz brisé (kg)', 100, 390
    UNION ALL SELECT '2026-10-19', 'Jus de bissap (bouteille de 1 L)', 30, 700
    UNION ALL SELECT '2026-10-19', 'Huile végétale (bidon de 5 L)', 10, 5950
    UNION ALL SELECT '2026-10-19', 'Sucre en poudre (kg)', 50, 620
    UNION ALL SELECT '2026-10-19', 'Lait caillé (pot de 500 ml)', 30, 550
    UNION ALL SELECT '2026-10-19', 'Savon de ménage (morceau)', 60, 230
    UNION ALL SELECT '2026-10-19', 'Lessive en poudre (sachet de 1 kg)', 20, 1000
    UNION ALL SELECT '2026-10-26', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 30, 1450
    UNION ALL SELECT '2026-10-26', 'Bouillon (boîte de 100 cubes)', 12, 2100
    UNION ALL SELECT '2026-10-26', 'Lait en poudre (sachet de 400 g)', 20, 1950
    UNION ALL SELECT '2026-11-02', 'Mil (kg)', 60, 420
    UNION ALL SELECT '2026-11-02', 'Sucre en poudre (kg)', 50, 620
    UNION ALL SELECT '2026-11-09', 'Riz parfumé (sac de 25 kg)', 8, 16300
    UNION ALL SELECT '2026-11-09', 'Riz brisé (kg)', 100, 390
    UNION ALL SELECT '2026-11-09', 'Jus de bissap (bouteille de 1 L)', 30, 700
    UNION ALL SELECT '2026-11-09', 'Huile végétale (bidon de 5 L)', 10, 5950
    UNION ALL SELECT '2026-11-09', 'Lait caillé (pot de 500 ml)', 30, 550
    UNION ALL SELECT '2026-11-09', 'Savon de ménage (morceau)', 60, 230
) t JOIN PRODUIT p ON p.designation = t.des;

INSERT INTO VENTE (date_vente, id_produit, quantite, prix_unitaire)
SELECT t.d, p.id_produit, t.q, t.px FROM (
SELECT '2026-08-17' AS d, 'Jus de bissap (bouteille de 1 L)' AS des, 6 AS q, 1000 AS px
    UNION ALL SELECT '2026-08-17', 'Sucre en poudre (kg)', 12, 650
    UNION ALL SELECT '2026-08-17', 'Lait en poudre (sachet de 400 g)', 4, 2200
    UNION ALL SELECT '2026-08-17', 'Lait caillé (pot de 500 ml)', 8, 700
    UNION ALL SELECT '2026-08-18', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1700
    UNION ALL SELECT '2026-08-18', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-08-18', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-08-19', 'Riz brisé (kg)', 18, 450
    UNION ALL SELECT '2026-08-19', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1800
    UNION ALL SELECT '2026-08-20', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 2, 1800
    UNION ALL SELECT '2026-08-20', 'Sucre en poudre (kg)', 10, 700
    UNION ALL SELECT '2026-08-20', 'Lait caillé (pot de 500 ml)', 8, 700
    UNION ALL SELECT '2026-08-20', 'Savon de ménage (morceau)', 10, 300
    UNION ALL SELECT '2026-08-21', 'Riz brisé (kg)', 10, 450
    UNION ALL SELECT '2026-08-21', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-08-21', 'Sucre en poudre (kg)', 10, 700
    UNION ALL SELECT '2026-08-21', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-08-22', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-08-22', 'Lait caillé (pot de 500 ml)', 8, 700
    UNION ALL SELECT '2026-08-22', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-08-24', 'Riz brisé (kg)', 6, 450
    UNION ALL SELECT '2026-08-24', 'Sucre en poudre (kg)', 8, 700
    UNION ALL SELECT '2026-08-25', 'Riz brisé (kg)', 8, 450
    UNION ALL SELECT '2026-08-25', 'Jus de bissap (bouteille de 1 L)', 2, 1000
    UNION ALL SELECT '2026-08-25', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-08-25', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-08-25', 'Savon de ménage (morceau)', 6, 300
    UNION ALL SELECT '2026-08-26', 'Riz brisé (kg)', 12, 450
    UNION ALL SELECT '2026-08-26', 'Mil (kg)', 6, 500
    UNION ALL SELECT '2026-08-26', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 6, 1800
    UNION ALL SELECT '2026-08-26', 'Sucre en poudre (kg)', 8, 700
    UNION ALL SELECT '2026-08-26', 'Lait caillé (pot de 500 ml)', 4, 650
    UNION ALL SELECT '2026-08-27', 'Riz brisé (kg)', 16, 450
    UNION ALL SELECT '2026-08-27', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-08-27', 'Sucre en poudre (kg)', 10, 700
    UNION ALL SELECT '2026-08-27', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-08-28', 'Riz brisé (kg)', 12, 450
    UNION ALL SELECT '2026-08-28', 'Sucre en poudre (kg)', 4, 700
    UNION ALL SELECT '2026-08-28', 'Lait en poudre (sachet de 400 g)', 4, 2200
    UNION ALL SELECT '2026-08-28', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-08-29', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-08-29', 'Mil (kg)', 6, 500
    UNION ALL SELECT '2026-08-29', 'Jus de bissap (bouteille de 1 L)', 4, 950
    UNION ALL SELECT '2026-08-29', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-08-29', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-08-29', 'Lessive en poudre (sachet de 1 kg)', 2, 1200
    UNION ALL SELECT '2026-08-31', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-08-31', 'Riz brisé (kg)', 6, 450
    UNION ALL SELECT '2026-08-31', 'Mil (kg)', 2, 500
    UNION ALL SELECT '2026-08-31', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-08-31', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-08-31', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-09-01', 'Mil (kg)', 6, 500
    UNION ALL SELECT '2026-09-01', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-09-01', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-09-01', 'Lessive en poudre (sachet de 1 kg)', 4, 1150
    UNION ALL SELECT '2026-09-02', 'Riz brisé (kg)', 6, 450
    UNION ALL SELECT '2026-09-02', 'Mil (kg)', 6, 500
    UNION ALL SELECT '2026-09-02', 'Jus de bissap (bouteille de 1 L)', 6, 1000
    UNION ALL SELECT '2026-09-02', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-09-02', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-09-03', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-09-03', 'Riz brisé (kg)', 6, 450
    UNION ALL SELECT '2026-09-03', 'Mil (kg)', 6, 500
    UNION ALL SELECT '2026-09-03', 'Lait caillé (pot de 500 ml)', 6, 650
    UNION ALL SELECT '2026-09-04', 'Sucre en poudre (kg)', 8, 700
    UNION ALL SELECT '2026-09-04', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-09-04', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-09-04', 'Lait caillé (pot de 500 ml)', 8, 700
    UNION ALL SELECT '2026-09-05', 'Riz brisé (kg)', 6, 450
    UNION ALL SELECT '2026-09-05', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-09-05', 'Lait en poudre (sachet de 400 g)', 4, 2200
    UNION ALL SELECT '2026-09-05', 'Savon de ménage (morceau)', 4, 300
    UNION ALL SELECT '2026-09-07', 'Riz brisé (kg)', 14, 450
    UNION ALL SELECT '2026-09-07', 'Jus de bissap (bouteille de 1 L)', 2, 1000
    UNION ALL SELECT '2026-09-07', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-09-07', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-09-07', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-09-07', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-09-08', 'Riz brisé (kg)', 18, 450
    UNION ALL SELECT '2026-09-08', 'Sucre en poudre (kg)', 4, 700
    UNION ALL SELECT '2026-09-08', 'Lait caillé (pot de 500 ml)', 6, 650
    UNION ALL SELECT '2026-09-08', 'Savon de ménage (morceau)', 10, 300
    UNION ALL SELECT '2026-09-09', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-09-09', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1800
    UNION ALL SELECT '2026-09-09', 'Jus de bissap (bouteille de 1 L)', 6, 950
    UNION ALL SELECT '2026-09-09', 'Lait en poudre (sachet de 400 g)', 4, 2200
    UNION ALL SELECT '2026-09-09', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-09-09', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-09-10', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-09-10', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1800
    UNION ALL SELECT '2026-09-10', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-09-10', 'Sucre en poudre (kg)', 12, 700
    UNION ALL SELECT '2026-09-10', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-09-10', 'Lait caillé (pot de 500 ml)', 8, 700
    UNION ALL SELECT '2026-09-10', 'Lessive en poudre (sachet de 1 kg)', 2, 1200
    UNION ALL SELECT '2026-09-11', 'Riz brisé (kg)', 10, 450
    UNION ALL SELECT '2026-09-11', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1800
    UNION ALL SELECT '2026-09-11', 'Jus de bissap (bouteille de 1 L)', 6, 1000
    UNION ALL SELECT '2026-09-11', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-09-11', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-09-11', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-09-12', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-09-12', 'Jus de bissap (bouteille de 1 L)', 2, 1000
    UNION ALL SELECT '2026-09-12', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-09-14', 'Riz brisé (kg)', 8, 450
    UNION ALL SELECT '2026-09-14', 'Mil (kg)', 4, 500
    UNION ALL SELECT '2026-09-14', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 6, 1800
    UNION ALL SELECT '2026-09-14', 'Sucre en poudre (kg)', 8, 700
    UNION ALL SELECT '2026-09-14', 'Lessive en poudre (sachet de 1 kg)', 2, 1200
    UNION ALL SELECT '2026-09-15', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-09-15', 'Mil (kg)', 8, 500
    UNION ALL SELECT '2026-09-15', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1800
    UNION ALL SELECT '2026-09-15', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-09-16', 'Lait en poudre (sachet de 400 g)', 4, 2200
    UNION ALL SELECT '2026-09-16', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-09-17', 'Sucre en poudre (kg)', 12, 700
    UNION ALL SELECT '2026-09-17', 'Lait caillé (pot de 500 ml)', 8, 650
    UNION ALL SELECT '2026-09-18', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-09-18', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-09-18', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-09-18', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-09-19', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 6, 1800
    UNION ALL SELECT '2026-09-19', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-09-19', 'Sucre en poudre (kg)', 10, 700
    UNION ALL SELECT '2026-09-19', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-09-19', 'Savon de ménage (morceau)', 10, 300
    UNION ALL SELECT '2026-09-21', 'Riz brisé (kg)', 18, 450
    UNION ALL SELECT '2026-09-21', 'Mil (kg)', 8, 500
    UNION ALL SELECT '2026-09-21', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 6, 1800
    UNION ALL SELECT '2026-09-21', 'Jus de bissap (bouteille de 1 L)', 4, 1000
    UNION ALL SELECT '2026-09-21', 'Bouillon (boîte de 100 cubes)', 2, 2400
    UNION ALL SELECT '2026-09-21', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-09-22', 'Riz brisé (kg)', 8, 450
    UNION ALL SELECT '2026-09-22', 'Mil (kg)', 8, 500
    UNION ALL SELECT '2026-09-22', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-09-22', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-09-22', 'Savon de ménage (morceau)', 4, 300
    UNION ALL SELECT '2026-09-23', 'Riz brisé (kg)', 14, 450
    UNION ALL SELECT '2026-09-23', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-09-23', 'Jus de bissap (bouteille de 1 L)', 4, 1000
    UNION ALL SELECT '2026-09-23', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-09-23', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-09-23', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-09-24', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1700
    UNION ALL SELECT '2026-09-24', 'Huile végétale (bidon de 5 L)', 2, 6200
    UNION ALL SELECT '2026-09-24', 'Sucre en poudre (kg)', 4, 700
    UNION ALL SELECT '2026-09-24', 'Savon de ménage (morceau)', 4, 300
    UNION ALL SELECT '2026-09-24', 'Lessive en poudre (sachet de 1 kg)', 2, 1200
    UNION ALL SELECT '2026-09-25', 'Riz brisé (kg)', 14, 450
    UNION ALL SELECT '2026-09-25', 'Mil (kg)', 2, 500
    UNION ALL SELECT '2026-09-25', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-09-25', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-09-26', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 2, 1800
    UNION ALL SELECT '2026-09-26', 'Jus de bissap (bouteille de 1 L)', 4, 1000
    UNION ALL SELECT '2026-09-26', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-09-28', 'Riz brisé (kg)', 8, 450
    UNION ALL SELECT '2026-09-28', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-09-28', 'Jus de bissap (bouteille de 1 L)', 6, 1000
    UNION ALL SELECT '2026-09-29', 'Riz brisé (kg)', 6, 450
    UNION ALL SELECT '2026-09-29', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-09-29', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1700
    UNION ALL SELECT '2026-09-29', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-09-29', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-09-30', 'Riz brisé (kg)', 14, 450
    UNION ALL SELECT '2026-09-30', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-09-30', 'Jus de bissap (bouteille de 1 L)', 2, 1000
    UNION ALL SELECT '2026-09-30', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-09-30', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-09-30', 'Lessive en poudre (sachet de 1 kg)', 2, 1150
    UNION ALL SELECT '2026-10-01', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1700
    UNION ALL SELECT '2026-10-01', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-10-01', 'Sucre en poudre (kg)', 6, 700
    UNION ALL SELECT '2026-10-01', 'Savon de ménage (morceau)', 10, 300
    UNION ALL SELECT '2026-10-01', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-10-02', 'Riz brisé (kg)', 12, 450
    UNION ALL SELECT '2026-10-02', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-10-02', 'Jus de bissap (bouteille de 1 L)', 4, 950
    UNION ALL SELECT '2026-10-02', 'Sucre en poudre (kg)', 12, 700
    UNION ALL SELECT '2026-10-02', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-10-02', 'Savon de ménage (morceau)', 4, 300
    UNION ALL SELECT '2026-10-02', 'Lessive en poudre (sachet de 1 kg)', 2, 1200
    UNION ALL SELECT '2026-10-03', 'Riz brisé (kg)', 16, 450
    UNION ALL SELECT '2026-10-03', 'Mil (kg)', 6, 500
    UNION ALL SELECT '2026-10-03', 'Jus de bissap (bouteille de 1 L)', 4, 1000
    UNION ALL SELECT '2026-10-03', 'Sucre en poudre (kg)', 8, 700
    UNION ALL SELECT '2026-10-03', 'Bouillon (boîte de 100 cubes)', 2, 2400
    UNION ALL SELECT '2026-10-03', 'Lait en poudre (sachet de 400 g)', 4, 2200
    UNION ALL SELECT '2026-10-05', 'Riz brisé (kg)', 12, 450
    UNION ALL SELECT '2026-10-05', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 2, 1800
    UNION ALL SELECT '2026-10-05', 'Sucre en poudre (kg)', 10, 700
    UNION ALL SELECT '2026-10-06', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-10-06', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-10-06', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-10-07', 'Sucre en poudre (kg)', 6, 700
    UNION ALL SELECT '2026-10-07', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-10-08', 'Riz parfumé (sac de 25 kg)', 2, 17100
    UNION ALL SELECT '2026-10-08', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-10-08', 'Sucre en poudre (kg)', 4, 700
    UNION ALL SELECT '2026-10-08', 'Lait en poudre (sachet de 400 g)', 2, 2100
    UNION ALL SELECT '2026-10-08', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-10-08', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-10-09', 'Riz brisé (kg)', 12, 450
    UNION ALL SELECT '2026-10-09', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-10-09', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-10-10', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-10-10', 'Riz brisé (kg)', 14, 450
    UNION ALL SELECT '2026-10-10', 'Mil (kg)', 6, 500
    UNION ALL SELECT '2026-10-10', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 2, 1800
    UNION ALL SELECT '2026-10-10', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-10-10', 'Lait en poudre (sachet de 400 g)', 4, 2100
    UNION ALL SELECT '2026-10-10', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-10-12', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-10-12', 'Jus de bissap (bouteille de 1 L)', 4, 1000
    UNION ALL SELECT '2026-10-12', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-10-12', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-10-12', 'Savon de ménage (morceau)', 4, 300
    UNION ALL SELECT '2026-10-12', 'Lessive en poudre (sachet de 1 kg)', 2, 1200
    UNION ALL SELECT '2026-10-13', 'Riz brisé (kg)', 10, 450
    UNION ALL SELECT '2026-10-13', 'Mil (kg)', 8, 500
    UNION ALL SELECT '2026-10-13', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-10-13', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-10-13', 'Savon de ménage (morceau)', 6, 300
    UNION ALL SELECT '2026-10-13', 'Lessive en poudre (sachet de 1 kg)', 2, 1200
    UNION ALL SELECT '2026-10-14', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-10-14', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1800
    UNION ALL SELECT '2026-10-14', 'Jus de bissap (bouteille de 1 L)', 4, 950
    UNION ALL SELECT '2026-10-14', 'Sucre en poudre (kg)', 4, 700
    UNION ALL SELECT '2026-10-14', 'Savon de ménage (morceau)', 10, 300
    UNION ALL SELECT '2026-10-15', 'Riz brisé (kg)', 12, 450
    UNION ALL SELECT '2026-10-15', 'Huile végétale (bidon de 5 L)', 2, 6200
    UNION ALL SELECT '2026-10-15', 'Sucre en poudre (kg)', 12, 700
    UNION ALL SELECT '2026-10-15', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-10-16', 'Riz brisé (kg)', 14, 450
    UNION ALL SELECT '2026-10-16', 'Mil (kg)', 2, 500
    UNION ALL SELECT '2026-10-16', 'Jus de bissap (bouteille de 1 L)', 6, 1000
    UNION ALL SELECT '2026-10-16', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-10-16', 'Savon de ménage (morceau)', 10, 300
    UNION ALL SELECT '2026-10-16', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-10-17', 'Riz brisé (kg)', 12, 450
    UNION ALL SELECT '2026-10-17', 'Mil (kg)', 2, 500
    UNION ALL SELECT '2026-10-17', 'Jus de bissap (bouteille de 1 L)', 2, 1000
    UNION ALL SELECT '2026-10-17', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-10-17', 'Sucre en poudre (kg)', 12, 650
    UNION ALL SELECT '2026-10-17', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-10-17', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-10-17', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-10-19', 'Mil (kg)', 10, 500
    UNION ALL SELECT '2026-10-19', 'Sucre en poudre (kg)', 12, 700
    UNION ALL SELECT '2026-10-19', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-10-19', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-10-20', 'Riz brisé (kg)', 10, 450
    UNION ALL SELECT '2026-10-20', 'Jus de bissap (bouteille de 1 L)', 4, 1000
    UNION ALL SELECT '2026-10-20', 'Bouillon (boîte de 100 cubes)', 2, 2400
    UNION ALL SELECT '2026-10-20', 'Savon de ménage (morceau)', 6, 300
    UNION ALL SELECT '2026-10-21', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-10-21', 'Mil (kg)', 6, 500
    UNION ALL SELECT '2026-10-21', 'Jus de bissap (bouteille de 1 L)', 6, 1000
    UNION ALL SELECT '2026-10-21', 'Huile végétale (bidon de 5 L)', 2, 6200
    UNION ALL SELECT '2026-10-21', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-10-22', 'Sucre en poudre (kg)', 6, 700
    UNION ALL SELECT '2026-10-22', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-10-23', 'Riz brisé (kg)', 8, 450
    UNION ALL SELECT '2026-10-23', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 6, 1800
    UNION ALL SELECT '2026-10-23', 'Jus de bissap (bouteille de 1 L)', 2, 1000
    UNION ALL SELECT '2026-10-23', 'Sucre en poudre (kg)', 8, 700
    UNION ALL SELECT '2026-10-23', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-10-23', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-10-23', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-10-24', 'Riz brisé (kg)', 18, 450
    UNION ALL SELECT '2026-10-24', 'Sucre en poudre (kg)', 4, 700
    UNION ALL SELECT '2026-10-24', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-10-24', 'Savon de ménage (morceau)', 6, 300
    UNION ALL SELECT '2026-10-24', 'Lessive en poudre (sachet de 1 kg)', 2, 1150
    UNION ALL SELECT '2026-10-26', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-10-27', 'Riz brisé (kg)', 16, 450
    UNION ALL SELECT '2026-10-27', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1800
    UNION ALL SELECT '2026-10-27', 'Sucre en poudre (kg)', 8, 650
    UNION ALL SELECT '2026-10-27', 'Lait caillé (pot de 500 ml)', 8, 700
    UNION ALL SELECT '2026-10-28', 'Riz brisé (kg)', 14, 450
    UNION ALL SELECT '2026-10-28', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 2, 1800
    UNION ALL SELECT '2026-10-28', 'Jus de bissap (bouteille de 1 L)', 4, 1000
    UNION ALL SELECT '2026-10-28', 'Sucre en poudre (kg)', 12, 650
    UNION ALL SELECT '2026-10-28', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-10-28', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-10-29', 'Riz brisé (kg)', 18, 450
    UNION ALL SELECT '2026-10-29', 'Mil (kg)', 4, 500
    UNION ALL SELECT '2026-10-29', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 2, 1700
    UNION ALL SELECT '2026-10-29', 'Sucre en poudre (kg)', 6, 700
    UNION ALL SELECT '2026-10-29', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-10-29', 'Savon de ménage (morceau)', 4, 300
    UNION ALL SELECT '2026-10-30', 'Mil (kg)', 6, 500
    UNION ALL SELECT '2026-10-30', 'Jus de bissap (bouteille de 1 L)', 6, 1000
    UNION ALL SELECT '2026-10-30', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-10-30', 'Lait en poudre (sachet de 400 g)', 4, 2200
    UNION ALL SELECT '2026-10-30', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-10-30', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-10-31', 'Riz brisé (kg)', 6, 450
    UNION ALL SELECT '2026-10-31', 'Jus de bissap (bouteille de 1 L)', 2, 1000
    UNION ALL SELECT '2026-10-31', 'Lessive en poudre (sachet de 1 kg)', 2, 1150
    UNION ALL SELECT '2026-11-02', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-11-02', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-11-02', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-11-03', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-11-03', 'Riz brisé (kg)', 14, 450
    UNION ALL SELECT '2026-11-03', 'Mil (kg)', 2, 500
    UNION ALL SELECT '2026-11-03', 'Sucre en poudre (kg)', 8, 700
    UNION ALL SELECT '2026-11-03', 'Lait caillé (pot de 500 ml)', 4, 700
    UNION ALL SELECT '2026-11-03', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-11-04', 'Riz brisé (kg)', 14, 450
    UNION ALL SELECT '2026-11-04', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 4, 1800
    UNION ALL SELECT '2026-11-04', 'Jus de bissap (bouteille de 1 L)', 4, 950
    UNION ALL SELECT '2026-11-04', 'Lait en poudre (sachet de 400 g)', 4, 2200
    UNION ALL SELECT '2026-11-04', 'Savon de ménage (morceau)', 8, 300
    UNION ALL SELECT '2026-11-05', 'Riz parfumé (sac de 25 kg)', 2, 17100
    UNION ALL SELECT '2026-11-05', 'Riz brisé (kg)', 6, 450
    UNION ALL SELECT '2026-11-05', 'Jus de bissap (bouteille de 1 L)', 2, 1000
    UNION ALL SELECT '2026-11-05', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-11-05', 'Sucre en poudre (kg)', 6, 700
    UNION ALL SELECT '2026-11-05', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-11-05', 'Savon de ménage (morceau)', 10, 300
    UNION ALL SELECT '2026-11-06', 'Riz brisé (kg)', 6, 450
    UNION ALL SELECT '2026-11-06', 'Mil (kg)', 4, 500
    UNION ALL SELECT '2026-11-06', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 6, 1800
    UNION ALL SELECT '2026-11-06', 'Jus de bissap (bouteille de 1 L)', 4, 1000
    UNION ALL SELECT '2026-11-06', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-11-06', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-11-07', 'Sucre en poudre (kg)', 8, 700
    UNION ALL SELECT '2026-11-07', 'Lait en poudre (sachet de 400 g)', 2, 2200
    UNION ALL SELECT '2026-11-07', 'Lait caillé (pot de 500 ml)', 8, 700
    UNION ALL SELECT '2026-11-07', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-11-07', 'Lessive en poudre (sachet de 1 kg)', 2, 1150
    UNION ALL SELECT '2026-11-09', 'Mil (kg)', 6, 500
    UNION ALL SELECT '2026-11-09', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 2, 1700
    UNION ALL SELECT '2026-11-09', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-11-09', 'Sucre en poudre (kg)', 8, 700
    UNION ALL SELECT '2026-11-09', 'Lait caillé (pot de 500 ml)', 2, 700
    UNION ALL SELECT '2026-11-09', 'Savon de ménage (morceau)', 4, 300
    UNION ALL SELECT '2026-11-09', 'Lessive en poudre (sachet de 1 kg)', 4, 1150
    UNION ALL SELECT '2026-11-10', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 2, 1800
    UNION ALL SELECT '2026-11-10', 'Lait en poudre (sachet de 400 g)', 4, 2200
    UNION ALL SELECT '2026-11-10', 'Lait caillé (pot de 500 ml)', 6, 700
    UNION ALL SELECT '2026-11-10', 'Savon de ménage (morceau)', 4, 300
    UNION ALL SELECT '2026-11-10', 'Lessive en poudre (sachet de 1 kg)', 4, 1200
    UNION ALL SELECT '2026-11-11', 'Riz brisé (kg)', 18, 450
    UNION ALL SELECT '2026-11-11', 'Mil (kg)', 2, 500
    UNION ALL SELECT '2026-11-11', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 6, 1800
    UNION ALL SELECT '2026-11-11', 'Huile végétale (bidon de 5 L)', 2, 6200
    UNION ALL SELECT '2026-11-11', 'Savon de ménage (morceau)', 2, 300
    UNION ALL SELECT '2026-11-11', 'Lessive en poudre (sachet de 1 kg)', 2, 1200
    UNION ALL SELECT '2026-11-12', 'Riz parfumé (sac de 25 kg)', 2, 17100
    UNION ALL SELECT '2026-11-12', 'Riz brisé (kg)', 10, 450
    UNION ALL SELECT '2026-11-12', 'Eau minérale (pack de 6 bouteilles de 1,5 L)', 6, 1800
    UNION ALL SELECT '2026-11-12', 'Sucre en poudre (kg)', 10, 700
    UNION ALL SELECT '2026-11-12', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-11-12', 'Lait en poudre (sachet de 400 g)', 4, 2200
    UNION ALL SELECT '2026-11-13', 'Huile végétale (bidon de 5 L)', 2, 6500
    UNION ALL SELECT '2026-11-13', 'Bouillon (boîte de 100 cubes)', 2, 2500
    UNION ALL SELECT '2026-11-13', 'Lait caillé (pot de 500 ml)', 4, 650
    UNION ALL SELECT '2026-11-13', 'Lessive en poudre (sachet de 1 kg)', 2, 1200
    UNION ALL SELECT '2026-11-14', 'Riz parfumé (sac de 25 kg)', 2, 18000
    UNION ALL SELECT '2026-11-14', 'Riz brisé (kg)', 16, 450
    UNION ALL SELECT '2026-11-14', 'Jus de bissap (bouteille de 1 L)', 6, 1000
    UNION ALL SELECT '2026-11-14', 'Savon de ménage (morceau)', 2, 300
) t JOIN PRODUIT p ON p.designation = t.des;

INSERT INTO DEPENSE (date_depense, libelle, montant) VALUES
    ('2026-08-17', 'Transport des marchandises', 2500),
    ('2026-08-20', 'Crédit téléphonique', 1000),
    ('2026-08-24', 'Transport des marchandises', 2500),
    ('2026-08-25', 'Sachets et emballages', 1500),
    ('2026-08-27', 'Crédit téléphonique', 1000),
    ('2026-08-31', 'Transport des marchandises', 2500),
    ('2026-09-01', 'Loyer de la boutique', 50000),
    ('2026-09-01', 'Taxe municipale', 3000),
    ('2026-09-03', 'Crédit téléphonique', 1000),
    ('2026-09-05', 'Électricité', 12500),
    ('2026-09-07', 'Transport des marchandises', 2500),
    ('2026-09-10', 'Crédit téléphonique', 1000),
    ('2026-09-10', 'Sachets et emballages', 1500),
    ('2026-09-14', 'Transport des marchandises', 2500),
    ('2026-09-17', 'Crédit téléphonique', 1000),
    ('2026-09-21', 'Transport des marchandises', 4000),
    ('2026-09-24', 'Crédit téléphonique', 1000),
    ('2026-09-25', 'Sachets et emballages', 1500),
    ('2026-09-28', 'Transport des marchandises', 3500),
    ('2026-10-01', 'Crédit téléphonique', 1000),
    ('2026-10-01', 'Loyer de la boutique', 50000),
    ('2026-10-01', 'Taxe municipale', 3000),
    ('2026-10-05', 'Transport des marchandises', 4000),
    ('2026-10-05', 'Électricité', 13000),
    ('2026-10-08', 'Crédit téléphonique', 1000),
    ('2026-10-10', 'Sachets et emballages', 1500),
    ('2026-10-12', 'Transport des marchandises', 3500),
    ('2026-10-15', 'Crédit téléphonique', 1000),
    ('2026-10-19', 'Transport des marchandises', 3500),
    ('2026-10-22', 'Crédit téléphonique', 1000),
    ('2026-10-25', 'Sachets et emballages', 1500),
    ('2026-10-26', 'Transport des marchandises', 3500),
    ('2026-10-29', 'Crédit téléphonique', 1000),
    ('2026-11-01', 'Loyer de la boutique', 50000),
    ('2026-11-01', 'Taxe municipale', 3000),
    ('2026-11-02', 'Transport des marchandises', 2500),
    ('2026-11-05', 'Crédit téléphonique', 1000),
    ('2026-11-05', 'Électricité', 11500),
    ('2026-11-09', 'Transport des marchandises', 3000),
    ('2026-11-10', 'Sachets et emballages', 1500),
    ('2026-11-12', 'Crédit téléphonique', 1000);

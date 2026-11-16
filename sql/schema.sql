/* Version 1 : catégories et produits */

CREATE TABLE IF NOT EXISTS CATEGORIE_PRODUIT (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    libelle      VARCHAR(100) NOT NULL UNIQUE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS PRODUIT (
    id_produit   INT AUTO_INCREMENT PRIMARY KEY,
    designation  VARCHAR(150) NOT NULL,
    prix_vente   DECIMAL(12,2) NOT NULL CHECK (prix_vente >= 0),
    id_categorie INT NOT NULL,
    CONSTRAINT fk_produit_categorie FOREIGN KEY (id_categorie)
        REFERENCES CATEGORIE_PRODUIT (id_categorie)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

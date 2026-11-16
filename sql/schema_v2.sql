/* Version 2 : approvisionnements, ventes et dépenses */

CREATE TABLE IF NOT EXISTS APPROVISIONNEMENT (
    id_appro   INT AUTO_INCREMENT PRIMARY KEY,
    date_appro DATE NOT NULL,
    id_produit INT NOT NULL,
    quantite   INT NOT NULL CHECK (quantite > 0),
    prix_achat DECIMAL(12,2) NOT NULL CHECK (prix_achat >= 0),
    CONSTRAINT fk_appro_produit FOREIGN KEY (id_produit)
        REFERENCES PRODUIT (id_produit)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS VENTE (
    id_vente      INT AUTO_INCREMENT PRIMARY KEY,
    date_vente    DATE NOT NULL,
    id_produit    INT NOT NULL,
    quantite      INT NOT NULL CHECK (quantite > 0),
    prix_unitaire DECIMAL(12,2) NOT NULL CHECK (prix_unitaire >= 0),
    CONSTRAINT fk_vente_produit FOREIGN KEY (id_produit)
        REFERENCES PRODUIT (id_produit)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS DEPENSE (
    id_depense   INT AUTO_INCREMENT PRIMARY KEY,
    date_depense DATE NOT NULL,
    libelle      VARCHAR(150) NOT NULL,
    montant      DECIMAL(12,2) NOT NULL CHECK (montant >= 0)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

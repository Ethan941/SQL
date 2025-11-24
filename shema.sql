CREATE DATABASE ProjetSQL;
/* Créatiion des différentes tables demandés*/

CREATE TABLE Clients (
    id_client INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    adresse TEXT NOT NULL,
    email VARCHAR(255) NULL,
    telephone VARCHAR(20) NULL
);

CREATE TABLE Produits (
    id_produit INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    prix_gramme DECIMAL(10,2) NOT NULL
);

CREATE TABLE Ventes (
    id_vente INT PRIMARY KEY AUTO_INCREMENT,
    id_client INT NOT NULL,
    date_vente DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_client) REFERENCES Clients(id_client) ON DELETE CASCADE
);

CREATE TABLE Ventes_Produits (
    id_vente INT,
    id_produit INT,
    quantite INT NOT NULL CHECK (quantite > 0),
    PRIMARY KEY (id_vente, id_produit),
    FOREIGN KEY (id_vente) REFERENCES Ventes(id_vente) ON DELETE CASCADE,
    FOREIGN KEY (id_produit) REFERENCES Produits(id_produit) ON DELETE CASCADE
);

/* Création des vues */

CREATE VIEW Suivi_Quotidien_Ventes AS
SELECT 
    DATE(date_vente) AS jour,
    COUNT(id_vente) AS nombre_ventes
FROM Ventes
GROUP BY jour
ORDER BY jour DESC;



CREATE VIEW Suivi_Fidelisation_Clients AS
SELECT 
    C.id_client,
    C.nom,
    SUM(VP.quantite * P.prix_gramme) AS total_depense
FROM Clients C
JOIN Ventes V ON C.id_client = V.id_client
JOIN Ventes_Produits VP ON V.id_vente = VP.id_vente
JOIN Produits P ON VP.id_produit = P.id_produit
WHERE V.date_vente >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY C.id_client, C.nom
ORDER BY total_depense DESC
LIMIT 5;
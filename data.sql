/* Tables clients */

INSERT INTO Clients (nom, adresse, email, telephone) VALUES
('Jean Dupont', '10 rue de Paris, 75001 Paris', 'jean.dupont@email.com', '0601020304'),
('Sophie Martin', '25 avenue des Champs, 75008 Paris', NULL, '0611121314'),
('Thé Gourmand SARL', '50 boulevard Haussmann, 75009 Paris', 'contact@thegourmand.fr', NULL),
('Entreprise Zen SAS', '12 rue des Tilleuls, 69002 Lyon', NULL, NULL),
('Paul Durand', '5 impasse des Cerisiers, 31000 Toulouse', 'paul.durand@email.com', '0622334455');

/* Tables produits */

INSERT INTO Produits (nom, prix_gramme) VALUES
('Thé Vert Sencha', 0.15),
('Thé Noir Earl Grey', 0.20),
('Thé Oolong', 0.18),
('Rooibos Vanille', 0.22),
('Infusion Menthe', 0.12);


/* Tables ventes*/ 

INSERT INTO Ventes (id_client, date_vente) VALUES
(1, '2025-02-10 14:30:00'),
(2, '2025-02-11 09:15:00'),
(3, '2025-02-12 16:45:00'),
(1, '2025-02-13 10:05:00'),
(4, '2025-02-14 18:20:00'),
(5, '2025-02-15 12:00:00');


/* Tables vente_produits*/

INSERT INTO Ventes_Produits (id_vente, id_produit, quantite) VALUES
(1, 1, 100), 
(1, 2, 50),
(2, 3, 75),
(3, 4, 200),
(4, 1, 150),
(5, 5, 120),
(6, 2, 90),
(6, 3, 60);

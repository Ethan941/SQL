# 🗄️ Projet SQL — Base de données relationnelle pour un revendeur de thé

Projet de **Data Engineering** centré sur la modélisation, la création et l’exploitation d’une base de données relationnelle.

L’objectif est de concevoir une base SQL pour un revendeur de thé, en gérant les clients, les produits, les commandes et les ventes.

Ce projet met en avant les bases essentielles du métier de Data Engineer : modélisation relationnelle, création de tables, contraintes, insertion de données, requêtes analytiques et vues SQL.

---

## 🎯 Objectif du projet

L’objectif est de construire une base de données relationnelle capable de répondre à des besoins métier simples :

- stocker les informations clients ;
- gérer un catalogue de produits ;
- suivre les commandes ;
- analyser les ventes ;
- calculer des indicateurs commerciaux ;
- produire des vues SQL exploitables pour l’analyse.

Ce projet montre comment passer d’un besoin métier à une structure de base de données exploitable.

---

## 🧠 Problématique Data Engineering

Une entreprise qui vend des produits doit structurer correctement ses données pour pouvoir les exploiter.

Ce projet répond à la problématique suivante :

> Comment modéliser une base de données relationnelle propre pour suivre les ventes, les clients et les produits d’un revendeur ?

Le projet permet de travailler sur :

- la modélisation ;
- l’intégrité des données ;
- les relations entre tables ;
- les requêtes SQL ;
- les vues analytiques.

---

## 🛠️ Technologies utilisées

- SQL
- Modélisation relationnelle
- Clés primaires
- Clés étrangères
- Contraintes d’intégrité
- Vues SQL
- Requêtes analytiques

---

## 📁 Structure du projet

```txt
SQL/
│
├── schema.sql              # Script de création des tables
├── data.sql                # Script d’insertion des données
├── queries.sql             # Requêtes analytiques
├── views.sql               # Création des vues SQL
├── schema.pdf              # Schéma relationnel de la base
├── README.md
└── .gitignore
```

Si certains fichiers n’existent pas encore, ils peuvent être ajoutés progressivement.

---

## 🧱 Modèle de données

La base de données peut être organisée autour de plusieurs entités principales.

### Tables principales

| Table | Rôle |
|---|---|
| `clients` | Stocke les informations des clients |
| `produits` | Stocke les produits vendus |
| `commandes` | Stocke les commandes passées |
| `lignes_commandes` | Détaille les produits présents dans chaque commande |
| `categories` | Classe les produits par catégorie |
| `paiements` | Stocke les informations de paiement |

---

## 🔗 Relations entre les tables

Exemple de relations possibles :

```txt
clients 1 ──── n commandes
commandes 1 ──── n lignes_commandes
produits 1 ──── n lignes_commandes
categories 1 ──── n produits
commandes 1 ──── 1 paiements
```

Ces relations permettent d’éviter la duplication inutile des données et de garantir une meilleure cohérence.

---

## 🧩 Exemple de création de table

```sql
CREATE TABLE clients (
    id_client INTEGER PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    ville VARCHAR(100),
    date_creation DATE
);
```

---

## 🧩 Exemple de table produit

```sql
CREATE TABLE produits (
    id_produit INTEGER PRIMARY KEY,
    nom_produit VARCHAR(150) NOT NULL,
    categorie VARCHAR(100),
    prix_unitaire DECIMAL(10, 2) NOT NULL,
    stock INTEGER DEFAULT 0
);
```

---

## 🧩 Exemple de table commande

```sql
CREATE TABLE commandes (
    id_commande INTEGER PRIMARY KEY,
    id_client INTEGER NOT NULL,
    date_commande DATE NOT NULL,
    statut VARCHAR(50),
    FOREIGN KEY (id_client) REFERENCES clients(id_client)
);
```

---

## 🧩 Exemple de table ligne de commande

```sql
CREATE TABLE lignes_commandes (
    id_ligne INTEGER PRIMARY KEY,
    id_commande INTEGER NOT NULL,
    id_produit INTEGER NOT NULL,
    quantite INTEGER NOT NULL,
    prix_unitaire DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_commande) REFERENCES commandes(id_commande),
    FOREIGN KEY (id_produit) REFERENCES produits(id_produit)
);
```

---

## 📥 Insertion de données

Le fichier `data.sql` permet d’insérer des données fictives pour tester la base.

Exemple :

```sql
INSERT INTO clients (id_client, nom, prenom, email, ville, date_creation)
VALUES
(1, 'Martin', 'Julie', 'julie.martin@email.com', 'Paris', '2024-01-15'),
(2, 'Bernard', 'Lucas', 'lucas.bernard@email.com', 'Lyon', '2024-02-10'),
(3, 'Petit', 'Emma', 'emma.petit@email.com', 'Marseille', '2024-03-05');
```

---

## 🔎 Requêtes analytiques

### 1. Chiffre d’affaires total

```sql
SELECT 
    SUM(quantite * prix_unitaire) AS chiffre_affaires_total
FROM lignes_commandes;
```

---

### 2. Chiffre d’affaires par produit

```sql
SELECT 
    p.nom_produit,
    SUM(lc.quantite * lc.prix_unitaire) AS chiffre_affaires
FROM lignes_commandes lc
JOIN produits p ON lc.id_produit = p.id_produit
GROUP BY p.nom_produit
ORDER BY chiffre_affaires DESC;
```

---

### 3. Nombre de commandes par client

```sql
SELECT 
    c.id_client,
    c.nom,
    c.prenom,
    COUNT(co.id_commande) AS nombre_commandes
FROM clients c
LEFT JOIN commandes co ON c.id_client = co.id_client
GROUP BY c.id_client, c.nom, c.prenom
ORDER BY nombre_commandes DESC;
```

---

### 4. Panier moyen

```sql
SELECT 
    AVG(total_commande) AS panier_moyen
FROM (
    SELECT 
        id_commande,
        SUM(quantite * prix_unitaire) AS total_commande
    FROM lignes_commandes
    GROUP BY id_commande
) sous_requete;
```

---

### 5. Produits les plus vendus

```sql
SELECT 
    p.nom_produit,
    SUM(lc.quantite) AS quantite_totale_vendue
FROM lignes_commandes lc
JOIN produits p ON lc.id_produit = p.id_produit
GROUP BY p.nom_produit
ORDER BY quantite_totale_vendue DESC;
```

---

### 6. Clients les plus rentables

```sql
SELECT 
    c.id_client,
    c.nom,
    c.prenom,
    SUM(lc.quantite * lc.prix_unitaire) AS total_depense
FROM clients c
JOIN commandes co ON c.id_client = co.id_client
JOIN lignes_commandes lc ON co.id_commande = lc.id_commande
GROUP BY c.id_client, c.nom, c.prenom
ORDER BY total_depense DESC;
```

---

## 👁️ Vues SQL

Les vues SQL permettent de simplifier l’analyse.

### Vue des ventes détaillées

```sql
CREATE VIEW vue_ventes_detaillees AS
SELECT 
    co.id_commande,
    co.date_commande,
    c.id_client,
    c.nom,
    c.prenom,
    p.id_produit,
    p.nom_produit,
    lc.quantite,
    lc.prix_unitaire,
    lc.quantite * lc.prix_unitaire AS montant_total
FROM commandes co
JOIN clients c ON co.id_client = c.id_client
JOIN lignes_commandes lc ON co.id_commande = lc.id_commande
JOIN produits p ON lc.id_produit = p.id_produit;
```

---

### Utilisation de la vue

```sql
SELECT 
    nom_produit,
    SUM(montant_total) AS chiffre_affaires
FROM vue_ventes_detaillees
GROUP BY nom_produit
ORDER BY chiffre_affaires DESC;
```

---

## 📊 Indicateurs possibles

Cette base permet de calculer plusieurs KPI :

| Indicateur | Description |
|---|---|
| Chiffre d’affaires total | Somme totale des ventes |
| Nombre de commandes | Volume total de commandes |
| Panier moyen | Montant moyen par commande |
| Produits les plus vendus | Produits avec la plus grande quantité vendue |
| Clients les plus rentables | Clients générant le plus de chiffre d’affaires |
| Ventes par catégorie | Analyse du CA par famille de produits |
| Ventes par ville | Répartition géographique des ventes |

---

## ✅ Compétences démontrées

Ce projet montre des compétences en :

- SQL ;
- modélisation relationnelle ;
- création de tables ;
- contraintes d’intégrité ;
- clés primaires ;
- clés étrangères ;
- insertion de données ;
- jointures ;
- agrégations ;
- sous-requêtes ;
- vues SQL ;
- requêtes analytiques ;
- raisonnement Data Engineering.

---

## ⚙️ Utilisation

### 1. Cloner le repository

```bash
git clone https://github.com/Ethan941/SQL.git
cd SQL
```

### 2. Exécuter le script de création

```sql
-- Exécuter le fichier schema.sql
```

### 3. Insérer les données

```sql
-- Exécuter le fichier data.sql
```

### 4. Lancer les requêtes analytiques

```sql
-- Exécuter le fichier queries.sql
```

---

## 🚀 Améliorations possibles

- Corriger le nom `shema.sql` en `schema.sql` ;
- ajouter un fichier `queries.sql` ;
- ajouter un fichier `views.sql` ;
- ajouter un diagramme relationnel clair ;
- ajouter plus de données fictives ;
- ajouter des contraintes plus complètes ;
- créer une version PostgreSQL ;
- connecter la base à Python ;
- créer un notebook d’analyse SQL + Python ;
- créer un dashboard Power BI ou QlikView ;
- ajouter une documentation sur le modèle relationnel.

---

## 📌 Statut du projet

Projet SQL en cours d’amélioration.

L’objectif est de transformer ce repository en projet clair de **Data Engineering**, montrant la capacité à concevoir une base relationnelle et à produire des analyses exploitables.

---

## 👤 Auteur

**Ethan Pandor**  
Étudiant en Bachelor Data & IA à HETIC  
Recherche stage ou alternance en Data Engineering / Data Science

# Projet SQL – Base de Données pour un Revendeur de Thé
## Présentation

Ce projet consiste à concevoir et implémenter une base de données relationnelle destinée à un revendeur de thé.
Cette base de données permet :

- un suivi précis des ventes,

- l’extraction de statistiques commerciales,

- et la mise en place d’outils de pilotage via deux vues SQL dédiées.

Le travail inclut la modélisation, la création des tables, les contraintes, les vues, ainsi que l’insertion d’un jeu de données fictives pour valider le fonctionnement global.

## Modélisation & Entités

La base doit gérer trois entités principales :

Clients

Chaque client possède les informations suivantes :

- Nom (personne physique : nom + prénom / personne morale : raison sociale)

- Adresse (unique)

- Adresse email (optionnelle)

- Numéro de téléphone (optionnel)

- Un client = une seule adresse.
Les coordonnées email et téléphone ne sont pas obligatoires.

## Produits

Chaque produit contient :

- Nom du produit

- Prix au gramme

## Ventes

Une vente contient :

- Le client associé

- Les produits achetés

- Les quantités pour chaque produit

- La date de vente

- Une vente peut contenir plusieurs produits, chacun avec une quantité différente.

## Vues demandées

Deux vues SQL doivent être créées pour faciliter l’analyse.

### 1. Suivi quotidien des ventes

Vue contenant :

- Nombre total de ventes par jour

- Regroupement et agrégation par date

### 2. Suivi de fidélisation des clients

Affiche :

Les 5 clients ayant dépensé le plus sur les 6 derniers mois

Le montant total dépensé

Classement du plus grand au plus petit

## Modélisation technique

La structure de la base de données doit inclure :

- Les tables

- Les colonnes et leurs types

- Les contraintes (PK, FK, CHECK…)

- Les liens entre les tables

- Les tables pivot si nécessaire (ex : ventes ↔ produits)

Les clés étrangères pour garantir l’intégrité relationnelle

Un schéma de modélisation (UML / Workbench / PDF...) doit être fourni en plus :

- format JPG/PNG/PDF

- généré via MySQL Workbench ou équivalent

## Contenu à fournir

Le rendu final doit contenir 4 fichiers obligatoires :

### 1. schema.sql

Contient :

- Création de la base

- Création des tables

- Contraintes

- Clés étrangères

- Création des vues

### 2. data.sql

Contient :

- Insertion de données fictives

- Jeu de données suffisant pour démontrer les vues

### 3. Modélisation (image ou PDF)

Un fichier :

- .png, .jpg ou .pdf

- montrant la structure de la base et les relations

### 4. Fichier des membres

Un fichier texte (txt, md, rtf) contenant :

La liste des membres du groupe

### Contraintes techniques

- Base de données : MySQL ou MariaDB

- Langage autorisé : SQL uniquement

- Outils autorisés : MySQL Workbench, DBeaver, etc.

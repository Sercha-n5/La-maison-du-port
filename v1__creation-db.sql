DROP DATABASE IF EXISTS transport_livraison;
CREATE DATABASE transport_livraison CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE transport_livraison;

-- Utilisateurs et rôles (héritage)
CREATE TABLE utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,  -- mot de passe haché, jamais en clair
    role ENUM('ADMIN','GESTIONNAIRE','CHAUFFEUR','CLIENT') NOT NULL
);

CREATE TABLE administrateur (
    id INT PRIMARY KEY,
    niveau_acces VARCHAR(50),
    FOREIGN KEY (id) REFERENCES utilisateur(id) ON DELETE CASCADE
);

CREATE TABLE gestionnaire (
    id INT PRIMARY KEY,
    service VARCHAR(100),
    FOREIGN KEY (id) REFERENCES utilisateur(id) ON DELETE CASCADE
);

CREATE TABLE chauffeur (
    id INT PRIMARY KEY,
    num_permis VARCHAR(50) NOT NULL UNIQUE,
    disponible BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (id) REFERENCES utilisateur(id) ON DELETE CASCADE
);

CREATE TABLE client (
    id INT PRIMARY KEY,
    adresse VARCHAR(255),
    telephone VARCHAR(20),
    FOREIGN KEY (id) REFERENCES utilisateur(id) ON DELETE CASCADE
);

-- Camions
CREATE TABLE camion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    immatriculation VARCHAR(20) NOT NULL UNIQUE,
    capacite_kg DECIMAL(10,2) NOT NULL,
    ville_actuelle VARCHAR(100),
    disponible BOOLEAN NOT NULL DEFAULT TRUE
);

-- Commandes
CREATE TABLE commande (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    date_commande DATE NOT NULL,
    adresse_livraison VARCHAR(255) NOT NULL,
    poids_kg DECIMAL(10,2),
    statut VARCHAR(30) NOT NULL DEFAULT 'COMMANDEE',
    FOREIGN KEY (client_id) REFERENCES client(id)
);

-- Livraisons
CREATE TABLE livraison (
    id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    camion_id INT NOT NULL,
    chauffeur_id INT NOT NULL,
    gestionnaire_id INT NOT NULL,
    creneau_debut DATETIME NOT NULL,
    creneau_fin DATETIME NOT NULL,
    statut ENUM('CRENEAU_PROPOSE','CONFIRMEE','PREPAREE','EN_COURS','LIVREE','ECHEC','REPROGRAMMEE')
        NOT NULL DEFAULT 'CRENEAU_PROPOSE',
    ordre_tournee INT NOT NULL,
    date_livraison DATE NOT NULL,
    FOREIGN KEY (commande_id) REFERENCES commande(id),
    FOREIGN KEY (camion_id) REFERENCES camion(id),
    FOREIGN KEY (chauffeur_id) REFERENCES chauffeur(id),
    FOREIGN KEY (gestionnaire_id) REFERENCES gestionnaire(id),
    CHECK (creneau_fin > creneau_debut),
    -- un chauffeur ne peut pas avoir deux livraisons au même rang le même jour
    UNIQUE (chauffeur_id, date_livraison, ordre_tournee)
);

-- Preuve de livraison (0..1 par livraison)
CREATE TABLE preuve_livraison (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livraison_id INT NOT NULL UNIQUE,
    signature VARCHAR(255),   -- chemin du fichier image
    photo VARCHAR(255),       -- chemin du fichier image
    date_heure DATETIME NOT NULL,
    FOREIGN KEY (livraison_id) REFERENCES livraison(id) ON DELETE CASCADE
);

-- Réclamations
CREATE TABLE reclamation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    livraison_id INT NOT NULL,
    motif VARCHAR(255) NOT NULL,
    statut VARCHAR(30) NOT NULL DEFAULT 'OUVERTE',
    date_creation DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES client(id),
    FOREIGN KEY (livraison_id) REFERENCES livraison(id)
);

-- Données de test
INSERT INTO utilisateur (nom, email, mot_de_passe, role) VALUES
('Admin', 'admin@transport.fr', 'hash_a_remplacer', 'ADMIN'),
('Marie Gestionnaire', 'gestionnaire@transport.fr', 'hash_a_remplacer', 'GESTIONNAIRE'),
('Paul Chauffeur', 'chauffeur@transport.fr', 'hash_a_remplacer', 'CHAUFFEUR'),
('Sophie Client', 'client@exemple.fr', 'hash_a_remplacer', 'CLIENT');

INSERT INTO administrateur VALUES (1, 'TOTAL');
INSERT INTO gestionnaire VALUES (2, 'Exploitation');
INSERT INTO chauffeur VALUES (3, 'PERMIS-12345', TRUE);
INSERT INTO client VALUES (4, '12 rue des Lilas, Nantes', '0600000000');
INSERT INTO camion (immatriculation, capacite_kg, ville_actuelle) VALUES ('AB-123-CD', 3500, 'Nantes');
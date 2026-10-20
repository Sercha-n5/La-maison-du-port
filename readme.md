# Application de gestion des transports routiers

## 1. Présentation du projet

L'application permet à une entreprise de transport de gérer ses camions, ses utilisateurs et ses trajets. Elle doit vérifier les règles métier afin d'éviter les erreurs d'affectation des véhicules.

## 2. Les trois types d'utilisateurs

### 2.1. Administrateur

- Gérer les comptes utilisateurs.
- Ajouter, modifier et supprimer les camions.
- Consulter l'ensemble des trajets.
- Gérer les droits d'accès.

### 2.2. Gestionnaire de transport

- Planifier les trajets.
- Affecter les camions aux missions.
- Vérifier la disponibilité des véhicules.
- Consulter les affectations en cours.

### 2.3. Chauffeur

- Consulter les trajets qui lui sont attribués.
- Consulter les informations du camion affecté.
- Consulter les horaires et les lieux de départ et d'arrivée.
- Signaler un problème pendant une mission.

## 3. Les trois règles métier

### Règle 1 : Vérifier la disponibilité du camion

Un camion ne peut pas être affecté à un nouveau trajet s'il est déjà utilisé sur une autre mission pendant la même période.

**Exemple :** un camion effectue un trajet Nantes-Marseille. Il ne peut pas être affecté simultanément à un trajet Nantes-Paris si les horaires des deux missions se chevauchent.

### Règle 2 : Vérifier la cohérence des trajets

Un camion ne peut pas commencer un nouveau trajet depuis une ville où il ne se trouve pas, sauf si un déplacement préalable est prévu.

**Exemple :** si un camion termine sa mission à Marseille, il ne peut pas repartir immédiatement de Nantes sans avoir été repositionné.

### Règle 3 : Vérifier les informations obligatoires

Une mission ne peut pas être validée si les informations indispensables sont absentes : camion, chauffeur, lieu de départ, destination et horaires.

**Exemple :** l'application refuse d'enregistrer une mission sans destination ou sans camion affecté.

## 4. Les risques métier en cas d'indisponibilité de l'application

### 4.1. Panne de réseau

Les utilisateurs ne peuvent plus accéder à l'application ni consulter les dernières affectations.

### 4.2. Erreurs de planification

L'entreprise risque d'affecter un même camion à plusieurs missions ou de planifier des trajets géographiquement incohérents.

### 4.3. Retards de livraison

Les missions peuvent être retardées, ce qui peut entraîner l'insatisfaction des clients et le non-respect des délais contractuels.

### 4.4. Pertes financières

L'entreprise peut subir des pénalités de retard, des frais supplémentaires et une perte de chiffre d'affaires.

### 4.5. Désorganisation du travail

Les gestionnaires et les chauffeurs peuvent manquer d'informations fiables, ce qui complique la coordination des opérations.

## 5. Mesures de prévention

- Mettre en place des sauvegardes régulières.
- Prévoir une procédure de secours en cas de panne.
- Surveiller la disponibilité des serveurs et du réseau.
- Limiter les accès selon les rôles des utilisateurs.
- Tester régulièrement les règles métier.

## 6. Gestion du projet avec Git

Le fichier `README.md` doit être enregistré dans le dépôt Git du projet.

Commandes utilisées :

```bash
git init
git add README.md
git commit -m "Ajout des règles métier et des risques"
```

Le dépôt permet de conserver l'historique des modifications et de travailler en équipe.

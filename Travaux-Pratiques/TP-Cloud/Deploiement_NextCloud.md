# Etape 1 : Installation de la VM Ubuntu et mise à jour du système

Image 1
Image 2
Image 3

Mise à jour du systeme puis redémarrage via ```sudo apt update && sudo apt upgrade -y```
puis ```sudo reboot```

# Étape 2 — Installation des paquets nécessaires
## 2.1 — Serveur web Apache

```sudo apt install apache2 -y```
```sudo systemctl enable apache2```
```sudo systemctl start apache2```

Image 4
Image 5

## 2.2 — PHP et ses extensions

```sudo apt install php php-apcu php-bcmath php-cli php-common php-curl php-gd php-gmp php-imagick php-intl php-mbstring php-mysql php-xml php-zip php-redis php-bz2 libapache2-mod-php -y```

Image 6

## 2.3 — Serveur de base de données MariaDB

```sudo apt install mariadb-server -y```
```sudo systemctl enable mariadb```
```sudo systemctl start mariadb```

Image 7

## 2.4 — Outils complémentaires

```sudo apt install unzip curl wget sudo -y```


# Étape 3 — Sécurisation de MariaDB

Image 8

# Étape 4 — Création de la base de données Nextcloud

sudo mysql -u root -p

On execute les commandes SQL pour définir un mot de passe.

# Étape 5 — Téléchargement de Nextcloud

## 5.1 — Récupérer la dernière version

Image 9

## 5.2 — Extraire et déplacer

```unzip latest.zip```
```sudo mv nextcloud /var/www/html/nextcloud```

## 5.3 — Créer le répertoire de données

Image 10

## 5.4 — Appliquer les permissions

Image 11

# Étape 6 — Configuration d'Apache

## 6.1 — Créer le VirtualHost Nextcloud
Création du fichier de configuration:
```sudo nano /etc/apache2/sites-available/nextcloud.conf```

Image 12

## 6.2 — Activer le site et les modules nécessaires

Image 13

Image 14

# Étape 7 — Configuration PHP recommandée

```sudo nano /etc/php/8.3/apache2/php.ini```

On modifie les valeurs pour s'adapter aux besoin de l'organisme:

Image 15
Image 16
Image 17
Image 18
Image 19

Puis on redémarre le serveur.

# Étape 8 — Installation de Nextcloud via le navigateur

## 8.1 — Accéder à l'interface et remplir le formulaire d'installation

Image 20
Image 21

# Étape 9 — Optimisations post-installation

## 9.1 — Configurer le cache mémoire (APCu + Redis)

Installation de Redis :

```sudo apt install redis-server -y```

Image 22

Édition de la configuration Nextcloud pour utiliser ce cache :

```sudo nano /var/www/html/nextcloud/config/config.php```

Image 23

# 9.2 — Configurer le CRON

```sudo crontab -u www-data -e```
Ajout de la tache planifiée toutes les 5 minutes :

Image 24

Dans l'interface :
Image 25

# Étape 10 — Installation des applications requises

Installation des applications Desk et Tasks, les autres applications étants déja installées.

# Étape 11 — Création des groupes

Création des 5 groupes :

Image 26

# Étape 12 — Création des 15 utilisateurs

Création du compte, alice.martin, on fera la meme chsoe pour les autres utilisateurs :

Image 27

# Étape 13 — Création de l'arborescence de dossiers partagés

## 13.1 — Créer les dossiers racines

Image 28
Puis on crée tous les sous-dossiers.

## 13.3 — Configurer les partages et permissions

Image 29

On procède de la meme manière pour les différents partages en fonction des autorisations.

Par exemple pour le groupe Développement :

Image 30

# Étape 14 — Configuration des conversations Talk

- Création de la conversation Général EduLearn :

Image 31

- Conversation Equipe Dev:
  
Image 32

- Conversation Equipe Pédagogie:

Image 33

- Conversation Direction :

Image 34

# Étape 15 — Création des calendriers partagés

## 15.1 — Créer les calendriers

Dans Agenda, créer nouvel agenda:

Image 35

## 15.2 — Configurer les partages

- Partage Réunions Equipe :

Image 36

- Congés et Absences :

Image 37

- Événements Marketing :
- 
Image 38

# 15.3 — Créer les événements test

- Daily Standup Dev :

Image 39

Image 40

- Rétrospective Sprint :
  
Image 41

# Étape 16 — Création du board Kanban (Deck)

Création du tableau et partage aux différents groupes :

Image 42

Image 43

Image 44

# Étape 17 — Sécurisation (bonnes pratiques)

## 17.1 — Politique de mots de passe

Image 45

## 17.2 — Partage externe sécurisé

Image 46

Image 47

## Étape 18 — Tests de validation
### Test 1 — Isolation des permissions
Le compte hannah.prof a bien accès uniquement au dossier Pédagogie et au dossier commun :

Image 48

### Test 2 — Co-édition bureautique
Les modifications apparaissent bien en temps réel.

### Test 3 — Partage externe avec mot de passe
Création du lien de partage :

Image 49

Le partage fonctionne bien :

Image 50

Image 51

### Test 4 — Visioconférence

La visio conférence fontionne, son et audio.

### Test 5 — Calendrier partagé

Création de l'évenement :

Image 52

L'évenement est bien visible par un autre utilisateur :

Image 53










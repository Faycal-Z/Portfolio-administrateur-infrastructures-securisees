# Etape 1 : Installation de la VM Ubuntu et mise à jour du système

![](images/1.png)
![](images/2.png)
![](images/3.png)

Mise à jour du systeme puis redémarrage via ```sudo apt update && sudo apt upgrade -y```
puis ```sudo reboot```

# Étape 2 — Installation des paquets nécessaires
## 2.1 — Serveur web Apache

```sudo apt install apache2 -y```
```sudo systemctl enable apache2```
```sudo systemctl start apache2```

![](images/4.png)
![](images/5.png)

## 2.2 — PHP et ses extensions

```sudo apt install php php-apcu php-bcmath php-cli php-common php-curl php-gd php-gmp php-imagick php-intl php-mbstring php-mysql php-xml php-zip php-redis php-bz2 libapache2-mod-php -y```

![](images/6.png)

## 2.3 — Serveur de base de données MariaDB

```sudo apt install mariadb-server -y```
```sudo systemctl enable mariadb```
```sudo systemctl start mariadb```

![](images/7.png)

## 2.4 — Outils complémentaires

```sudo apt install unzip curl wget sudo -y```


# Étape 3 — Sécurisation de MariaDB

![](images/8.png)

# Étape 4 — Création de la base de données Nextcloud

sudo mysql -u root -p

On execute les commandes SQL pour définir un mot de passe.

# Étape 5 — Téléchargement de Nextcloud

## 5.1 — Récupérer la dernière version

![](images/9.png)

## 5.2 — Extraire et déplacer

```unzip latest.zip```
```sudo mv nextcloud /var/www/html/nextcloud```

## 5.3 — Créer le répertoire de données

![](images/10.png)

## 5.4 — Appliquer les permissions

![](images/11.png)

# Étape 6 — Configuration d'Apache

## 6.1 — Créer le VirtualHost Nextcloud
Création du fichier de configuration:
```sudo nano /etc/apache2/sites-available/nextcloud.conf```

![](images/12.png)

## 6.2 — Activer le site et les modules nécessaires

![](images/13.png)

![](images/14.png)

# Étape 7 — Configuration PHP recommandée

```sudo nano /etc/php/8.3/apache2/php.ini```

On modifie les valeurs pour s'adapter aux besoin de l'organisme:

![](images/15.png)
![](images/16.png)
![](images/17.png)
![](images/18.png)
![](images/19.png)

Puis on redémarre le serveur.

# Étape 8 — Installation de Nextcloud via le navigateur

## 8.1 — Accéder à l'interface et remplir le formulaire d'installation

![](images/20.png)
![](images/21.png)

# Étape 9 — Optimisations post-installation

## 9.1 — Configurer le cache mémoire (APCu + Redis)

Installation de Redis :

```sudo apt install redis-server -y```

![](images/22.png)

Édition de la configuration Nextcloud pour utiliser ce cache :

```sudo nano /var/www/html/nextcloud/config/config.php```

![](images/23.png)

# 9.2 — Configurer le CRON

```sudo crontab -u www-data -e```
Ajout de la tache planifiée toutes les 5 minutes :

![](images/24.png)

Dans l'interface :

![](images/25.png)

# Étape 10 — Installation des applications requises

Installation des applications Desk et Tasks, les autres applications étants déja installées.

# Étape 11 — Création des groupes

Création des 5 groupes :

![](images/26.png)

# Étape 12 — Création des 15 utilisateurs

Création du compte, alice.martin, on fera la meme chsoe pour les autres utilisateurs :

![](images/27.png)

# Étape 13 — Création de l'arborescence de dossiers partagés

## 13.1 — Créer les dossiers racines

![](images/28.png)

Puis on crée tous les sous-dossiers.

## 13.3 — Configurer les partages et permissions

![](images/29.png)

On procède de la meme manière pour les différents partages en fonction des autorisations.

Par exemple pour le groupe Développement :

![](images/30.png)

# Étape 14 — Configuration des conversations Talk

- Création de la conversation Général EduLearn :

![](images/31.png)

- Conversation Equipe Dev:
  
![](images/32.png)

- Conversation Equipe Pédagogie:

![](images/33.png)

- Conversation Direction :

![](images/34.png)

# Étape 15 — Création des calendriers partagés

## 15.1 — Créer les calendriers

Dans Agenda, créer nouvel agenda:

![](images/35.png)

## 15.2 — Configurer les partages

- Partage Réunions Equipe :

![](images/36.png)

- Congés et Absences :

![](images/37.png)

- Événements Marketing :

![](images/38.png)

# 15.3 — Créer les événements test

- Daily Standup Dev :

![](images/39.png)

![](images/40.png)

- Rétrospective Sprint :
  
![](images/41.png)

# Étape 16 — Création du board Kanban (Deck)

Création du tableau et partage aux différents groupes :

![](images/42.png)

![](images/43.png)

![](images/44.png)

# Étape 17 — Sécurisation (bonnes pratiques)

## 17.1 — Politique de mots de passe

![](images/45.png)

## 17.2 — Partage externe sécurisé

![](images/46.png)

![](images/47.png)

## Étape 18 — Tests de validation

### Test 1 — Isolation des permissions

Le compte hannah.prof a bien accès uniquement au dossier Pédagogie et au dossier commun :

![](images/48.png)

### Test 2 — Co-édition bureautique

Les modifications apparaissent bien en temps réel.

### Test 3 — Partage externe avec mot de passe
Création du lien de partage :

![](images/49.png)

Le partage fonctionne bien :

![](images/50.png)

![](images/51.png)

### Test 4 — Visioconférence

La visio conférence fontionne, son et audio.

### Test 5 — Calendrier partagé

Création de l'évenement :

![](images/52.png)

L'évenement est bien visible par un autre utilisateur :

![](images/53.png)











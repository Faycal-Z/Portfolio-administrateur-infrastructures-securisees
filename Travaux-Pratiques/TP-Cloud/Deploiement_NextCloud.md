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


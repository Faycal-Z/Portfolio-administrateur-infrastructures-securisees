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


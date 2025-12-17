## 1.1 : Création VM et installation :

image 1

Image 2

## 1.2 : Installation de la commande sudo :

- On entre les commandes :
```
apt update
apt install sudo
```

Image 3

- Ajout de l'utilisateur au groupe sudo:
```
usermod -aG sudo faycal
```
Image 4

## 1.3 : Configuration réseau

- Commande ```ip a``` pour récupérer l'adresse IP:

  Image 5

- Ouverture du fichier à modifier via la commande ```sudo nano /etc/network/interfaces``` et modification du fichier :
  
Image 6

- Modification du fichier /etc/hosts :

  sudo nano /etc/hosts

Image 7

Modification dud fichier /etc/hostname :

Image 8

- Redémarrage via la commande sudo reboot, et vérification via la commande ip a :

Image 9

# Étape 2 : Samba
  
- Installation des dépendances  
On confirme le royaume par défault :

Image 9

On choisi le serveur Kerberos, ainsi que le serveur administratif :

Image 10

Image 11

On installe les dernières dépendances via la commande ```sudo apt install python3-dev liblmdb-dev flex bison libgpgme11-dev libparse-yapp-perl libjansson-dev libarchive-dev libdbus-1-dev python3-pyasn1 python3-markdown python3-dnspython libjson-perl python3-iso8601```.

Télechargement et compilation de SAMBA:
Via les commandes suivantes
```wget http://ftp.samba.org/pub/samba/samba-latest.tar.gz```
tar zxvf samba-latest.tar.gz
cd samba-x.x.x
./configure --enable-debug --enable-selftest ```

Image 12

La configuration est bien terminée :

Image 13

On peut lancer l'installation :

``` make ```, on patiente puis :
``` sudo make install ```

Image 14

## 2.2 : Contrôleur de domaine

Il n'ya pas de fichier de conf (smb.conf) dans le dossier /usr/local/samba/etc :

Image 15

Configuration du serveur en tant que controleur du domaine :

```sudo /usr/local/samba/bin/samba-tool domain provision```

Image 16

Et on lance le reboot.

## 2.3 : Premier démarrage et test

Les versions du serveur et du client sont identiques :

Image 17

Les partages de base netlogon et sysvol sont bien présents :

Image 18

On se connecte via la commande ```/usr/local/samba/bin/smbclient //localhost/netlogon -UAdministrator```, on peut désormais se connecter :

Image 19

# Étape 3 : configuration



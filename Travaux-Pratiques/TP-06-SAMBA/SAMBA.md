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
```wget http://ftp.samba.org/pub/samba/samba-latest.tar.gz
tar zxvf samba-latest.tar.gz
cd samba-x.x.x
./configure --enable-debug --enable-selftest ```

Image 12

La configuration est bien terminée :

Image 13

On peut lancer l'installation :

``` make
sudo make install ```





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

## 3.1 : Configuration DNS

Modification du fichier fichier /etc/resolv.conf :

``` sudo nano /etc/resolv.conf ```

Image 20

Image 21

Modification du fichier krb5.conf via la commande ```sudo nano /usr/local/samba/share/setup/krb5.conf ``` :

Image 22

Création du lien symbolique depuis cette config vers /etc via la commande ```sudo ln -sf /usr/local/samba/share/setup/krb5.conf /etc/krb5.conf```
Puis on reboot.

## 3.2 : Tester Kerberos

On relance SAMBA et on teste la connexion : 

Image 23

On désactive l'expiration du mot de passe :

Image 24

## 3.3 : Configuration NTP

Configuration du service NTP via la commande ```sudo nano /etc/ntpsec/ntp.conf```, on modifie ainsi le contenu :

Image 25

Et on redémarre le daemon via la commande sudo ```systemctl restart ntp```.

## 3.4 : Zone inversée DNS

Création de la zone inverssée avec la commande ```sudo /usr/local/samba/bin/samba-tool dns zonecreate debianSRV 0.0.10.in-addr.arpa --username=administrator```

Image 26

# Étape 4 : clients Windows

Installation et configuration de la VM Windows :

Image 27

On ping bien notre serveur : 

Image 28

On ajoute l'ordinateur au domaine :

Image 29

Image 30

On redémarre.

On peut bien se connecter au domaine :

Image 31

Image 32

# 4.2 : Outils RSAT

Ajout de la fonctionnalité RSAT :

Image 33

Image 34

Image 35

Dans la console mmc :

Image 36

Image 37

Image 38

Ajout d'un nouvel utilisateur :

Image 39

Image 40

Image 41

Image 42


# 4.3 : Partage Samba

Modification du fichier de configuration :

Image 43

On repere le processus :

Image 45

On tue le processus :

Image 46

Et on relance SAMBA via la commande ```sudo /usr/local/samba/sbin/samba```

On crée le dossier de partage et on modifie les permissions :

Image 47

Image 48

On accède bien au partage via la VM Windows :

Image 49

Création de l'Unité d'Organisation : 

Image 50

Et on déplace l'utilisateur crée dans L'UO Aldebaran :

Image 51

On crée la GPO :

Image 52

Image 53

Image 54

On paramètre la GPO :

Image 55

On spécifie l'emplacement du dossier, et la lettre P :

Image 56

Le lecteur apparait bien :

Image 57

Vérification sur la session de l'utilisateur Jean Arc :

Image 58

Le lecteur P apparait bien.

# Bonus : création d'un service Systemd

On crée le fichier de service :

```sudo nano /etc/systemd/system/samba-ad-dc.service```

On rempli la fiche : 

Image 59

On actualise, on active le service :

Image 60

Image 61

Après redémarrage le lecteur P est bien disponible:

Image 62




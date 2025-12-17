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
  
  

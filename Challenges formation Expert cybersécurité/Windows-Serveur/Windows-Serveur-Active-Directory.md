# Consignes🗒️:
### Objectif de ce challenge : réussir à installer Windows Serveur (2022 ou 2025) sur une VM Proxmox !
Il faudra également ajouter le rôle Active Directory et promouvoir votre serveur en contrôleur de domaine.
Une fois que c’est fait, créez un ou deux utilisateurs (dans une OU « Utilisateurs », par exemple) puis essayez de rejoindre le domaine depuis une VM Windows 10 et essayez ensuite de vous connecter avec l’un de vos utilisateurs !

---

# Installation de Windows Serveur 2022 et configuration du nom de la machine:
Image 1 et 2

# Ajout d'une IP statique au serveur: 
Image3

# Ajout du role AD DS:
Dans gérer, ajouter des roles et fonctionnalités, j'ai choisi AD DS, j'ai créé une nouvelle foret que j'ai nommé le domaine "mondomaine.lan", ensuite le serveur à redémarré.
Image4

# J'ai choisis promovoir en controleur de domaine, puis j'ai configuré une machine client que j'ai renommée "WIN10CLIENT1:
Image5

# Configuration du DNS (et adresses IP en DHCP), la machine client ping bien le serveur:
Image6
Image7

# Ajout de la machine client au domaine "mondomaine.lan":
Image8
Image9
Image10

# Ajout d'une unité d'organisation UO_Utilisateurs et création de deux utilisateurs Alice MArtin et Bob Dupont:
Image11

Par mesure de sécurité j'ai activé l'option "changer le mot de passe à la prochaine connexion":
Image13

# Les utilisateurs ont bien été ajoutés au domaine, et l'ordinateur client apparait bien dans le dossier Computeurs du controleur de domaine:

Image 14
Image15
Image16








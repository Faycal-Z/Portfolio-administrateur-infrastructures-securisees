# Consignes🗒️:
### Objectif de ce challenge : réussir à installer Windows Serveur (2022 ou 2025) sur une VM Proxmox !
Il faudra également ajouter le rôle Active Directory et promouvoir votre serveur en contrôleur de domaine.
Une fois que c’est fait, créez un ou deux utilisateurs (dans une OU « Utilisateurs », par exemple) puis essayez de rejoindre le domaine depuis une VM Windows 10 et essayez ensuite de vous connecter avec l’un de vos utilisateurs !

---

# Installation de Windows Serveur 2022 et configuration du nom de la machine:

Une fois le serveur installé, renommer le PC:
![Windows-Serveur](./images/1.png)

![Windows-Serveur](./images/2.png)

# Ajout d'une IP statique au serveur: 

![IP](./images/3.png)

# Ajout du role AD DS:

Dans gérer, ajouter des roles et fonctionnalités, j'ai choisi AD DS, j'ai créé une nouvelle foret que j'ai nommée "mondomaine.lan", ensuite le serveur à redémarré.

![AD-DS](./images/4.png)

# J'ai choisis "promovoir en controleur de domaine", puis j'ai configuré une machine client que j'ai renommée "WIN10CLIENT1:

![Windows-Serveur](./images/5.png)

# Configuration du DNS (et adresses IP en DHCP de la machine client), la machine client ping bien le serveur:

![DNS](./images/6.png)
![PING](./images/7.png)

# Ajout de la machine client au domaine "mondomaine.lan":

![Windows-Serveur](./images/8.png)
![Windows-Serveur](./images/9.png)
![Windows-Serveur](./images/10.png)

# Ajout d'une unité d'organisation UO_Utilisateurs et création de deux utilisateurs Alice Martin et Bob Dupont:

![Utilisateurs](./images/11.png)

Par mesure de sécurité j'ai activé l'option "changer le mot de passe à la prochaine connexion":

![Connexion](./images/12.png)
![Connexionr](./images/13.png)

# Les utilisateurs ont bien été ajoutés au domaine, et l'ordinateur client apparait bien dans le dossier Computeurs du controleur de domaine:

![Windows-Serveur](./images/14.png)
![Windows-Serveur](./images/15.png)
![Windows-Serveur](./images/16.png)







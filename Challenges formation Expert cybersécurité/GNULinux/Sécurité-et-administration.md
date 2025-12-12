# Consignes 🗒️:

Pour pratiquer les notions du jour, votre mission est d’installer une VM Rocky Linux (le successeur de CentOS, la version communautaire de Red Hat Entreprise Linux).

Sur cette VM, vous devez :

créer un nouvel utilisateur
permettre à cet utilisateur de lancer des commandes avec sudo
faire en sorte qu’aucun mot de passe ne soit demandé pour lancer la commande rpm
créer un groupe, mettre le nouvel utilisateur et l’utilisateur créé lors de l’installation dans ce groupe
créer un dossier /home/partage_fichier et modifier ses permissions pour que les membres du groupe créé précédemment aient les droits de lecture et d’écriture, mais qu’aucun autre utilisateur du système n’y ait accès.
créer un dernier utilisateur et vérifier qu’il n’a pas accès au dossier créé précédemment

----

# Installation de la VM :

![VM](./images/1.png)

![VM](./images/2.png)

![VM](./images/3.png)

![VM](./images/4.png)


# Création du nouvel utilisateur :

![Ip](./images/5.png)

# Permettre à l'utilisateur d'utiliser les commandes sudo :

![Sudo](./images/6.png)

# Ne pas demander de mot de passe pour lancer la commande rpm :

![Rpm](./images/7.png)

# Création du groupe, ajout du nouvel utilisateur et de l'utilisateur crée à l'installation :

![Groupe](./images/9.png)

![Groupe](./images/10.png)

# Création du dossier partagé et modification des permissions :

![Dossier-permission](./images/11.png)

# Vérification via la création d'un nouvel utilisateur alice :

![Utilisateur](./images/12.png)

![Utilisateur](./images/13.png)

# On constate que le nouvel utilisateur n'a pas accès au dossier partagé.



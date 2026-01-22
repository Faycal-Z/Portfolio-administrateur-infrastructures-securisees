# Création des conteneurs Ubuntu :

![Conteneur-Ubuntu](images/1.png)
Image 2


# Etape 1 : Installation du Nagios Core

## **Étape 1.1 : Mise à jour de votre système**

Image 3
Image 4

## Étape 1.2 : Installation des dépendances

Image 5

## Étape 1.3 : Téléchargement de Nagios Core 4.5.11

Image 6

## Étape 1.4 : Décompression de l'archive et installation de Nagios Core

Image 7

Image 8

Création d'un utilisateur nagios et ajout au groupe nagcmd:

Image 9

Compilation et installation de Ngaios Core :

Image 10

Voici la configuration :

Image 11

On lance l'installation avec la commande ````make all````

Image 12

On installe Nagios et les fichiers de configuration :

Image 13

Image 14

Image 15

Image 16

Image 17

## Étape 1.5 : Installation de l'interface web de Nagios

Image 18

On active le module Apache :

Image 19

## Étape 1.6 : Création d'un utilisateur Nagios pour l'accès à l'interface web

Image 20

## Étape 1.7 : Démarrage de Nagios

Image 21

## Étape 1.8 : Vérification du bon fonctionnement de Nagios

Connexion à l'interface web Nagios :

Image 22

Image 23

Image 24

Il est maintenant nécessaire d'installer les plugins.

## Étape 1.9 : Installation des plugins

Image 25

Image 26

Image 27

`````make````
````make install````

On voit la liste des fichiers exécutables : 

Image 28

Image 29

## Étape 1.9 : Configuration du pare-feu (facultatif)

Image 30


# Étape 2 : Installation de l'Agent NCPA sur une VM Windows Client/Server

## 2.1 : Télécharger l'agent NCPA pour Windows

Image 31

## 2.2 : Installation de l'Agent NCPA

Image 32

Image 33

Image 34

Image 35

Image 36

## 2.3 : Vérification de l'installation de NCPA

Image 37

## 2.4 : Configuration du pare-feu Windows (facultatif)

Image 38

## 2.5 : Test de l'agent NCPA

Image 39

Image 40

## 2.6 : Configuration de NCPA sur le serveur Nagios

Création d'in fichier de configuration :

Image 41

On ajoute la configuration : 

Image 42

On sauvegarde et on relance Nagios.

On modifie le fichier de configuration Nagios :

Image 43

Dans /usr/local/nagios/etc/nagios.cfg on décommente la ligne #cfg_dir=/usr/local/nagios/etc/servers :

Image 44

Et on redémarre le serveur Nagios.

## 2.7 : Vérification dans l'interface Web de Nagios

Apres autorisation du ping sur la machine Windows, le serveur Windows est bien ajouté :

Image 45

Image 46


Étape 3 : Installation de l'Agent NCPA sur un Nouveau Serveur Ubuntu 24

## 3.1 : Télécharger l'agent NCPA pour Ubuntu

Image 47


## 3.2 : Installation de NCPA sur Ubuntu

Image 48

## 3.3 : Configuration de NCPA sur Ubuntu

On modifie le fichier de configuration pour indiquer notre mot de passe, il faut normalement indiqué un mot de passe sécurisé mais ici il s'agit d'un lab :

Image 49

On ouvre le port :

Image 50

On démarre le service NCPA :

Image 51

Le service est bien actif :

Image 52

## 3.4 : Tester l'interface Web de NCPA

On constate que l'agent fonctionne correctement :

Image 53

## 3.5 : Configuration de NCPA pour Nagios

Image 54

On ajoute la configuration :

Image 55

Installation du script check_ncpa.py :

Image 56

Image 57

## 3.6 : Vérification de la surveillance dans l'interface Web de Nagios

Le serveur Ubuntu et ses services sont maintenant surveillés :

Image 58




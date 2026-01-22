# Déploiement d'une Solution de Supervision Nagios Core

# Création des conteneurs Ubuntu :

![Conteneur-Ubuntu](images/1.png)
![Conteneur-Ubuntu](images/2.png)


# Etape 1 : Installation du Nagios Core

## **Étape 1.1 : Mise à jour de votre système**

![Mise-a-jour](images/3.png)
![Mise-a-jour](images/4.png)

## Étape 1.2 : Installation des dépendances

![Dépendances](images/5.png)

## Étape 1.3 : Téléchargement de Nagios Core 4.5.11

![Nagios-telechargement](images/6.png)

## Étape 1.4 : Décompression de l'archive et installation de Nagios Core

![Installation](images/7.png)

![Installation](images/8.png)

Création d'un utilisateur nagios et ajout au groupe nagcmd:

![Utilisateur](images/9.png)

Compilation et installation de Nagios Core :

![Nagios-core](images/10.png)

Voici la configuration :

![Configuration](images/11.png)

On lance l'installation avec la commande ````make all````

![Make-all](images/12.png)

On installe Nagios et les fichiers de configuration :

![Installation](images/13.png)

![Installation](images/14.png)

![Installation](images/15.png)

![Installation](images/16.png)

![Installation](images/17.png)

## Étape 1.5 : Installation de l'interface web de Nagios

![Installation-interface](images/18.png)

On active le module Apache :

![Apache](images/19.png)

## Étape 1.6 : Création d'un utilisateur Nagios pour l'accès à l'interface web

![Utilisateur](images/20.png)

## Étape 1.7 : Démarrage de Nagios

![Démarrage](images/21.png)

## Étape 1.8 : Vérification du bon fonctionnement de Nagios

Connexion à l'interface web Nagios :

![Nagios](images/22.png)

![Nagios](images/23.png)

![Nagios](images/24.png)

Il est maintenant nécessaire d'installer les plugins.

## Étape 1.9 : Installation des plugins

![Plugins](images/25.png)

![Plugins](images/26.png)

![Plugins](images/27.png)

```make```

```make install```

On voit la liste des fichiers exécutables : 

![Fichiers](images/28.png)

![Fichiers](images/29.png)

## Étape 1.9 : Configuration du pare-feu (facultatif)

![Par-feu](images/30.png)


# Étape 2 : Installation de l'Agent NCPA sur une VM Windows Client/Server

## 2.1 : Télécharger l'agent NCPA pour Windows

![Telechargement-agent](images/31.png)

## 2.2 : Installation de l'Agent NCPA

![Installation-agent](images/32.png)

![Installation-agent](images/33.png)

![Installation-agent](images/34.png)

![Installation-agent](images/35.png)

![Installation-agent](images/36.png)

## 2.3 : Vérification de l'installation de NCPA

![Installation-NCPA](images/37.png)

## 2.4 : Configuration du pare-feu Windows (facultatif)

![Par-feu](images/38.png)

## 2.5 : Test de l'agent NCPA

![Test-agent](images/39.png)

![Test-agent](images/40.png)

## 2.6 : Configuration de NCPA sur le serveur Nagios

Création d'in fichier de configuration :

![Configuration-NCPA](images/41.png)

On ajoute la configuration : 

![Configuration-NCPA](images/42.png)

On sauvegarde et on relance Nagios.

On modifie le fichier de configuration Nagios :

![Configuration-Nagios](images/43.png)

Dans ```/usr/local/nagios/etc/nagios.cfg``` on décommente la ligne ```#cfg_dir=/usr/local/nagios/etc/servers``` :

![Configuration-Nagios](images/44.png)

Et on redémarre le serveur Nagios.

## 2.7 : Vérification dans l'interface Web de Nagios

Apres autorisation du ping sur la machine Windows, le serveur Windows est bien ajouté :

![Windows](images/45.png)

![Windows](images/46.png)


# Étape 3 : Installation de l'Agent NCPA sur un Nouveau Serveur Ubuntu 24

## 3.1 : Télécharger l'agent NCPA pour Ubuntu

![Telechargement-agent](images/47.png)


## 3.2 : Installation de NCPA sur Ubuntu

![Installation-NCPA](images/48.png)

## 3.3 : Configuration de NCPA sur Ubuntu

On modifie le fichier de configuration pour indiquer notre mot de passe, il faut normalement indiqué un mot de passe sécurisé mais ici il s'agit d'un lab :

![Configuration-NCPA](images/49.png)

On ouvre le port :

![Configuration-NCPA](images/50.png)

On démarre le service NCPA :

![Configuration-NCPA](images/51.png)

Le service est bien actif :

![NCPA](images/52.png)

## 3.4 : Tester l'interface Web de NCPA

On constate que l'agent fonctionne correctement :

![Agent](images/53.png)

## 3.5 : Configuration de NCPA pour Nagios

![Configuration-NCPA](images/54.png)

On ajoute la configuration :

![Configuration](images/55.png)

Installation du script check_ncpa.py :

![Configuration-NCPA](images/56.png)

![Configuration-NCPA](images/57.png)

## 3.6 : Vérification de la surveillance dans l'interface Web de Nagios

Le serveur Ubuntu et ses services sont maintenant surveillés :

![Configuration-NCPA](images/58.png)




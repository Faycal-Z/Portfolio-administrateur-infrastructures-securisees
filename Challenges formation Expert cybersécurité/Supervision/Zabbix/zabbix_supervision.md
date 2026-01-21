

Configuration d'un conteneur Debian 12:

Image 1


Le ping vers le serveur Zabbix fonctionne bien :

Image 2

L'adresse IP est bien celle définie 10.0.0.90 :

Image 3

Mise à jour du système:

apt update
apt upgrade -y

Installation du service web:

Image 4
Image 5

Le serveur client est bien accessible :

Image 6



ETAPE 2

Ajout du dépôt Zabbix :

Image 7

Image 8

Image 9

Installation de l'agent Zabbix 2 :

Image 10

Edition du fichier de configuration :

Image 11

Image 12

Image 13

Image 14

'''systemctl restart zabbix-agent2'''
'''systemctl enable zabbix-agent2'''
'''systemctl status zabbix-agent2'''

L'agent est bien démarré :

Image 15

L'agent attend bien les connexions :

Image 16


Déclarer le serveur client dans Zabbix, via l'interface :

Image 17

L'hote est bien disponible :

Image 18

Création d'un nouveau Dashboard :

Image 19

Image 20

Ajout des widgets CPU, Mémoire, Disponibilité et Problèmes actifs :

Image 21
Image 22
Image 23
Image 24


## Surveillance Critique de Fichiers :

Afin d'aller au-delà de la supervision standard (CPU/RAM), j'ai mis en place une règle de surveillance personnalisée.

**Objectif** : Détecter immédiatement la suppression accidentelle ou malveillante d'un fichier sensible (simulé ici par `C:\test.txt`) et lever une alerte critique.

### 1. Configuration de l'Item (Le Capteur)
Création d'un item utilisant la clé native de l'agent Zabbix pour interroger le système de fichiers.
* **Key** : `vfs.file.exists[C:\test.txt]`
* **Logique** : Retourne `1` si le fichier est présent, `0` s'il est absent.
* **Intervalle** : 30s pour une réactivité élevée (test).

![Configuration de l'Item Zabbix](Image 25)

### 2. Configuration du Trigger (L'Alerte)
Mise en place d'un déclencheur avec une sévérité "High". L'expression vérifie la dernière valeur remontée par l'agent.
* **Expression** : `last(/DESKTOP-ARH9T3V/vfs.file.exists[C:\test.txt])=0`
* **Condition** : L'alerte se déclenche uniquement lorsque la valeur passe à 0 (fichier manquant).

![Définition de la condition du Trigger](Image 26)
![Finalisation du Trigger](Image 27)

### 3. Simulation d'Incident et Résolution
Test effectué sur la VM Windows :

**Phase 1 : Incident**
Suppression manuelle du fichier cible. Zabbix détecte l'anomalie et passe le statut en **PROBLEM** (Sévérité High).
![Déclenchement de l'alerte](Image 28)

**Phase 2 : Retour à la normale**
Restauration du fichier. Zabbix détecte la présence du fichier au scan suivant et clôture automatiquement l'incident (**RESOLVED**).
![Résolution automatique de l'incident](Image 29)


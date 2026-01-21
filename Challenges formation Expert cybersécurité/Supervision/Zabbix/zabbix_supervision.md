

Configuration d'un conteneur Debian 12:

![Conteneur](images/1a.png)


Le ping vers le serveur Zabbix fonctionne bien :

![Ping](images/2a.png)

L'adresse IP est bien celle définie 10.0.0.90 :

![IP](images/3a.png)

Mise à jour du système:

apt update
apt upgrade -y

Installation du service web:

![Apache](images/4a.png)
![Apache](images/5a.png)

Le serveur client est bien accessible :

![Serveur-client](images/6a.png)


Ajout du dépôt Zabbix :

![Zabbix](images/7a.png)

![Zabbix](images/8a.png)

![Zabbix](images/9a.png)

Installation de l'agent Zabbix 2 :

![Agent](images/10a.png)

Edition du fichier de configuration :

![Configuration](images/11a.png)

![Configuration](images/12a.png)

![Configuration](images/13a.png)

![Configuration](images/14a.png)

'''systemctl restart zabbix-agent2'''
'''systemctl enable zabbix-agent2'''
'''systemctl status zabbix-agent2'''

L'agent est bien démarré :

![Agent](images/15a.png)

L'agent attend bien les connexions :

![Agent](images/16a.png)



Déclarer le serveur client dans Zabbix, via l'interface :

![Interface](images/17a.png)


L'hote est bien disponible :

![Hote](images/18a.png)


Création d'un nouveau Dashboard :

![Agent](images/19a.png)

![Agent](images/20a.png)


Ajout des widgets CPU, Mémoire, Disponibilité et Problèmes actifs :

![Widgets](images/21a.png)
![Widgets](images/22a.png)
![Widgets](images/23a.png)
![Widgets](images/24a.png)



## Surveillance Critique de Fichiers :

Afin d'aller au-delà de la supervision standard (CPU/RAM), j'ai mis en place une règle de surveillance personnalisée.

**Objectif** : Détecter immédiatement la suppression accidentelle ou malveillante d'un fichier sensible (simulé ici par `C:\test.txt`) et lever une alerte critique.

### 1. Configuration de l'Item (Le Capteur)
Création d'un item utilisant la clé native de l'agent Zabbix pour interroger le système de fichiers.
* **Key** : `vfs.file.exists[C:\test.txt]`
* **Logique** : Retourne `1` si le fichier est présent, `0` s'il est absent.
* **Intervalle** : 30s pour une réactivité élevée (test).

![Item-Zabbix](images/25a.png)

### 2. Configuration du Trigger (L'Alerte)
Mise en place d'un déclencheur avec une sévérité "High". L'expression vérifie la dernière valeur remontée par l'agent.
* **Expression** : `last(/DESKTOP-ARH9T3V/vfs.file.exists[C:\test.txt])=0`
* **Condition** : L'alerte se déclenche uniquement lorsque la valeur passe à 0 (fichier manquant).

![Trigger](images/26a.png)
![Trigger](images/27a.png)

### 3. Simulation d'Incident et Résolution
Test effectué sur la VM Windows :

**Phase 1 : Incident**
Suppression manuelle du fichier cible. Zabbix détecte l'anomalie et passe le statut en **PROBLEM** (Sévérité High).
![Alerte](images/28a.png)

**Phase 2 : Retour à la normale**
Restauration du fichier. Zabbix détecte la présence du fichier au scan suivant et clôture automatiquement l'incident (**RESOLVED**).
![Resolved](images/29a.png)


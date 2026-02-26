Étape 1 : Installer Suricata (IDS/IPS)

Créer la machine Suricata (CT) :

Image 1

Mise à jour et installation de suricata :

```apt update && apt upgrade -y```
```apt install -y suricata suricata-update```

Image 2

Étape 1.5 : Configurer Suricata

```nano /etc/suricata/suricata.yaml```

Image 3

Image 4

Étape 1.6 : Télécharger les règles

```suricata-update```

Image 5

Étape 1.7 : Démarrer Suricata

Image 6

Image 7

Étape 2 : Générer un événement de test

Étape 2.1 : Déclencher une règle connue

```apt install curl -y```
```curl http://testmynids.org/uid/index.html```

Image 8

Étape 2.2 : Vérifier l'alerte dans les logs

Installation de jq :

Image 9

Verification des alertes :

```cat /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'```

Image 10

Log simplifié :

Image 11

Étape 3 : Installer Wazuh (SIEM)

Image 12

Étape 3.3 : Configurer le réseau

Image 13

Les ping fonctionnent :

Image 14

Étape 3.4 : Installer Wazuh (tout-en-un)

```su -```
```curl -sO https://packages.wazuh.com/4.14/wazuh-install.sh```
```sudo bash ./wazuh-install.sh -a```

image 15

Étape 3.5 : Vérifier les services

Image 16

Image 17

Iamge 18

Étape 3.6 : Accéder à l'interface web

Image 19

Étape 4 : Connecter les sources

Étape 4.1 : Installer l'agent Wazuh sur Suricata

```apt install gpg -y```

```curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg```

```echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list```

```apt update```

```WAZUH_MANAGER="10.0.0.40" apt install -y wazuh-agent```

Activation et démarrage de l'agent :

Image 20

Étape 4.2 : Vérifier la connexion de l'agent

Image 21

Image 22

Étape 4.3 : Configurer la collecte des logs Suricata

Configuration de l'agent :

```nano /var/ossec/etc/ossec.conf```

Image 23

Image 24

Étape 4.5 : (Optionnel) Installer un agent sur Win11

Téléchargement de l'agent :

Image 25

Image 26

Image 27

Étape 5 : Valider la détection de bout en bout
Étape 5.1 : Provoquer un événement de test

Image 28

Étape 5.2 : Vérifier l'alerte locale (Suricata)

L'alerte est bien présente :

Image 29

Étape 5.3 : Vérifier l'alerte dans Wazuh

La chaine de detection est bien complète :

Image 30










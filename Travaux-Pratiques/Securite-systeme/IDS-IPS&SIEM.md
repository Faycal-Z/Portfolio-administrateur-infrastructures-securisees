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









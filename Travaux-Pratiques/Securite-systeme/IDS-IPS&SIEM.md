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







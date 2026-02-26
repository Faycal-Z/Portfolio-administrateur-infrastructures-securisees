# Étape 1 : Installer Suricata (IDS/IPS)

Créer la machine Suricata (CT) :

![](images/1.png)

Mise à jour et installation de suricata :

```apt update && apt upgrade -y```
```apt install -y suricata suricata-update```

![](images/2.png)

## Étape 1.5 : Configurer Suricata

```nano /etc/suricata/suricata.yaml```

![](images/3.png)

![](images/4.png)

![](images/5.png)

## Étape 1.6 : Télécharger les règles

```suricata-update```

![](images/6.png)

Étape 1.7 : Démarrer Suricata

![](images/7.png)

# Étape 2 : Générer un événement de test

## Étape 2.1 : Déclencher une règle connue

```apt install curl -y```
```curl http://testmynids.org/uid/index.html```

![](images/9.png)

![](images/8.png)

## Étape 2.2 : Vérifier l'alerte dans les logs

Installation de jq :

![](images/10.png)

Verification des alertes :

```cat /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'```

![](images/11.png)

Log simplifié :

![](images/12.png)

# Étape 3 : Installer Wazuh (SIEM)

![](images/13.png)

## Étape 3.3 : Configurer le réseau

![](images/14.png)

Les ping fonctionnent :

![](images/15.png)

## Étape 3.4 : Installer Wazuh (tout-en-un)

```su -```
```curl -sO https://packages.wazuh.com/4.14/wazuh-install.sh```
```sudo bash ./wazuh-install.sh -a```

![](images/16.png)

## Étape 3.5 : Vérifier les services

![](images/17.png)

![](images/18.png)

![](images/19.png)

## Étape 3.6 : Accéder à l'interface web

![](images/20.png)

# Étape 4 : Connecter les sources

## Étape 4.1 : Installer l'agent Wazuh sur Suricata

```apt install gpg -y```

```curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg```

```echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list```

```apt update```

```WAZUH_MANAGER="10.0.0.40" apt install -y wazuh-agent```

Activation et démarrage de l'agent :

![](images/21.png)

## Étape 4.2 : Vérifier la connexion de l'agent

![](images/22.png)

![](images/23.png)

## Étape 4.3 : Configurer la collecte des logs Suricata

Configuration de l'agent :

```nano /var/ossec/etc/ossec.conf```

![](images/24.png)

![](images/25.png)

## Étape 4.5 : (Optionnel) Installer un agent sur Win11

Téléchargement de l'agent :

![](images/26.png)

![](images/27.png)

![](images/28.png)

# Étape 5 : Valider la détection de bout en bout

## Étape 5.1 : Provoquer un événement de test

![](images/29.png)

## Étape 5.2 : Vérifier l'alerte locale (Suricata)

L'alerte est bien présente :

![](images/30.png)

## Étape 5.3 : Vérifier l'alerte dans Wazuh

La chaine de detection est bien complète :

![](images/31.png)

# Bonus : Règle personnalisée et corrélation

## B.1 : Créer une règle Suricata personnalisée

![](images/32.png)

## B.2 : Activer la règle

```nano /etc/suricata/suricata.yaml```

![](images/33.png)

```systemctl restart suricata```

![](images/34.png)

## B.3 : Déclencher la règle personnalisée

On envoi une requete de puis une machine windows :

```curl http://10.0.0.50/SuperSecret2025```

L'alerte est bien déclanchée dans suricata:

![](images/35.png)

## B.4 : Vérifier dans Suricata

```cat /var/log/suricata/eve.json | jq 'select(.alert.signature_id==1000001)'```

![](images/36.png)

## B.5 : Vérifier la corrélation dans Wazuh

L'alerte est bien présente dans le dashboard wazuh :

![](images/37.png)











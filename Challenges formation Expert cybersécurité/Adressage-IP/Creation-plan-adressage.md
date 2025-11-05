# Consignes 🗒️

Vous êtes recruté par une grande entreprise qui souhaite refaire complètement son réseau informatique.

L’entreprise est basé sur plusieurs sites : Montpellier et Bordeaux.

Sur Montpellier, le parc est composé de :

- 200 PC fixes
- 70 PC portables
- 20 serveurs
- 15 copieurs
  
Sur Bordeaux, le parc est composé de :

- 100 PC fixes
- 40 PC portables
- 5 serveurs
- 5 copieurs
  
Sur les deux sites, il faudra deux réseaux WiFi :

- un public, pour les visiteurs
- un privé, pour les PC portables des collaborateurs (quand ceux-ci ne seront pas connecté en filaire)
Pour des raisons de sécurité, l’entreprise souhaite que les machines soient cloisonnées dans des sous-réseaux indépendants.

Pour chaque site, il faut donc un sous-réseau pour :

- les PC fixes ou portables en filaire
- les serveurs
- les copieurs
- le WiFi public
- le WiFi privé
Proposez un plan d’adressage permettant de répondre à ce besoin !

Mais attention ⚠️
Vous devez, pour vos différents sous-réseaux, utiliser les réseaux privés de la RFC 1918.

On en reparlera de l’utilité de ces adresses et de cette RFC bientôt, mais en attendant, un petit tour sur la page wikipédia nous indique qu’on peut utiliser les plages d’adresses ci-dessous :

10.0.0.0/8	10.0.0.0 – 10.255.255.255	
172.16.0.0/12	172.16.0.0 – 172.31.255.255	
192.168.0.0/16	192.168.0.0 – 192.168.255.255
💡 Vous pouvez redécouper les plages ci-dessus, par exemple avoir un sous-réseau en 192.168.1.0/24 et un autre en 192.168.2.0/24. Seul impératif : vos sous-réseaux ne doivent pas se chevaucher !

Chaque sous-réseau doit être au format X.X.X.X/Y (par exemple, 192.168.1.0/24)
Précisez aussi le nombre d’adresses utilisables pour des machines sur chaque sous-réseau !

---

# J’ai commencé par noter les besoins pour le site de Montpellier: 
On a d’abord besoin de 270 hôtes pour les PC reliés en filaires (200 + 70), de 20 serveurs et 15 copieurs. Pour le réseau wifi privé on prévoit au moins le même nombre de PC portables (70 hôtes), j’ai donc choisi 100 hôtes et pour le réseau public 50 hôtes.
Par ordre :
- 270 hôtes pour les PC filaires
- 100 hôtes pour le Wifi privé
- 50 hôtes pour le Wifi publique
- 20 hôtes pour les serveurs
- 15 hôtes pour les copieurs

## Calcul des sous réseaux et des adresses utilisables en utilisant les réseaux privés de la RFC 1918 :
- Pour les PC filaires, l’adresse de sous réseau 192.168.0.0/23 répond au besoin de 512 adresses, soit plus de 270 hôtes (2^9=512 et 32-9). Le nombre d’adresses utilisables sera 512-2 car on garde l’adresse de réseau (première) et l’adresse de broadcast (dernière).
- Pour le Wifi privé : Adresse de sous réseau 192.168.2.0/25 (car la prochaine adresse disponible est 192.168.2.0 et 32-7) et 126 adresses utilisables (128-2). Dernière adresse IP utilisable 192.168.2.127
- Pour le Wifi Publique : 192.168.2.128/26 et 62 adresses utilisables (64-2).
- Pour les serveurs : 192.168.2.192/27 (192.168.2.192 obtenu en additionnant 128 et 64) et 30 adresses utilisables.
- Pour les copieurs : 192.168.2.224/27 et 30 adresses utilisables.

# J’applique la meme methode pour le site de Bordeaux :
- PC filaires : 140 hotes
- Wifi privé : 50 hotes
- Wifi publique : 50 hotes
- Serveurs : 5 hotes
- Copieurs : 5 hotes

## Calcul des sous réseaux et des adresses utilisables pour le site de Bordeaux: 

- Pc filaires : 172.16.0.0/24 et 254 adresses utilisables.
- Wifi privé : 172.16.1.0/26 et 62 adresses utilisables.
- Wifi public : 172.16.1.64/26 et 62 adresses utilisables.
- Serveurs : 172.16.1.128/29 et 6 adresses utilisables.
- Copieurs : 172.16.1.136/29 et 6 adresses utilisables.
---

# Voici le plan d’adressage complet :
- Montpellier/PC    :  192.168.0.0/23 (510 adresses)
- Montpellier/SRV   :   192.168.2.192/27 (30 adresses)
- Montpellier/COPY  : 192.168.2.224/27      (30 adresses)
- Montpellier/pubW  : 192.168.2.128/26  (62 adresses) 
- Montpellier/privW : 192.168.2.0/25 (126 adresses)


- Bordeaux/PC       : 172.16.0.0/24 (254 adresses)
- Bordeaux/SRV      :  172.16.1.128/29 (6 adresses)
- Bordeaux/COPY     : 172.16.1.136/29 (6 adresses)
- Bordeaux/pubW     : 172.16.1.64/26 (62 adresses)
- Bordeaux/privW    : 172.16.1.0/26 (62 adresses)

# Consignes :🗒️

Créez un nouveau projet Packet Tracer, puis :

- créez deux LANs, un en 192.168.1.0/24 et un en 172.16.0.0/16 (par exemple)
- ajoutez un routeur de bordure (une « box » !) dans chaque LAN
- ajoutez un (ou plusieurs) routeur(s) pour interconnecter les deux LANs (et représenter Internet)
- créez les routes nécessaires
- activez le NAT sur les routeurs de bordure
- mettez un serveur dans un des deux LANs
- créez une redirection de port et testez d’accéder à votre serveur web depuis l’autre LAN !

---

- Configuration des adresses IP et passerelles par défaut :
![Ip](./images/1.png)

![Ip](./images/2.png)

![Ip](./images/3.png)

- Ajout des passerelles par défaut pour les différents routeurs :
![Passerelles](./images/4.png)

- Ajout de deux routes statiques dans le routeur Internet :

![Routes-statiques](./images/5.png)

- Ajout de routes par défaut aux routeurs du Lan 1 et du lan 2 :

![Routes-par-defaut](./images/6.png)

Les Machines des deux Lan peuvent désormais communiquer, les ping fonctionnent.

- Activation du NAT sur les routeurs de bordure :

![NAT](./images/7.png)

- Suppression des deux routes statiques sur le routeur « Internet »
![Routeur](./images/8.png)

- Ajout de la redirection de port pour le serveur, tout fonctionne :
  
![HTTP](./images/9.png)

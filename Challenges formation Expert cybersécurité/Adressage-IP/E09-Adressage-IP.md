## 💡 Compétences Démontrées

* Calcul de l'adresse de réseau et de broadcast.
* Détermination du nombre d'hôtes et de la plage d'adresses utilisables.
* Maîtrise des masques de sous-réseau à longueur variable (VLSM).
* Utilisation de la méthode du "nombre magique" pour les calculs.

---

## Consignes du Challenge : 
Pour les adresses IP et masques de sous-réseau suivants, calculez :
* l’adresse de réseau
* l’adresse de broadcast
* le nombre d’adresses utilisables par des machines
* la plage d’adresses disponibles
  
Certains utilisent la notation « classique », d’autres la notation CIDR :
  * 192.168.13.67/24
  * 172.16.0.1 – 255.255.255.0
  * 172.16.27.32/23
  * 10.7.5.1 – 255.255.128.0
  * 10.42.0.82/12

Essayez de calculer tout à la main (avec la méthode de votre choix, idéalement essayez d’utiliser les deux !), puis vérifiez vos calculs avec une calculatrice en ligne (exemple) !

--- 
## Résultats et méthodes de calcul employés:

## 192.168.13.67/24

   * IP : 192.168.13.67
   * Masque : 255.255.255.0

   * Adresse de réseau : 192.168.13.0
   * Adresse de broadcast : 192.168.13.255
   * Nombre d’adresses utilisables : 254
   * Plage d’adresses disponibles : 192.168.13.1 à 192.168.13.254

Méthode de calcul: En utilisant le nombre magique : 256 (256 - 0 ). 
Pour l’adresse de réseau multiple inférieur à 67 est 0. Pour le broadcast le multiple suivant est 256 et 256-1 = 255. 
Pour le nombre d’adresse utilisables (2⁸) - 2 = 254.

---

## 172.16.0.1 – 255.255.255.0

  * IP : 172.16.0.1
  * Masque : 255.255.255.0

  * Adresse de réseau : 172.16.0.0
  * Adresse de broadcast : 172.16.0.255
  * Nombre d’adresses utilisables : 254
  * Plage d’adresses disponibles : 172.16.0.1 à 172.16.0.254

Méthode de calcul: Nombre magique : 256.
Pour l’adresse réseau le multiple inferieur à 1 est 0. Pour le broadcast le multiple suivant est 256 et 256 – 1 =255.
Nombre d’adresses utilisables (2⁸) – 2 = 254.

---

## 172.16.27.32/23
  
  * IP : 172.16.27.32
  * Masque : 255.255.254.0

  * Adresse de réseau : 172.16.26.0
  * Adresse de broadcast : 172.16.27.255
  * Nombre d’adresses utilisables : 510
  * Plage d’adresses disponibles : 172.16.26.1 à 172.16.27.254

Méthode de calcul: Nombre magique : 2 (256 – 254).
Pour l’adresse réseau le multiple de 2 inférieur à 27 est 26. Pour le broadcast le multiple suivant est 28, et 28 – 1 = 27.
Nombre d’adresses utilisables (2⁹) – 2 = 510

---

## 10.7.5.1 – 255.255.128.0
  
  * IP : 10.7.5.1
  * Masque : 255.255.128.0


  * Adresse de réseau : 10.7.0.0
  * Adresse de broadcast : 10.7.127.255
  * Nombre d’adresses utilisables : 32766
  * Plage d’adresses disponibles : 10.7.0.1 à 10.7.127.254

Méthode de calcul: Nombre magique : 128 (256 – 128).
Pour la première adresse de réseau, le multiple inférieur à 5 est 0. Pour l’adresse de broadcast le multiple suivant est 128 et 128 – 1 = 127.
Nombre d’adresses utilisables (2^15) – 2 = 32766

---

## 10.42.0.82/12
  
  * IP : 10.42.0.82
  * Masque : 255.240.0.0

  * Adresse de réseau : 10.32.0.0
  * Adresse de broadcast : 10.47.255.255
  * Nombre d’adresses utilisables : 1048574
  * Plage d’adresses disponibles : 10.32.0.1 à 10.47.255.254

Méthode de calcul: Nombre magique : 16 (256 – 240).
Pour la première adresse de réseau, le multiple de 16 inférieur à 42 est 32. Pour l’adresse de broadcast le multiple suivant est 48, et 48 – 1 = 47.
Nombre d’adresses utilisables : (2^20) – 2 = 1048574

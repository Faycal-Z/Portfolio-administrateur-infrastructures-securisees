# Consignes 🗒️:

# Atelier Samba

Et si on essayait de remplacer Windows Server et Active Directory par un serveur Linux ?

> [!NOTE]  
> L'intéret d'utiliser un serveur Linux à la place d'un Windows Server avec Active Directory ? On économise le coût des licences ! Pas besoin de CAL pour nos postes/utilisateurs.

Pour remplacer Active Directory sur GNU/Linux, il existe plusieurs solutions. L'une des plus populaires est le logiciel Samba.

## Étape 1 : VM Debian

### 1.1 : Création VM et installation

**Sur votre serveur Proxmox**, créez une nouvelle machine virtuelle Debian 12 avec les caractérisques suivantes :

- 4Go de RAM (ça devrait suffire !)
- 2 coeurs de processeur
- 50Go d'espace disque (ou plus !)

Lancez l'installation.

> [!IMPORTANT]  
> Quand on vous pose la question pendant l'installation, choisissez `debianSRV` comme nom d'hôte (hostname/nom de la machine) et `OCLOCK.LAN` comme nom de domaine.
> Si vous loupez cette étape, les étapes suivantes ne fonctionneront pas comme prévu !

Pensez bien à décocher la case `environnement de bureau Debian` et `GNOME` (pas besoin d'interface graphique sur un serveur) ! Vous pouvez également cocher la case `serveur SSH` si vous voulez vous connecter à distance au serveur.

### 1.2 : sudo

Installez la commande `sudo` et mettez votre utilisateur dans le groupe du même nom. Vous pouvez regarder comment on a fait lors de l'atelier précédent si besoin 😉

### 1.3 : Configuration réseau

Modifiez le fichier `/etc/network/interfaces`, notamment pour mettre une adresse IP fixe.

```bash
alow-hotplug ens18
iface ens18 inet static
  address 10.0.0.10
  netmask 255.255.0.0
  network 10.0.0.0
  broadcast 10.0.255.255
  gateway 10.0.0.1
  dns-nameservers 8.8.8.8
  dns-search OCLOCK.LAN
```

💡 N'oubliez pas de remplacer `ens18` par le nom de votre interface réseau (que vous pouvez récupérer avec la commande `ip a`) ! Cette configuration est valable uniquement pour Proxmox, si vous avez décidé de faire le TP sur VirtualBox faites signe à votre formateur sur Slack.

Puis modifiez le fichier `/etc/hosts` :

```bash
# commentez la ligne suivante :
#127.0.1.1	debianSRV.OCLOCK.LAN debianSRV
10.0.0.10	debianSRV.OCLOCK.LAN
```

Puis le fichier `/etc/hostname` :

```bash
# remplacez debianSRV par :
debianSRV.OCLOCK.LAN
```

Rebootez la VM. Vérifiez ensuite avec la commande `ip a` que la configuration a bien été prise en compte, et que vous avez toujours accès à Internet (`ping google.com`, par exemple).

## Étape 2 : Samba

### 2.1 : Installation

Avant d’installer Samba, on doit installer plusieurs dépendances :

```bash
sudo apt install build-essential libacl1-dev libattr1-dev libblkid-dev libgnutls28-dev libreadline-dev gdb pkg-config libpopt-dev libldap2-dev dnsutils libbsd-dev attr acl krb5-user docbook-xsl libcups2-dev libpam0g-dev ntpdate ntp
```

Quand Kerberos va s’installer, il va nous demander une première fois le nom de domaine. Laissez `OCLOCK.LAN` !

Il vous sera également demandé le hostname du serveur, deux fois ! Saisissez `debianSRV`.

Lancez ensuite la commande suivante pour installer les dernières dépendances requises :

```bash
sudo apt install python3-dev liblmdb-dev flex bison libgpgme11-dev libparse-yapp-perl libjansson-dev libarchive-dev libdbus-1-dev python3-pyasn1 python3-markdown python3-dnspython libjson-perl python3-iso8601
```

On peut maintenant télécharger & compiler Samba, depuis son code source (pour avoir la toute dernière version dispo) !

```bash
wget http://ftp.samba.org/pub/samba/samba-latest.tar.gz
tar zxvf samba-latest.tar.gz
cd samba-x.x.x
./configure --enable-debug --enable-selftest
```

💡 N'oubliez pas de remplacer `x.x.x` par le numéro de version de Samba. Utilisez la touche `Tab` pour l'auto-complétion !

On doit obtenir un message "configure finished successfully" avant de passer à la suite.

Et on lance l’installation !

```bash
make
sudo make install
```

### 2.2 : Contrôleur de domaine

Vérifiez qu'il n'y ait pas de fichier de conf (`smb.conf`) dans le dossier `/usr/local/samba/etc`, supprimez-le s'il est présent.

Lancer l'équivalent de la commande `dcpromo` sur Active Directory (qui permet de configurer le serveur comme contrôleur de domaine) :

```bash
sudo /usr/local/samba/bin/samba-tool domain provision
```

Répondez aux questions en validant le choix pas défaut à chaque fois, normalement tout doit déjà être OK avec la config’ faite après l'install de Debian.

Le mot de passe de l'administrateur du domaine doit faire 7 caractères, avec un caractère spécial, une majuscule/minuscule minimum et un chiffre minimum.

Rebootez le serveur.

### 2.3 : Premier démarrage et test

Lancez la commande suivante pour démarrer Samba :

```bash
sudo /usr/local/samba/sbin/samba
```

(il ne devrait pas y avoir d'erreur)

On peut vérifier que les versions du serveur & du client sont identiques :

```bash
sudo /usr/local/samba/sbin/samba -V
sudo /usr/local/samba/bin/smbclient -V
```

Vérifiez aussi que les partages de base `netlogon` et `sysvol` sont bien présents :

```bash
sudo /usr/local/samba/bin/smbclient -L localhost -U%
```

Et testez de vous connecter :

```bash
/usr/local/samba/bin/smbclient //localhost/netlogon -UAdministrator
```

Tapez votre mot de passe administrateur, puis la commande `ls`.

Résultat attendu : juste le dossier `.` et `..`.
`exit` pour quitter.

## Étape 3 : configuration

### 3.1 : Configuration DNS

Les serveurs DNS utilisés par un système GNU/Linux sont en général renseignés dans le fichier `/etc/resolv.conf`. Modifions-le avec la commande :

```
sudo nano /etc/resolv.conf
```

Supprimez ou commentez (ajoutez un `#` en début de ligne pour commenter) les deux lignes qui commençent par `search` et `domain`, et ajoutez à la place :

```
search OCLOCK.LAN
domain OCLOCK.LAN
```

Vérifiez que le DNS Forwarder est actif en consultant le contenu du fichier `smb.conf` :

```
sudo nano /usr/local/samba/etc/smb.conf
```

Vous devriez avoir le contenu suivant :

```
# Global parameters
[global]
 dns forwarder = X.X.X.X (IP du serveur DNS vers lequel rediriger les requêtes, 10.0.0.1 si vous êtes sur Proxmox)
 netbios name = DEBIANSRV
 realm = OCLOCK.LAN
 server role = active directory domain controller
 workgroup = OCLOCK

[netlogon]
 path = /usr/local/samba/var/locks/sysvol/oclock.lan/scripts
 read only = No

[sysvol]
 path = /usr/local/samba/var/locks/sysvol
 read only = No
```

Modifiez le fichier `krb5.conf` :

```
sudo nano /usr/local/samba/share/setup/krb5.conf
```

Modifiez le fichier de la sorte :

```
[libdefaults]
default_realm = OCLOCK.LAN
dns_lookup_realm = false
dns_lookup_kdc = true

[realms]
OCLOCK.LAN = {
	default_domain = oclock.lan
	kdc = debianSRV.oclock.lan
}

[domain_realm]
    oclock.lan = OCLOCK.LAN
```

On fait un lien symbolique depuis cette config vers `/etc` :

```
sudo ln -sf /usr/local/samba/share/setup/krb5.conf /etc/krb5.conf
```

Et on reboot à nouveau.

### 3.2 : Tester Kerberos

On relance le processus Samba :

```
sudo /usr/local/samba/sbin/samba
```

et on test la connexion avec :

```
kinit administrator@OCLOCK.LAN
```

On a un avertissement sur la date d'expiration du mot de passe de l'admin. Pour désactiver cette expiration (et éviter de se retrouver bloqué ...), lancez la commande suivante :

```
sudo /usr/local/samba/bin/samba-tool user setexpiry administrator --noexpiry
```

On peut utiliser la commande `klist -e` pour avoir des infos sur les algo de chiffrement & hachage utilisés :

- AES256 = AES (Advanced Encryption Standard) utilise une clé de 256-bit
- CTS = ciphertext stealing
- HMAC-SHA1-96 = hachage sur 96 bits (équivalent à MD5).

### 3.3 : Configuration NTP

Afin d'éviter les bugs, le service NTP (Network Time Protocol) doit être configuré.

```
sudo nano /etc/ntpsec/ntp.conf
```

Modifier le contenu :

```
pool 0.fr.pool.ntp.org iburst
pool 1.fr.pool.ntp.org iburst
pool 2.fr.pool.ntp.org iburst
pool 3.fr.pool.ntp.org iburst
```

On redémarre le daemon : `sudo systemctl restart ntp`

### 3.4 : Zone inversée DNS

Création d'une zone inversée :

```
sudo /usr/local/samba/bin/samba-tool dns zonecreate debianSRV 0.0.10.in-addr.arpa --username=administrator
```

Il faut adapter `0.0.10` au 3 premiers octets de l'IP du serveur, dans notre cas 10.0.0.10 (si vous êtes sur Proxmox).

## Étape 4 : clients Windows

### 4.1 : Rejoindre le domaine

Il vous faut une VM windows 10 ou 11 **PRO** ! Vérifiez bien qu’elle est sur le même sous-réseau (`vmbr2`) que le serveur Debian.
On oublie pas de changer le DNS de la WM windows pour mettre l'IP de notre serveur Debian !

Utilisez le compte `administrator` et son mot de passe définit tout à l’heure pour rejoindre le domaine.

Redémarrez la machine, connectez-vous avec le compte `administrator`.

### 4.2 : Outils RSAT

Téléchargez les outils RSAT pour Windows 10 : https://www.microsoft.com/fr-fr/download/details.aspx?id=45520

Ouvrez le menu “Paramètres” puis  cherchez “Fonctionnalités factultatives”. Sur cette page, cliquez sur “Ajouter une fonctionnalité”, puis cherchez “RSAT”.

Cochez “RSAT : outils Active Directory Domain Service …” et “RSAT : outils de gestion de stratégie de groupe”.

Ouvrez la console MMC (Exécuter → `mmc`) et cliquez sur Fichier > Ajouter des composants logiciels enfichables.

Ajoutez les composants suivants :

- Utilisateurs et ordinateurs Active Directory
- Gestion des stratégies de groupe

Ajoutez un utilisateur au domaine depuis la console. On ajoutera une GPO par la suite pour monter automatiquement un lecteur réseau ! Mais avant … il faut créer le partage en question.

Sur Windows 11 Pro :

```powershell
# Gestionnaire de Serveur (pas nécessaire ?)
Add-WindowsCapability -Online -Name "Rsat.ServerManager.Tools~~~~0.0.1.0"

# RSAT : outils Active Directory Domain Services Directory et services LDS
Add-WindowsCapability -Online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"

# RSAT : outils de gestion de stratégie de groupe
Add-WindowsCapability -Online -Name "Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0"
```

### 4.3 : Partage Samba

Ajoutons un partage samba !

Pour cela, on doit modifier le fichier de configuration avec la commande `sudo nano /usr/local/samba/etc/smb.conf`, ajoutez-y les lignes suivantes :

```bash
[public]
	path = /home/shares/public
	guest ok = no
	guest only = yes
	writeable = yes
	force create mode = 0666
	force directory mode = 0777
	browseable = yes
```

On doit ensuite stopper samba et le relancer ! Identifiez le PID du processus samba avec la commande `ps aux | grep samba` (choisissez le `samba: root process`).

Puis stoppez et relancez samba avec :

```bash
kill -9 PID_SAMBA
sudo /usr/local/samba/sbin/samba
```

Créez ensuite le dossier et changez ses permissions avec les commandes :

```bash
sudo mkdir -p /home/shares/public
sudo chmod 777 /home/shares/public
```

💡Pas génial le `chmod 777`, mais là c’est un partage “public” donc RAS.

Testez que vous pouvez accéder à ce partage depuis windows en ouvrant un explorateur de fichiers et en tapant dans la barre d’adresse : `\\10.0.0.10`. Vous devriez voir le partage `public` et pouvoir écrire dedans.

### 4.4 : GPO

Pour la GPO, on peut suivre cette doc : [https://activedirectorypro.com/map-network-drives-with-group-policy/](https://activedirectorypro.com/map-network-drives-with-group-policy/)

Pas besoin de faire la partie “ciblage”.

Il faudra aussi créer une nouvelle OU, mettre notre utilisateur dedans, et lier la GPO dans cette OU.

Connectez-vous avec votre utilisateur, le lecteur réseau devrait être monté !

Vous pouvez essayer de faire d’autres GPO.

## Bonus : création d'un service Systemd

Essayez de créer un service Systemd pour que Samba se lance automatiquement au démarrage du serveur.

> [!WARNING]  
> Attention : ce bonus est complexe, et vous demandera pas mal de recherches sur Internet. Pas de panique si vous bloquez !

--- 


## 1.1 : Création VM et installation :

![](images/1.png)

![](images/2.png)

## 1.2 : Installation de la commande sudo :

- On entre les commandes :
```
apt update
apt install sudo
```

![](images/3.png)

- Ajout de l'utilisateur au groupe sudo:
```
usermod -aG sudo faycal
```
![](images/4.png)

## 1.3 : Configuration réseau

- Commande ```ip a``` pour récupérer l'adresse IP:

![](images/5.png)

- Ouverture du fichier à modifier via la commande ```sudo nano /etc/network/interfaces``` et modification du fichier :
  
![](images/6.png)

- Modification du fichier /etc/hosts :

  ```sudo nano /etc/hosts```

![](images/7.png)

Modification du fichier /etc/hostname :

![](images/8.png)

- Redémarrage via la commande sudo reboot, et vérification via la commande ip a :

![](images/9.png)

# Étape 2 : Samba
  
- Installation des dépendances  
On confirme le royaume par défault, on choisi le serveur Kerberos, ainsi que le serveur administratif :

![](images/10.png)

![](images/11.png)

On installe les dernières dépendances via la commande ```sudo apt install python3-dev liblmdb-dev flex bison libgpgme11-dev libparse-yapp-perl libjansson-dev libarchive-dev libdbus-1-dev python3-pyasn1 python3-markdown python3-dnspython libjson-perl python3-iso8601```.

Télechargement et compilation de SAMBA:
Via les commandes suivantes
```wget http://ftp.samba.org/pub/samba/samba-latest.tar.gz```
tar zxvf samba-latest.tar.gz
cd samba-x.x.x
./configure --enable-debug --enable-selftest ```

![](images/12.png)

La configuration est bien terminée :

![](images/13.png)

On peut lancer l'installation :

``` make ```, on patiente puis :
``` sudo make install ```

![](images/14.png)

## 2.2 : Contrôleur de domaine

Il n'ya pas de fichier de conf (smb.conf) dans le dossier /usr/local/samba/etc :
![](images/15.png)

Configuration du serveur en tant que controleur du domaine :

```sudo /usr/local/samba/bin/samba-tool domain provision```

![](images/16.png)

Et on lance le reboot.

## 2.3 : Premier démarrage et test

Les versions du serveur et du client sont identiques :

![](images/17.png)

Les partages de base netlogon et sysvol sont bien présents :

![](images/18.png)

On se connecte via la commande ```/usr/local/samba/bin/smbclient //localhost/netlogon -UAdministrator```, on peut désormais se connecter :

![](images/19.png)

# Étape 3 : configuration

## 3.1 : Configuration DNS

Modification du fichier fichier /etc/resolv.conf :

``` sudo nano /etc/resolv.conf ```

![](images/20.png)

![](images/21.png)

Modification du fichier krb5.conf via la commande ```sudo nano /usr/local/samba/share/setup/krb5.conf ``` :

![](images/22.png)

Création du lien symbolique depuis cette config vers /etc via la commande ```sudo ln -sf /usr/local/samba/share/setup/krb5.conf /etc/krb5.conf```
Puis on reboot.

## 3.2 : Tester Kerberos

On relance SAMBA et on teste la connexion : 

![](images/23.png)

On désactive l'expiration du mot de passe :

![](images/24.png)

## 3.3 : Configuration NTP

Configuration du service NTP via la commande ```sudo nano /etc/ntpsec/ntp.conf```, on modifie ainsi le contenu :

![](images/25.png)

Et on redémarre le daemon via la commande sudo ```systemctl restart ntp```.

## 3.4 : Zone inversée DNS

Création de la zone inverssée avec la commande ```sudo /usr/local/samba/bin/samba-tool dns zonecreate debianSRV 0.0.10.in-addr.arpa --username=administrator```

![](images/26.png)

# Étape 4 : clients Windows

Installation et configuration de la VM Windows :

![](images/27.png)

On ping bien notre serveur : 

![](images/28.png)

On ajoute l'ordinateur au domaine :

![](images/29.png)

![](images/30.png)

On redémarre.

On peut bien se connecter au domaine :

![](images/31.png)

![](images/32.png)

# 4.2 : Outils RSAT

Ajout de la fonctionnalité RSAT :

![](images/35.png)

![](images/36.png)

![](images/37.png)

Dans la console mmc :

![](images/38.png)

![](images/39.png)

![](images/40.png)

Ajout d'un nouvel utilisateur :

![](images/41.png)

![](images/42.png)

![](images/43.png)

![](images/44.png)


# 4.3 : Partage Samba

Modification du fichier de configuration :

![](images/45.png)

On repere le processus :

![](images/53.png)

On tue le processus :

![](images/54.png)

Et on relance SAMBA via la commande ```sudo /usr/local/samba/sbin/samba```

On crée le dossier de partage et on modifie les permissions :

![](images/55.png)


On accède bien au partage via la VM Windows :

![](images/46.png)

Création de l'Unité d'Organisation : 

![](images/47.png)

Et on déplace l'utilisateur crée dans L'UO Aldebaran :

![](images/48.png)

On crée la GPO :

![](images/49.png)

![](images/50.png)

![](images/51.png)

On paramètre la GPO :

![](images/52.png)

On spécifie l'emplacement du dossier, et la lettre P :

![](images/56.png)

Le lecteur apparait bien :

![](images/57.png)

Vérification sur la session de l'utilisateur Jean Arc :

![](images/58.png)

Le lecteur P apparait bien.

# Bonus : création d'un service Systemd

On crée le fichier de service :

```sudo nano /etc/systemd/system/samba-ad-dc.service```

On rempli la fiche : 

![](images/59.png)

On actualise, on active le service :

![](images/60.png)

![](images/61.png)

Après redémarrage le lecteur P est bien disponible:

![](images/62.png)




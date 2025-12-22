# Consignes 🗒️:

# IPBX Asterisk sur Debian 13

On va installer la dernière version disponible d'Asterisk, en le compilant depuis le code source, sur une VM Debian 13.

## Étape 1 : Debian 13

Créez une VM sur VirtualBox pour y installer Debian 13. 4Go de RAM (ou même 2, si vous êtes juste en RAM), 2 coeurs de CPU, 20Go de disque dur.

Pour le réseau, choisissez le mode `accès par pont`.

N'installez pas d'environnement graphique.

## Étape 2 : sudo, IP statique & SSH

Première chose à faire, installer `sudo`. Connectez-vous avec l'utilisateur root, et installez le paquet. Pensez ensuite à ajouter votre utilisateur au groupe `sudo` avec la commande `usermod` (je vous laisse chercher la commande exacte !) et à vous reconnecter avec votre utilisateur créé lors de l'installation.

> [!TIP]
> Pour rappel, il faut éviter d'être connecté avec l'utilisateur root pour des questions de sécurité !

On veut que notre serveur ait tout le temps la même adresse IP ! Configurez-lui une adresse IP statique en modifiant le fichier `/etc/network/interface` (cherchez sur Internet comment faire si nécessaire).

> [!WARNING]  
> Attention ! La VM étant en mode `accès par pont`, elle est connectée à votre réseau local, chez vous ! Utilisez donc une adresse dans le sous-réseau `192.168.1.0/24` et n'oubliez pas de configurer l'adresse de la passerelle (l'adresse de votre box) !

Essayez de pinger votre VM depuis votre PC hôte, le ping devrait passer si vous avez bien mis la VM en `accès par pont` (et qu'il n'y a pas de conflit d'adresse IP avec une autre machine sur votre réseau).

Mettez ensuite en place un serveur OpenSSH sur votre VM, ça nous permettra de copier/coller des commandes plus facilement. Idem, cherchez sur Internet comment faire si nécessaire !

Connectez-vous ensuite à votre VM en SSH avec le client de votre choix (par exemple : PuTTY).

## Étape 3 : Installation d'Asterisk

On ne peut malheureusement pas installer Asterisk depuis les dépôts Debian, il n'est pas disponible sur notre version (Debian 13, Trixie). On va donc le compiler depuis le code source (ce qui nous permettra aussi d'avoir la toute dernière version disponible) !

> [!NOTE]  
> L'idéal est de suivre la [documentation officielle](https://docs.asterisk.org/Getting-Started/Installing-Asterisk/Installing-Asterisk-From-Source/What-to-Download/), mais elle est assez complexe donc je vais vous guider un peu plus !

Commençons par créer un dossier dans lequel on va télécharger le code source :

```bash
mkdir ~/asterisk-src
cd ~/asterisk-src
```

On peut ensuite télécharger dans ce dossier le code source d'Asterisk, mais aussi de 2 dépendances qu'on va devoir compiler au préalable : dahdi et libpri.

```bash
wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-22-current.tar.gz
wget https://downloads.asterisk.org/pub/telephony/libpri/libpri-1-current.tar.gz
wget https://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz

# et on peut vérifier que les 3 fichiers sont bien présents avec :
ls -l
```

> [!NOTE]  
> Au moment ou j'écris ces lignes, c'est la version 22.5.2 d'Asterisk que vous allez installer.

Il faut maintenant décompresser les archives, puis supprimer les fichiers `.tar.gz` :

```bash
tar -xvzf asterisk-22-current.tar.gz
tar -xvzf libpri-1-current.tar.gz
tar -xvzf dahdi-linux-complete-current.tar.gz

rm *.tar.gz
```

Il nous faudra également de quoi compiler des applications, c'est à dire... un compilateur ! On peut l'installer (ainsi que les bibliothèques de base, indispensables) avec les commandes suivantes :

```bash
sudo apt update
sudo apt install build-essential linux-headers-$(uname -r)
```

On peut maintenant attaquer la compilation !

### 3.1 : dahdi

Commençons par nous déplacer dans le dossier et jeter un coup d'oeil :

```bash
cd dahdi-linux-complete-current
ls -l
```

> [!TIP]
> Vous devriez voir un fichier `README.md`. La plupart des applications fournissent un README avec des instructions pour les compiler depuis leur code source.

Consultons le README (vous pouvez quitter avec la touche `q`) :

```bash
less README.md
```

Il nous manque des dépendances, installons-les !

```bash
sudo apt install automake autoconf bison flex libtool libncurses5-dev patch sqlite3 libsqlite3-dev
```

Deux bibliothèques ne sont pas indiquées dans le README, mais sont pourtant nécessaires. Installons-les également :

```bash
sudo apt install libusb-1.0-0-dev libglib2.0-dev
```

On peut maintenant compiler dahdi :

```bash
make all
```

Problème, on obtient une erreur lors de la compilation 😕 Certains fichiers de dahdi semblent ne pas fonctionner sur les noyaux Linux récent... Après quelques recherches, j'ai trouvé la solution sur le [forum Asterisk](https://community.asterisk.org/t/dahdi-install-error-kernal-mismatch/108279). Je vous évite la recherche (mais ce sera à vous de le faire, en entreprise !), la solution consiste à modifier trois fichiers dans le dossier de dahdi :

- `dahdi-sysfs.c`, dans le dossier `linux/drivers/dahdi`
- `dahdi-sysfs-chan.c`, dans le dossier `linux/drivers/dahdi`
- `xbus-sysfs.c`, dans le dossier `linux/drivers/dahdi/xpp`

Commençons par le premier fichier, `dahdi-sysfs.c` :

```bash
nano linux/drivers/dahdi/dahdi-sysfs.c

# Faites une recherche de "static int span_match", avec Ctrl+F dans nano
# Ajoutez "const" et un espace avant le deuxième "struct", comme visible ci-dessous.
# N'oubliez pas de sauvegarder le fichier une fois la modification effectuée.
```

Résultat attendu :

```c
static int span_match(struct device *dev, const struct device_driver *driver)
{
    return 1;
}
```

Puis, `dahdi-sysfs-chan.c` :

```bash
nano linux/drivers/dahdi/dahdi-sysfs-chan.c

# Faites une recherche de "static int chan_match", avec Ctrl+F dans nano
# Ajoutez "const" et un espace avant le 2ème "struct", comme visible ci-dessous.
# N'oubliez pas de sauvegarder le fichier une fois la modification effectuée.
```

Résultat attendu :

```c
static int chan_match(struct device *dev, const struct device_driver *driver)
{
    struct dahdi_chan *chan;

    chan = dev_to_chan(dev);
    chan_dbg(DEVICES, chan, "SYSFS\n");
    return 1;
}
```

Et enfin, `xbus-sysfs.c` :

```bash
nano linux/drivers/dahdi/xpp/xbus-sysfs.c

# ⚠️ Il y a deux modifications à faire dans ce fichier !

# Pour la première, faites une recherche de "int astribank_match", avec Ctrl+F dans nano
# Ajouter "const" et un espace avant le 2ème struct, comme visible ci-dessous.

# Pour la deuxième, faites une recherche de "int xpd_match", avec Ctrl+F dans nano
# Ajouter "const" et un espace avant le 2ème struct, comme visible ci-dessous.
# N'oubliez pas de sauvegarder le fichier une fois la modification effectuée.
```

Résultat attentu :

```c
// première modification :
static int astribank_match(struct device *dev, const struct device_driver *driver)
{
    DBG(DEVICES, "SYSFS MATCH: dev->bus_id = %s, driver->name = %s\n",
        dev_name(dev), driver->name);
    return 1;
}

// deuxième modification :
static int xpd_match(struct device *dev, const struct device_driver *driver)
{
    struct xpd_driver *xpd_driver;
    xpd_t *xpd;

    // ...
}
```

> [!CAUTION]
> Nous venons seulement de rajouter le mot-clef "const" à 4 endroits différents dans 3 fichiers. Si vous avez fait la moindre autre modification, la compilation ne fonctionnera pas.

Ce coup-ci c'est bon, on devrait enfin pouvoir compiler dahdi :

```bash
# on compile
make all

# puis on installe
sudo make install

# et on installe les fichiers de config'
sudo make install-config
```

Si vous rencontrez des erreurs, vous avez dû louper une étape ci-dessus. Inutile d'aller plus loin, vérifiez bien que vous n'avez oublié aucune étape. Si vous ne trouvez pas au bout de plus d'une dizaine de minutes, faites signe à votre formateur !

### 3.2 : libpri

On peut maintenant passer à libpri.

```bash
cd ../libpri-1-current

make
sudo make install
```

Pas d'erreur ce coup-ci 🎉

### 3.3 : asterisk

Enfin, asterisk !

```bash
cd ../asterisk-22-current
less README.md
```

Toujours bien de lire le README (vous pouvez quitter avec la touche `q`, pour rappel), mais il est un peu long, alors je vous facilite encore la tâche :

```bash
./configure
```

Première erreur, qui doit vous dire que `libedit` est manquante. Corrigeons cela :

```bash
sudo apt install libedit-dev

# et on relance la configuration !
./configure
```

Deuxième erreur ! Ce coup-ci, c'est `libjansson` qui pose problème. Cette bibliothèque est fournie avec asterisk, pas besoin de l'installer nous-même. Il faut juste préciser qu'on veut l'utiliser !

```bash
./configure --with-jansson-bundled
```

Décidément... encore une erreur ! Il nous manque `libxml2` :

```bash
sudo apt install libxml2-dev
```

Normalement, à ce stade, on devrait pouvoir compiler asterisk. **MAIS**, il s'avère, que si `libssl` n'est pas présente sur le système, asterisk va se compiler sans aucun problème mais le module `PJSIP` d'asterisk ne fonctionnera pas (pas de bol, c'est celui dont on a besoin). C'est précisé nul part, en tout cas pas que je sache (à part sur une réponse planquée au fond d'un fil de forum).

Je vous évite donc de vous arracher les cheveux autant que moi, installons `libssl` !

```bash
sudo apt install libssl-dev

# et on peut ENFIN configurer asterisk :
./configure --with-jansson-bundled
```

> [!NOTE]  
> C'était chiant, non ? On aurait pu s'éviter au moins certains loupés en lisant mieux [la doc](https://docs.asterisk.org/Operation/System-Requirements/System-Libraries/) (pas très à jour sur ce point, cela-dit) avant.

Asterisk est livré avec un certain nombre de modules, outils et ressources. Pour alléger les installations d'asterisk, tous ces éléments ne sont pas installés par défaut. On va en ajouter certains ! Lancez la commande suivante :

```bash
make menuselect
```

Dans l'écran qui apparait, vous pouvez vous déplacer avec les flèches directionnelles, la touche `Entrée` pour valider et la touche `Échap` pour revenir en arrière. Pour cocher une fonctionnalité à ajouter (ou retirer), il faut utiliser la touche `Espace`.

Rendez-vous dans la catégorie `Core Sound Packages` et cochez les codecs FR suivants :

- `CORE-SOUNDS-FR-WAV` (haute qualité)
- `CORE-SOUNDS-FR-ULAW` (codec US)
- `CORE-SOUNDS-FR-ALAW` (codec FR)

Rendez-vous également dans le menu `Extras` et cochez :

- `EXTRA-SOUNDS-FR-WAV`
- `EXTRA-SOUNDS-FR-ULAW`
- `EXTRA-SOUNDS-FR-ALAW`

Appuyez sur `Échap` pour quitter, et sur `S` pour sauvegarder vos choix quand ça vous est proposé.

On peut maintenant compiler et installer asterisk :

```bash
make
sudo make install
```

Il n'y a pour l'instant aucun fichier de configuration dans le dossier `/etc/asterisk/` et pas non plus de service systemd. Pour remédier à cela, lancez les commandes suivantes :

```bash
sudo make samples
sudo make config
```

Vérifions que tout a fonctionné :

```bash
ls /etc/asterisk
# vous devriez voir plein de fichiers de config !

systemctl status asterisk
# vous devriez voir un service, présent mais actuellement éteint/désactivé.
```

Facultativement, on peut aussi installer un script de rotation des logs (très utile en prod, moins dans notre lab) :

```bash
sudo make install-logrotate
```

Avant de démarrer Asterisk, on va le configurer.

## Étape 4 : Configuration d'Asterisk

On doit configurer au moins 2 fichiers :

- `pjsip.conf`
- `extensions.conf`

Ces deux fichiers sont dans le dossier `/etc/asterisk/`. Suivez le guide !

### 4.1 : pjsip.conf

Faites un backup du fichier `pjsip.conf` d'origine, puis créez un nouveau fichier portant le même nom avec les commandes ci-dessous :

```bash
# sauvegarde de l'original :
sudo mv /etc/asterisk/pjsip.conf /etc/asterisk/pjsip.conf.backup

# création du nouveau fichier vide :
sudo nano /etc/asterisk/pjsip.conf
```

> [!NOTE]  
> C'est une bonne pratique de conserver les fichiers de configuration avant de les modifier. Prenez l'habitude de le faire, vous me remercierez un jour 😉

Voici un contenu d'exemple pour le fichier `pjsip.conf` :

```ini
[simpletrans]
type=transport
protocol=udp
bind=0.0.0.0

[123]
type = endpoint
trust_id_outbound=yes
callerid = Caller ID <123>
language = fr
context = lab
disallow = all
allow = alaw
allow = ulaw
force_rport=no
transport=simpletrans
aors = 123
auth = auth123

[123]
type = aor
max_contacts = 1

[auth123]
type=auth
auth_type=userpass
password=rocknroll
username=123
```

La configuration ci-dessus permet d'enregistrer un seul téléphone à la fois sur une ligne avec le numéro `123`. Le nom d'utilisateur est également `123` et le mot de passe `rocknroll`.

Vous allez devoir étoffer ce fichier de configuration : il vous faudra au moins une deuxième ligne pour tester d'effectuer un appel ! Mais on verra ça dans un second temps.

> [!NOTE]  
> Sur les anciennes versions d'Asterisk, on aurait configuré le fichier `sip.conf`. Le module `SIP` est obsolète et a été remplacé par le module `PJSIP` (que l'on vient de configurer).

### 4.2 : extensions.conf

Même principe : faisons un backup du fichier `extensions.conf` d'origine, et créons un nouveau fichier portant le même nom avec les commandes ci-dessous :

```bash
# sauvegarde de l'original :
sudo mv /etc/asterisk/extensions.conf /etc/asterisk/extensions.conf.backup

# création du nouveau fichier vide :
sudo nano /etc/asterisk/extensions.conf
```

Voici le contenu que nous allons utiliser pour commencer dans le fichier `extensions.conf` :

```ini
[lab]
exten => 123,1,Answer()
exten => 123,2,Wait(2)
exten => 123,3,Playback(hello-world)
exten => 123,4,Hangup()
```

Cette configuration va faire que quand vous allez essayer d'appeler le numéro 123 depuis la ligne 123, vous entendrez un message disant "Salut tout le monde" après 2 secondes de pause. Idéal pour tester !

> [!IMPORTANT]  
> Si vous l'avez modifié le numéro 123 à l'étape précédente, pensez également à le modifier ici.

## Étape 5 : premier lancement et test

Démarrons Asterisk :

```bash
sudo systemctl start asterisk
```

Pour vérifier que le module `PJSIP` est opérationnel, on va utiliser la commande `netstat` (après l'avoir installée) !

```bash
sudo apt install net-tools

sudo netstat -anup
# -a = All (tous les ports ouverts)
# -n = Numeric (pour voir le n° de port)
# -u = Udp (ports UDP)
# -p = Pid (avoir le nom et le PID du programme utilisant chaque port)
```

Vous devriez voir le port `5060` dans la liste, ouvert par le programme asterisk.

On va maintenant pouvoir surveiller les logs et observer la connexion de notre téléphone :

```bash
sudo /usr/sbin/asterisk -rvvvvv

# une fois dans la CLI asterisk, on peut activer le logging des requêtes/réponses SIP :
pjsip set logger on

# quand vous aurez fini, vous pourrez quitter la CLI avec la commande "exit".
```

Installez Zoiper ou le softphone de votre choix sur votre ordinateur, et tentez de vous connecter avec les paramètres suivants :

- Premier écran :
  - Username / Login : `123@192.168.1.X:5060`
  - Password : `rocknroll`
- Deuxièxe écran : `192.168.1.X:5060`
- Troisième écran : vous pouvez cliquer sur `Skip`, pas besoin de proxy.
- Quatrième écran : vous devriez voir `SIP UDP` passer en vert 🟢 !

> [!IMPORTANT]  
> Pensez à remplacer le `X` par le dernier octet de l'adresse IP de votre serveur Asterisk, et adaptez le numéro et le mot de passe si nécessaire (si vous avez modifié le fichier pjsip.conf).

Essayez d'appeler votre propre numéro (123, si vous n'avez rien changé). Vous devriez entre le message de test !

Si ce n'est pas le cas, vérifiez que tout est correct dans les deux fichiers de configuration, et si vraiment vous bloquez faites signe à votre formateur sur Slack. Pensez aussi à jeter un coup d'oeil sur le canal `#entraide`.

## Étape 6 : deuxième ligne et appel

Un `Hello, world`, c'est cool, un appel entre votre smartphone et votre ordi, encore mieux !

Vous allez devoir modifier le fichier `pjsip.conf` : il faudra dupliquer la configuration du numéro `123` et modifier ce qui doit l'être. À vous de chercher un peu 😈

> [!TIP]
> Pas de panique, prenez le temps de regarder le contenu du fichier et essayez de voir ce qui doit être adapté. La première section, qui commence par la ligne `[simpletrans]`, ne doit pas être dupliquée/modifiée.

Si vous bloquez, demandez un coup de main sur le canal `#entraide` sur Slack !

Il faudra également modifier le fichier `extensions.conf`. Je vous donne une configuration fonctionnelle pour un téléphone :

```ini
[lab]
exten => 123,1,Dial(PJSIP/${EXTEN},30)
exten => 123,2,Hangup()
```

Ici aussi, à vous de dupliquer et de chercher ce qui doit être modifié pour ajouter une deuxième ligne !

Une fois les modifications effectuées, pensez à relancer Asterisk :

```bash
sudo systemctl restart asterisk
```

Installez Zoiper (ou un autre softphone) sur votre smartphone, **connecté en WiFi**. La configuration est similaire à celle effectuée sur le client PC.

Essayez de passer un appel entre votre PC et votre smartphone ! Si vous n'avez pas fait d'erreur, tout devrait fonctionner. Et sinon... `#entraide` !

## Bonus

Si vous êtes arrivé jusque-là, c'est déjà très bien ! Mais s'il n'est pas trop tard, vous pouvez essayer de mettre en place les fonctionnalités suivantes :

- messagerie/boîte vocale
- appels vidéo (il faudra utiliser un autre softphone que Zoiper !)
- interception d'appels
- salle de conférence
- menu interactif (IVR)

[Cette doc](https://berenger-benam.over-blog.com/2023/06/mise-en-place-de-la-telephonie-sur-ip-avec-asterisk-pjsip.html) peut être un bon point de départ 😉


---


# Etape 1

La VM debian 13 à bien été installée sans interface graphique.

# Étape 2 : sudo, IP statique & SSH

- Installation de sudo :
  ```apt update
apt install sudo -y```

Image 1

- Ajout de l'utilisateur faycal au groupe sudo :
  ```usermod -aG sudo faycal```

Image 2

- Modification du fichier de configuration 

```sudo nano /etc/network/interfaces```

Image 3

- On redémarre :

  ```sudo systemctl restart networking```

- Le pc hote ping bien la VM :

Image 4

# Étape 3 : Installation d'Asterisk

- On crée le dossier :

Image 5

- On télécharge les archives, les 3 fichiers sont bie présents :

Image 6

- On extrait les archives, et on installe le compilateur.

- Installation de Dhadi :

Image 7

Fichier README.md

Image 8

- Installation des dépendances :

```sudo apt update
sudo apt install automake autoconf bison flex libtool libncurses5-dev patch sqlite3 libsqlite3-dev libusb-1.0-0-dev libglib2.0-dev
sudo apt install libusb-1.0-0-dev libglib2.0-dev
```

```make all```

- Modification des fichiers pour résoudre l'erreur :

  Image 9

  Image 10

  Image 11

  Image 12

- Compilation :

```make all```
```sudo make install```
```sudo make install-config```

# 3.2 : libpri

```cd ../asterisk-22.7.0/
less README.md```

Image 13

```./configure```

Il y'a une erreur :
```sudo apt install libedit-dev```

On relance la configuration :

```
./configure```

```./configure --with-jansson-bundled```

```sudo apt install libxml2-dev```

```sudo apt install libssl-dev```

```./configure --with-jansson-bundled```

- Ajout de modules :
  
```make menuselect```

Image 14

Image 15

On sauvegarde.

Compilation et installation d'Asterisk :

```make```
```sudo make install```

- Création des fichiers de config :

```sudo make samples```
```sudo make config```

- Tout fonctionne :
  
Image 16

Image 17

- On install le script de rotation des log :

```sudo make install-logrotate```

Image 18

# Étape 4 : Configuration d'Asterisk

## 4.1 : pjsip.conf

- Sauvegarde du fichier original, et création du nouveau fichier :

```sudo mv /etc/asterisk/pjsip.conf /etc/asterisk/pjsip.conf.backup```

```sudo nano /etc/asterisk/pjsip.conf```

Image 19


## 4.2 : extensions.conf

- Sauvegarde du fichier original, et création du nouveau fichier :

```sudo mv /etc/asterisk/extensions.conf /etc/asterisk/extensions.conf.backup```

```sudo nano /etc/asterisk/extensions.conf```

Image 20


# Étape 5 : premier lancement et test

- Démarrage d'Asterisk :

Image 21

- Installation des outils réseaux :

Image 22

Le PJSIP est bien opérationnel :

Image 23

- Activation de la surveillance des log :

Image 24
















  

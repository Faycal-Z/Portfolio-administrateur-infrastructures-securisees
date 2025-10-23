# 📝 Consignes:

Aujourd’hui, tu vas devoir diagnostiquer et résoudre plusieurs pannes sur l’ordinateur de Madame Michu, une utilisatrice âgée sympathique qui adore les Yorkshires.

Voici le message qu’elle t’as envoyé :

Bonjour, Mon ordinateur ne veut plus démarrer correctement, et quand j’arrive enfin sur le Bureau, mon processeur et ma RAM sont utilisés à 100% (elle est balaise, Mme Michu, pour le pré-diagnostic). En plus, j’ai remarqué que des fichiers dans mon dossier « Images » ont disparu ! Je suis inquiète pour l’état de mes disques durs aussi, il parait qu’ils sont défectueux, pourrais-tu les vérifier aussi ? Merci beaucoup de ton aide !

Ta mission est de diagnostiquer et corriger les différentes pannes présentes sur la machine de Madame Michu en suivant ces quatre étapes :

Réparer le démarrage de Windows,
Restaurer les performances normales de la machine,
Vérifier l’état des disques durs,
Retrouver les fichiers disparus dans le dossier « Images ».

Vu que ce serait contraignant de vous envoyer le PC de Mme Michu par la poste, on va travailler sur une machine virtuelle VirtualBox. Télécharge-la au format OVA et commence ta mission 💪

Tu n’auras pas besoin de mot de passe que ce soit pour lancer le fichier OVA ou pour la session de Madame Michu.

Prends ton temps et suis les étapes dans l’ordre !

## Étape 1 : Réparer le démarrage de Windows
Problème rencontré : L’ordinateur de Madame Michu refuse de démarrer correctement, avec des messages tels que « BootMGR est manquant » ET « Winload.exe introuvable », son petit-fils a testé des trucs, donc il n’y a plus les messages mais le problème est le même, donc ne t’en fais pas si tu ne vois pas les mêmes messages !

Si je peux te donner un conseil, fais attention aux partitions et également au lecteur, si tu avances dans ton diagnostic, peut-être que tu vas t’emmêler les pinceaux avec le C: D: E: F: G: etc… donc prends le temps de bien repérer ton lecteur !

Résous ce problème pour permettre à Windows de démarrer normalement.

## Étape 2 : Restaurer les performances normales de la machine
Problème rencontré : Une fois sur le Bureau, Madame Michu constate que son processeur et sa RAM sont utilisés à 100 %, rendant l’ordinateur très lent.

Diagnostique et résous ce problème pour restaurer les performances optimales.

Il y a plusieurs solutions je pense, mais si tu arrives à restaurer les performances de son PC, l’étape est réussie !

## Étape 3 : Vérifier l’état des disques durs
Problème rencontré : Madame Michu s’inquiète de l’état de ses disques durs. Oui, elle a 2 disques d’après ce qu’elle m’a dit, à vérifier donc si tout va bien de ce côté-là.

Vérifie les disques pour détecter d’éventuels problèmes et corrige-les si nécessaire.

## Étape 4 : Retrouver les fichiers disparus dans le dossier « Images »
Problème rencontré : Des fichiers ont mystérieusement disparu dans le dossier « Images » de Madame Michu.

Retrouve et restaure ces fichiers pour elle.

---

# Installation de la machine virtuelle VirtualBox 
Lors du démarrage de l'ordinateur on a cet écran qui s'affiche:
![Démarrage](./images/1-démarrage.png)


# Étape 1 : Réparer le démarrage de Windows
J'ai inseré le fichier iso de Windows et j'ai redémarré l'ordinateur.
![Démarrage](./images/2-Windows.png)

J'ai cliqué sur suivant puis réparer l'ordinateur: 
![Démarrage](./images/3-Windows.png)

Dépannage, puis invite de commandes:
J'ai été dans diskpart pour voir les volumes disponibles.
J'ai selectionné volume principal E:
J'ai tapé la commande bcdboot E:\Windows /s C: /l fr-fr afin de récupérer les fichiers de démarrage présents dans E: et les installer dans la partition de démarrage C:
Enfin j'ai tapé la commande bootrec /rebuildbcd pour verifier que l'installation était réussie.
![Commande](./images/4-Invite-de-commande.png)
![Commande](./images/5-DiskPart.png)
![Commande](./images/6-Commandes.png)

Ensuite au redémarrage j'obtiens l'erreur 0xc000000f :
![Erreur](./images/7-Erreur.png)


J'ai été dans dépannage et j'ai lancé l'outil de réparation Windows puis j'ai redémarré, Windows s'est lancé:
![Windows](./images/8-Demarrage.png)

# Étape 2 : Restaurer les performances normales de la machine :

Je constate que le processeur est trop utilisé dans le gestionnaire de taches (une fenetre de commande powershell "ping" se lance au démarrage). Dans le gestionnaire des taches, j'ai désactivé Powershell. Ensuite j'ai été dans le fichier de démarrage et j'ai supprimé le raccourci "ping" ainsi que le script dans le dossier Windows:
![Processeur](./images/9-process.png)
![Processeur](./images/10-process.png)
![Processeur](./images/11-process.png)
![Processeur](./images/12-process.png)
![Processeur](./images/13-process.png)


# Étape 3 : Vérifier l’état des disques durs :
Dans le gestionnaire de disques j'ai remis le disque 1 en ligne et j'ai redémarré:
![Disque](./images/14-disque.png)
![Disque](./images/15-disque.png)
![Disque](./images/16-disque.png)



# Étape 4 : Retrouver les fichiers disparus dans le dossier « Images » :

J'ai été dans le dossier images, clic droit propriétés et versions précédentes, restaurer. Le fichier "York" est désormais présent: 

![Images](./images/17-images.png)
![Images](./images/18-images.png)





















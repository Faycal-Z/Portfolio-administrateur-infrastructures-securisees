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

---

# Installation de la machine virtuelle VirtualBox :

## Étape 1 : Réparer le démarrage de Windows
J'ai inseré le fichier iso de Windows et j'ai redémarré l'ordinateur.


J'ai cliqué sur suivant puis réparer l'ordinateur: 


Dépannage, puis invite de commandes:
J'ai été dans diskpart pour voir les volumes disponibles.
J'ai selectionné volume principal E:
J'ai tapé la commande bcdboot E:\Windows /s C: /l fr-fr afin de récupérer les fichiers de démarrage présents dans E: et les installer dans la partition de démarrage C:

Enfin j'ai tapé la commande bootrec /rebuildbcd pour verifier que l'installation était réussie.

Ensuite au redémarrage j'obtiens l'erreur 0xc000000f :















# Partie 1

1.1

Le module AD n'est pas installé, donc on installe les outils d'administration!

![](images/1.png)

1.2 

Lister les cmdlets disponibles :

![](images/2.png)

Listez uniquement les cmdlets qui commencent par Get-ADUser :

![](images/3.png)

Affichage de l'aide :

![](images/4.png)

1.3 - Connexion à l'Active Directory

Test de la connexion à l'AD :

![](images/5.png)

Affichage du nom du domaine, du niveau fonctionnel et des contrôleurs de domaine:

Image 6

1.4 - Premier utilisateur

Affichage de toutes les informations du compte utilisateur :

Image 7

Affichage uniquement du nom, email et titre :

Image 8

Partie 2 : Gestion des utilisateurs

2.1 - Créer des utilisateurs

Image 9

Puis on reproduit les mêmes manipulations pour les utilisateurs Bob et Claire:

Image 10

2.2 - Rechercher des utilisateurs

Lister tous les utilisateurs du domaine, Alice, Bob et Claire apparaissent bien :

Image 11

Trouver l'utilisateur dont le login est "amartin":

Image 12

Trouver tous les utilisateurs dont le nom commence par "B":

Image 13

Trouver tous les utilisateurs qui ont "Administrateur" dans leur titre:

Image 14

Compter le nombre total d'utilisateurs dans le domaine:

Image 15

2.3 - Modifier des utilisateurs

Pour l'utilisateur "amartin", on change le numéro de téléphone, on ajoute une description et on change le titre via la commande Set-ADUser :

Image 16

Les modifications ont bien été prises en compte:

Image 17

2.4 - Désactiver et supprimer

Désactivation du compte "bdubois" :

Image 18

Le compte est bien désactivé :

Image 19

Suppression du compte "cbernard" :

Image 20


Partie 3 : Gestion des groupes

3.1 - Créer des groupes

Création des groupes de sécurité :

Image 21

3.2 - Ajouter des membres

Ajout de "amartin" dans le groupe "GRP_Developpeurs":

Image 22

Ajout de "bdubois" dans le groupe "GRP_Admins_Systeme":

Image 23

Ajout de tous les membres des trois premiers groupes dans "GRP_IT":

Image 24

3.3 - Lister les appartenances

Affichage de tous les membres du groupe "GRP_IT":

Image 25

Affichage de tous les groupes dont "amartin" est membre:

Image 26

Compter combien de membres a chaque groupe:

GRP_Developpeurs:

Image 27

GRP_Admins_Systeme: 

Image 28

GRP_Chefs_Projet, on constate que Claire Bernard n'est plus dans le groupe car cet utilisateur a été supprimé:

Image 29

GRP_IT:

Image 30

3.4 - Retirer des membres

On retire "amartin" du groupe "GRP_IT":

Image 31

Elle n'est plus membre du groupe :

Image 32

3.5 - Groupes imbriqués

Création du groupe "GRP_Tous_Utilisateurs":

Image 33

On ajoute les groupes "GRP_IT":

Image 34

Liste des membres (directs et récursifs) de "GRP_Tous_Utilisateurs":

Membres directs:

Image 35

Membres récursifs:

Image 36


Partie 4 : Organisation avec les Unités Organisationnelles (OU)

4.1 - Créer une structure d'où

- On créer l'OU à la racine:

Image 37

- Création des sous dossiers Utilisateurs, Groupes, et Ordinateurs:

Image 38

Création des sous dossiers Informatique, RH, et Commercial dans Utilisateurs:

Image 39


Création des sous dossier Développement et Infrastructure dans Informatique.

Image 40

Les groupes ont bien été crées : 

Image 41

4.2 - Déplacer des objets

On déplace l'utilisateur "amartin" dans l'OU "TechSecure/Utilisateurs/Informatique/Developpement" et on déplace tous vos groupes créés précédemment dans l'OU "TechSecure/Groupes" :

Image 42

Liste de tous les utilisateurs présents dans l'OU "Informatique" (incluant les sous-OU), on constate que l'utilisateur Alice est bien présent:

Image 43

4.3 - Recherche par OU

Nombre d'utilisateurs dans l'OU "Informatique" uniquement:

Image 44

On constate qu'il n'y a aucun utilisateur dans le dossier informatique, car Alice a été déplacée précédemment dans le groupe Développement.

Nombre d'utilisateurs dans l'OU "Informatique" en incluant tous les sous-niveaux et donc celui d'en dessous (Développement ou se trouve désormais Alice). On utilise Substree mais c'est optionnel :

Image 45

Partie 5 : Import en masse depuis CSV

5.1 - Préparer le fichier CSV

Image 46

Le fichier .csv est bien crée :

Image 47

5.2 - Script d'import basique

Création du script :

Le script a bien été executé et les utilisateurs crées :

Image 48

Image 49

Image 50


5.3 - Améliorer le script avec gestion d'erreurs

On ajoute au script la vérification que le login existe déjà et on exporte les détails des erreurs vers un fichier de Log:

- Dans la partie variable on ajoute le chemin du fichier de Log : $FichierLog = "C:\erreurs_import.txt"

- On ajoute une condition pour que le fichier de Log soit vide au lancement du script en le supprimant s'il existe: if (Test-Path $FichierLog) { Remove-Item $FichierLog }

- On crée une variable pour vérifier que l'utilisateur existe déjà : $ExisteDeja = Get-ADUser -Filter "SamAccountName -eq '$Login'" -ErrorAction SilentlyContinue

- On ajoute la condition au script pour afficher un message pour dire que l'on ignore cet utilisateur :  if ($ExisteDeja) {
        Write-Host "[EXISTE DÉJÀ] $NomComplet ($Login) est ignoré." -ForegroundColor Yellow
    }

- On crée le message d'erreur et on l'ajoute au fichier de Log : Write-Host $MessageErreur -ForegroundColor Red
	$MessageErreur | Out-File -FilePath $FichierLog -Append


	
5.4 - Ajouter les groupes lors de l'import

Mise a jour du fichier CSV pour ajouter la colonne Goupes :

Image 51

Pour ajouter automatiquement les utilisateurs dans les groupes spécifiés on recupère d'abord les groupes et on les sépare avec un point virgule: $LesGroupes = $Utilisateur.Groupes -split ";"

On boucle sur les groupes trouvés : foreach ($Groupe in $LesGroupes) {
        if ($Groupe -ne "") {
            Add-ADGroupMember -Identity $Groupe -Members $Login -ErrorAction SilentlyContinue
        }
    }


Partie 6 : Scripts d'automatisation

On ajoute les paramètres :

Image 52

On crée le LOGIN:

Image 53

On crée l'email:

Image 54

On crée l'utilisateur dans la bonne OU selon le département:

Image 55

On génère un mot de passe aléatoire sécurisé:

Image 56

On créer l'utilisateur puis on l'ajoute au groupe selon le département:

Image 57

On simule un envoi d'email de bienvenue:

Image 58

Logger toutes les opérations:

Image 59

6.2 - Script d'offboarding

Création de l'OU "Comptes Désactivés":

Image 60

6.2 - Script d'offboarding

Ajout du paramètre login de l'utilisateur et ajout des variables de destination:

Image 61

On demande confirmation avant l'exécution du script:

Image 62

On désactive le compte et on retire les utilisateurs de tous les groupes:

Image 63

On déplace l'utilisateur ver le groupe "Desactives":

Image 64

On réinitialise le mot de passe:

Image 65

Ajout d'une note dans la description avec la date de désactivation:

Image 66

Logger toutes les opérations:

Image 67

Le script a bien fonctionné pour l'utilisateur Léa Garnier:

Image 68


6.3 - Script de modification de mot de passe

Ajout des paramètres, du fichier de log, et demande du mot de passe:

Image 69

On applique le mot de passe, on déverrouille le compte et on force le changement:

Image 70

Le script fonctionne bien :

Image 71

Image 72


# Partie 1

## 1.1 - Installation du module (si nécessaire)

Le module AD n'est pas installé, donc on installe les outils d'administration!

![](Images/1.png)

## 1.2 - Exploration du module

Lister les cmdlets disponibles :

![](Images/2.png)

Listez uniquement les cmdlets qui commencent par Get-ADUser :

![](Images/3.png)

Affichage de l'aide :

![](Images/4.png)

## 1.3 - Connexion à l'Active Directory

Test de la connexion à l'AD :

![](Images/5.png)

Affichage du nom du domaine, du niveau fonctionnel et des contrôleurs de domaine:

![](Images/6.png)

## 1.4 - Premier utilisateur

Affichage de toutes les informations du compte utilisateur :

![](Images/7.png)

Affichage uniquement du nom, email et titre :

![](Images/8.png)

# Partie 2 : Gestion des utilisateurs

## 2.1 - Créer des utilisateurs

![](Images/9.png)

Puis on reproduit les mêmes manipulations pour les utilisateurs Bob et Claire:

![](Images/10.png)

## 2.2 - Rechercher des utilisateurs

Lister tous les utilisateurs du domaine, Alice, Bob et Claire apparaissent bien :

![](Images/11.png)

Trouver l'utilisateur dont le login est "amartin":

![](Images/12.png)

Trouver tous les utilisateurs dont le prénom commence par "B":

![](Images/13.png)

Trouver tous les utilisateurs qui ont "Administrateur" dans leur titre:

![](Images/14.png)

Compter le nombre total d'utilisateurs dans le domaine:

![](Images/15.png)

## 2.3 - Modifier des utilisateurs

Pour l'utilisateur "amartin", on change le numéro de téléphone, on ajoute une description et on change le titre via la commande Set-ADUser :

![](Images/16.png)

Les modifications ont bien été prises en compte:

![](Images/17.png)

## 2.4 - Désactiver et supprimer

Désactivation du compte "bdubois" :

![](Images/18.png)

Le compte est bien désactivé :

![](Images/19.png)

Suppression du compte "cbernard" :

![](Images/20.png)

# Partie 3 : Gestion des groupes

## 3.1 - Créer des groupes

Création des groupes de sécurité :

![](Images/21.png)

## 3.2 - Ajouter des membres

Ajout de "amartin" dans le groupe "GRP_Developpeurs":

![](Images/22.png)

Ajout de "bdubois" dans le groupe "GRP_Admins_Systeme":

![](Images/23.png)

Ajout de tous les membres des trois premiers groupes dans "GRP_IT":

![](Images/24.png)

# 3.3 - Lister les appartenances

Affichage de tous les membres du groupe "GRP_IT":

![](Images/25.png)

Affichage de tous les groupes dont "amartin" est membre:

![](Images/26.png)

Compter combien de membres a chaque groupe:

GRP_Developpeurs:

![](Images/27.png)

GRP_Admins_Systeme: 

![](Images/28.png)

GRP_Chefs_Projet, on constate que Claire Bernard n'est plus dans le groupe car cet utilisateur a été supprimé:

![](Images/29.png)

GRP_IT:

![](Images/30.png)

## 3.4 - Retirer des membres

On retire "amartin" du groupe "GRP_IT":

![](Images/31.png)

Elle n'est plus membre du groupe :

![](Images/32.png)

## 3.5 - Groupes imbriqués

Création du groupe "GRP_Tous_Utilisateurs":

![](Images/33.png)

On ajoute les groupes "GRP_IT":

![](Images/34.png)

Liste des membres (directs et récursifs) de "GRP_Tous_Utilisateurs":

Membres directs:

![](Images/35.png)

Membres récursifs:

![](Images/36.png)


# Partie 4 : Organisation avec les Unités Organisationnelles (OU)

## 4.1 - Créer une structure d'où

- On créer l'OU à la racine:

![](Images/37.png)

- Création des sous dossiers Utilisateurs, Groupes, et Ordinateurs:

![](Images/38.png)

Création des sous dossiers Informatique, RH, et Commercial dans Utilisateurs:

![](Images/39.png)

Création des sous dossier Développement et Infrastructure dans Informatique.

![](Images/40.png)

Les groupes ont bien été crées : 

![](Images/41.png)

## 4.2 - Déplacer des objets

On déplace l'utilisateur "amartin" dans l'OU "TechSecure/Utilisateurs/Informatique/Developpement" et on déplace tous vos groupes créés précédemment dans l'OU "TechSecure/Groupes" :

![](Images/42.png)

Liste de tous les utilisateurs présents dans l'OU "Informatique" (incluant les sous-OU), on constate que l'utilisateur Alice est bien présent:

![](Images/43.png)

# 4.3 - Recherche par OU

Nombre d'utilisateurs dans l'OU "Informatique" uniquement:

![](Images/44.png)

On constate qu'il n'y a aucun utilisateur dans le dossier informatique, car Alice a été déplacée précédemment dans le groupe Développement.

Nombre d'utilisateurs dans l'OU "Informatique" en incluant tous les sous-niveaux et donc celui d'en dessous (Développement ou se trouve désormais Alice). On utilise Substree mais c'est optionnel :

![](Images/45.png)

# Partie 5 : Import en masse depuis CSV

## 5.1 - Préparer le fichier CSV

![](Images/46.png)

Le fichier .csv est bien crée :

![](Images/47.png)

## 5.2 - Script d'import basique

Création du script :

Le script a bien été executé et les utilisateurs crées :

![](Images/48.png)

## 5.3 - Améliorer le script avec gestion d'erreurs

On ajoute au script la vérification que le login existe déjà et on exporte les détails des erreurs vers un fichier de Log:

- Dans la partie variable on ajoute le chemin du fichier de Log : ```$FichierLog = "C:\erreurs_import.txt"```

- On ajoute une condition pour que le fichier de Log soit vide au lancement du script en le supprimant s'il existe: ```if (Test-Path $FichierLog) { Remove-Item $FichierLog }```

- On crée une variable pour vérifier que l'utilisateur existe déjà : ```$ExisteDeja = Get-ADUser -Filter "SamAccountName -eq '$Login'" -ErrorAction SilentlyContinue```

- On ajoute la condition au script pour afficher un message pour dire que l'on ignore cet utilisateur :  ```if ($ExisteDeja) {
        Write-Host "[EXISTE DÉJÀ] $NomComplet ($Login) est ignoré." -ForegroundColor Yellow
    }```

- On crée le message d'erreur et on l'ajoute au fichier de Log : ```Write-Host $MessageErreur -ForegroundColor Red
	$MessageErreur | Out-File -FilePath $FichierLog -Append```

	
# 5.4 - Ajouter les groupes lors de l'import

Mise a jour du fichier CSV pour ajouter la colonne Goupes :

![](Images/49.png)

Pour ajouter automatiquement les utilisateurs dans les groupes spécifiés on recupère d'abord les groupes et on les sépare avec un point virgule: ```$LesGroupes = $Utilisateur.Groupes -split ";"```

On boucle sur les groupes trouvés : ```foreach ($Groupe in $LesGroupes) {
        if ($Groupe -ne "") {
            Add-ADGroupMember -Identity $Groupe -Members $Login -ErrorAction SilentlyContinue
        }
    }```


# Partie 6 : Scripts d'automatisation

On ajoute les paramètres :

![](Images/50.png)

On crée le LOGIN:

![](Images/51.png)

On crée l'email:

![](Images/52.png)

On crée l'utilisateur dans la bonne OU selon le département:

![](Images/53.png)

On génère un mot de passe aléatoire sécurisé:

![](Images/54.png)

On créer l'utilisateur puis on l'ajoute au groupe selon le département:

![](Images/55.png)

On simule un envoi d'email de bienvenue:

![](Images/56.png)

Logger toutes les opérations:

![](Images/57.png)

## 6.2 - Script d'offboarding

Création de l'OU "Comptes Désactivés" via l'interface graphique:

![](Images/58.png)

Ajout du paramètre login de l'utilisateur et ajout des variables de destination:

![](Images/59.png)

On demande confirmation avant l'exécution du script:

![](Images/60.png)

On désactive le compte et on retire les utilisateurs de tous les groupes:

![](Images/61.png)

On déplace l'utilisateur ver le groupe "Desactives":

![](Images/62.png)

On réinitialise le mot de passe:

![](Images/63.png)

Ajout d'une note dans la description avec la date de désactivation:

![](Images/64.png)

Logger toutes les opérations:

![](Images/65.png)

Le script a bien fonctionné pour l'utilisateur Léa Garnier:

![](Images/66.png)


# 6.3 - Script de modification de mot de passe

Ajout des paramètres, du fichier de log, et demande du mot de passe:

![](Images/67.png)

On applique le mot de passe, on déverrouille le compte et on force le changement:

![](Images/68.png)

Le script fonctionne bien :

![](Images/69.png)

![](Images/70.png)


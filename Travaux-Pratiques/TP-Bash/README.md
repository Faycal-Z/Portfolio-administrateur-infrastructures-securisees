# Portfolio : Automatisation et Administration Linux (Bash)

## Ce dépôt contient l'ensemble des scripts réalisés. L'objectif est d'automatiser des tâches courantes : sauvegarde, monitoring, gestion des utilisateurs et nettoyage.

# Partie 1 : Script de sauvegarde automatisée

## 1.1 - Création du script

![](images/1.png)

## 1.2 - Amélioration du script

Image 2

Image 3

## 1.3 - Ajout d'une rotation des sauvegardes

Ajout du bloc de code pour la rotation des sauvegardes

Image 4


# 1.4 - Test du script avec différents scénarios

- Sauvegarde d'un dossier existant:

Image 5

- Tentative de sauvegarde d'un dossier inexistant :

Image 6

- Exécutions multiples pour vérifier la rotation :

Création de 10 sauvegardes pour essayer:
```sudo touch /backup/backup_test_vieux_{1..10}.tar.gz```

Les fichiers sont bien crées :

Image 7

Après le lancement du script nous avons bien le message de confirmation et il ne reste plus que 7 sauvegardes:

Image 8


# Partie 2 : Moniteur de ressources système

## 2.1 - Création du script Monitor:

Image 9

## 2.2 - Ajout d'un système d'alertes colorées :

Image 10

Image 11

Les couleurs s'affichent bien :

Image 12

## 2.3 - Création d'une option pour générer un rapport texte :

- Stockage du disque dans une variable pour pouvoir la réutiliser dans le rapport:

Image 13

- Création d'un bloc rapport:

Image 14

- Le rapport est bien crée apès avoir lancé le script:

Image 15


## 2.4 - Ajout de l'affichage des 5 processus consommant le plus de CPU et Mémoire:

Image 16

Ajout dans le rapport :

Image 17


Partie 3 : Gestionnaire d'utilisateurs en masse

## 3.1 - Création du fichier CSV :

Image 18

## 3.2 - Création du script:

Image 19

Les comptes utilisateurs sont bien crées au lancement du script :

Image 20

## 3.3 et 3.4 - Amélioration du script et ajout d'une option de suppression

Image 21


# Partie 4 : Nettoyeur de système automatique

## 4.1 - Création du script

Image 22

Image 23

## 4.2 - Ajout d'un mode sécurisé :

Image 24

## 4.3 - Amélioration :

Image 25

# Partie 5 : Vérificateur de santé des services

## 5.1 - Création d'un fichier de configuration services.conf listant les services à surveiller :

Image 26

## 5.2 - Création du script :

Image 26

Le script fonctionne :

Image 27

## 5.3 - Ajout de fonctionnalités avancées :

Image 28

## 5.4 - Création d'un mode monitoring :

Image 29

# Partie 6 : Outil centralisé de gestion

Image 29




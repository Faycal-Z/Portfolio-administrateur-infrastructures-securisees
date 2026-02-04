# Portfolio : Automatisation et Administration Linux (Bash)

## Ce dépôt contient l'ensemble des scripts réalisés. L'objectif est d'automatiser des tâches courantes : sauvegarde, monitoring, gestion des utilisateurs et nettoyage.

# Partie 1 : Script de sauvegarde automatisée

## 1.1 - Création du script

![](images/2.png)

## 1.2 - Amélioration du script

![](images/3.png)

![](images/4.png)

## 1.3 - Ajout d'une rotation des sauvegardes

Ajout du bloc de code pour la rotation des sauvegardes

![](images/5.png)


# 1.4 - Test du script avec différents scénarios

- Sauvegarde d'un dossier existant:

![](images/6.png)

- Tentative de sauvegarde d'un dossier inexistant :

![](images/7.png)

- Exécutions multiples pour vérifier la rotation :

Création de 10 sauvegardes pour essayer:
```sudo touch /backup/backup_test_vieux_{1..10}.tar.gz```

Les fichiers sont bien crées :

![](images/8.png)

Après le lancement du script nous avons bien le message de confirmation et il ne reste plus que 7 sauvegardes:

![](images/9.png)


# Partie 2 : Moniteur de ressources système

## 2.1 - Création du script Monitor:

![](images/10.png)

## 2.2 - Ajout d'un système d'alertes colorées :

![](images/11.png)

![](images/12.png)

Les couleurs s'affichent bien :

![](images/13.png)

## 2.3 - Création d'une option pour générer un rapport texte :

- Stockage du disque dans une variable pour pouvoir la réutiliser dans le rapport:

![](images/14.png)

- Création d'un bloc rapport:

![](images/15.png)

- Le rapport est bien crée apès avoir lancé le script:

![](images/16.png)


## 2.4 - Ajout de l'affichage des 5 processus consommant le plus de CPU et Mémoire:

![](images/17.png)

Ajout dans le rapport :

![](images/18.png)


Partie 3 : Gestionnaire d'utilisateurs en masse

## 3.1 - Création du fichier CSV :

![](images/19.png)

## 3.2 - Création du script:

![](images/20.png)

Les comptes utilisateurs sont bien crées au lancement du script :

![](images/21.png)

## 3.3 et 3.4 - Amélioration du script et ajout d'une option de suppression

![](images/22.png)


# Partie 4 : Nettoyeur de système automatique

## 4.1 - Création du script

![](images/23.png)

![](images/24.png)

## 4.2 - Ajout d'un mode sécurisé :

![](images/25.png)

## 4.3 - Amélioration :

![](images/26.png)

# Partie 5 : Vérificateur de santé des services

## 5.1 - Création d'un fichier de configuration services.conf listant les services à surveiller :

![](images/27.png)

## 5.2 - Création du script :

![](images/28.png)

Le script fonctionne :

![](images/29.png)

## 5.3 - Ajout de fonctionnalités avancées :

![](images/30.png)

## 5.4 - Création d'un mode monitoring :

![](images/31.png)

# Partie 6 : Outil centralisé de gestion

![](images/32.png)





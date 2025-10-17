# Challenge_E07_Gestionnaire_de_mot_de_passe
Choix et installation d'un gestionnaire de mot de passe

Ce projet documente la mise en œuvre d'une solution de gestion de mots de passe robuste, Bitwarden.

## 🎯 Contexte et Objectif

L'objectif de ce challenge était de sélectionner et de déployer un gestionnaire de mots de passe respectant les meilleures pratiques de sécurité et de le configurer de manière sécurisée.

## 🛠️ Outils et Technologies

* **Gestionnaire de Mots de Passe :** Bitwarden
* **Système d'exploitation :** Windows
* **Navigateur :** Edge
* **Méthode d'Authentification à Deux Facteurs (2FA) :** E-mail

## 🚀 Étapes Clés de la Mise en Œuvre

Le déploiement a été réalisé en suivant plusieurs étapes pour garantir la sécurité.

### 1. Création du Compte et Définition du Mot de Passe Maître

Suite au choix du gestionnaire de mot de passe Bitwarden, la première étape a été la création du coffre-fort numérique. Une attention particulière a été portée à la création d'un **mot de passe maître** robuste, en utilisant une **phrase de passe** longue plutôt qu'un mot de passe court. Cette méthode augmente considérablement la complexité tout en facilitant la mémorisation.

### 2. Installation des Outils Clients

Pour une intégration parfaite dans l'environnement de travail, deux composants ont été installés :
* **L'extension de navigateur :** Pour la capture et le remplissage automatique des identifiants sur les sites web.
* **L'application de bureau Windows :** Pour un accès centralisé et hors ligne au coffre-fort, et pour une gestion des identifiants.

### 3. Configuration des Paramètres de Sécurité

Plusieurs paramètres ont été configurés pour renforcer la sécurité du coffre-fort :

* **Verrouillage automatique :** Le délai d'expiration du coffre-fort a été laissé sur une courte période (15 minutes par défaut).

* **Activation de l'Authentification à Deux Facteurs (2FA) :** Une deuxième couche de sécurité a été ajoutée, la vérification par e-mail ( d'autres options sont également disponibles tels qu'une application dédiée).

* **Sauvegarde de la Clé de Récupération :** La clé de récupération fournie par Bitwarden lors de l'activation de la 2FA a été sauvegardée dans un lieu sûr et **hors ligne**. Cette étape est cruciale pour éviter une perte d'accès définitive en cas de problème avec la méthode 2FA.

## 🧠 Apprentissages et Conclusion

Ce challenge m'a permis de mettre en pratique des concepts fondamentaux de la **sécurité opérationnelle** :

* **Défense en profondeur :** La sécurité du coffre-fort ne repose pas uniquement sur le mot de passe maître, mais aussi sur la 2FA et le verrouillage automatique.
* **Gestion des secrets :** Un gestionnaire de mots de passe est la base pour une gestion sécurisée des "secrets" (mots de passe, clés API, etc.).
* **Plan de continuité :** La sauvegarde de la clé de récupération est une forme de plan de continuité, permettant de restaurer l'accès en cas d'incident.
.

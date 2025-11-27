# Consignes 🗒️: 
![](images/0.png)
![](images/01.png)
![](images/02.png)
![](images/03.png)
![](images/04.png)
![](images/05.png)


---


1. Créer les utilisateurs et UO:

- Création des deux nouveaux UO Zinc et Basilic:
![](images/1.png)
![](images/2.png)
![](images/3.png)

- Création des utilisateurs Roman BELDENT et Alice MARTIN:
  ![](images/4.png)
  ![](images/5.png)
  ![](images/6.png)
  ![](images/7.png)
  ![](images/8.png)

   * Même procédure pour créer l'utilisateur Alice MARTIN:
![](images/9.png)


2. Configurer les groupes et les dossier partagés:


- Création des groupes GS_PromoZinc et GS_PromoBasilic :
![](images/10.png)
![](images/11.png)
![](images/12.png)

    * Ajout du groupe GS_PromoZinc au groupe GS_Promotions
![](images/13.png)
![](images/14.png)
    
    * Ajout de l'utilisateur Roman BELDENT au groupe de promo GS_PromoZinc:
![](images/15.png)
![](images/16.png)
![](images/17.png)

    * Même procédure pour le groupe GS_PromoBasilic et Alice MARTIN, on constate que l'utilisateur est bien membre du groupe:
![](images/18.png)


- Configuration des dossiers partagés:
![](images/19.png)

   * Partage Rapide SMB:
   * 
![](images/20.png)

   * Volume C:
![](images/21.png)
   
   * Nom du partage: 
![](images/22.png)

   * Autorisation de la mise en cache :
![](images/23.png)

   * Personnalisation des autorisations:
   * 
![](images/24.png)

   * Désactivation de l'héritage:
![](images/25.png)
![](images/26.png)

   * Ajout des autorisations:
  ![](images/27.png)
![](images/28.png)
![](images/29.png)
![](images/30.png)
![](images/31.png)

   * Même procédure pour le partage de la promotion Basilic:
![](images/32.png)

3. Vérification des droits d'accès:

    - Connexion au domaine via le compte utilisateur Roman BELDENT et vérification des droits d'accès:
![](images/33.png)

    - L'utilisateur a bien accès au dossier PromoZinc partagé, en revanche il ne peux pas accéder à la PromoBasilic:
![](images/34.png)
![](images/35.png)

	* Après vérification pour l'utilisateur Alice Martin, les accès sont bien configurés (accès au partage de sa promo PromoBasilic uniquement).

    - Attribution d'un mappage pour les dossiers partagés:

      * Nous avons déjà un GPO pour le mappage, il faut donc le modifier:
![](images/36.png)
![](images/37.png)
       
      * Ajout de 2 lecteurs Z: pour les deux nouvelles promos:
![](images/38.png)
![](images/39.png)
![](images/40.png)
![](images/41.png)
![](images/42.png)
![](images/43.png)

        * Le lecteur Z: apparait bien :
![](images/44.png)

      - Restreindre les fichiers .divx: 

         * L'outil FSRM est déjà installé : 
![](images/45.png)

         * Dans groupes de fichiers:
![](images/46.png)
![](images/47.png)

         * Dans modèle de filtre de fichiers:
 ![](images/48.png)
     
         * Dans filtres de fichiers:
![](images/49.png)
![](images/50.png)

- Définir un quotas de 30go par promotions:
    * Création du modèle:
![](images/51.png)
![](images/52.png)
![](images/53.png)
     
    * Application du quota pour les 4 promotions:
![](images/54.png)
![](images/55.png)
![](images/56.png)

    * L'interdiction a bien été mise en place: 
![](images/57.png)

4. Ajouter et configurer les GPO:

	- Activer le verrou Numérique
 - ![](images/58.png)
 - ![](images/59.png)
 - ![](images/60.png)
 - ![](images/61.png)
 - ![](images/62.png)

   - Configurer une politique de mot de passe sécurisé:
![](images/63.png)
![](images/64.png)

	* Longueur du mot de passe à 12: 
![](images/65.png)

	* Durée de vie maximale à 30 jours
![](images/66.png)
![](images/67.png)

	* Forcer un fond d'écran par promotion:
	
	Pour la promotion Aldébaran : 
	![](images/68.png)
	![](images/69.png)
	![](images/70.png)
	![](images/71.png)

	* Puis application de la même procédure pour les trois autres promotions. Les fonds d'écran s'affichent en fonction des promotions, pour la promotion Basilic:

![](images/72.png)

	- Désactiver la connexion des étudiants Zinc et Basilic à partir de 17h jusqu’à 8h00 pour tout les jours de la semaine:
![](images/73.png)
![](images/74.png)
![](images/75.png)

	- Il est également possible de forcer la déconnexion en fonction des horaires spécifiés, via un gpo.

5. Bonus:

- Installer Firefox via les GPO pour tout les utilisateurs des promotions:

	* Téléchargement de la version MSI de Firefox sur le serveur.
![](images/76.png)

	* Création de la GPO:
![](images/77.png)
![](images/78.png)
![](images/79.png)
![](images/80.png)
![](images/81.png)

* Après un redémarrage Firefox est bien installé automatiquement.


6. Bonus Extrême: 

	- Création du dossier partagé Profils:
![](images/82.png)

	- Partage du dossier:
  ![](images/83.png)
![](images/84.png)
![](images/85.png)

	- Configuration des utilisateurs: 
![](images/88.png)

	- Création de la GPO:
![](images/89.png)
![](images/90.png)
![](images/91.png)

	- Les fichiers de l'utilisateurs apparaissent bien sur le serveur:
![](images/92.png)

	- Sur le PC utilisateur : 
![](images/93.png)

- Création de la GPO pour installer VSCode:
![](images/94.png)
![](images/95.png)
![](images/100.png)
![](images/97.png)
![](images/98.png)
![](images/99.png)
![](images/101.png)


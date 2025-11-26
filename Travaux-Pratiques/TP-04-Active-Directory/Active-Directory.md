# Consignes 🗒️: 


1. Créer les utilisateurs et UO:

- Création des deux nouveaux UO Zinc et Basilic:
Image 1, 2, 3

- Création des utilisateurs Roman BELDENT et Alice MARTIN:
Image 4, 5, 6, 7, 8

   * Même procédure pour créer l'utilisateur Alice MARTIN:
Image 9


2. Configurer les groupes et les dossier partagés:


- Création des groupes GS_PromoZinc et GS_PromoBasilic :
Image 10, 11, 12

    * Ajout du groupe GS_PromoZinc au groupe GS_Promotions
Image 13, 14
    
    * Ajout de l'utilisateur Roman BELDENT au groupe de promo GS_PromoZinc:
Image 15, 16, 17

    * Même procédure pour le groupe GS_PromoBasilic et Alice MARTIN, on constate que l'utilisateur est bien membre du groupe:
Image 18


- Configuration des dossiers partagés:
Image 19
   * Partage Rapide SMB:
Image 20
   * Volume C:
Image 21
   
   * Nom du partage: 
Image 22

   * Autorisation de la mise en cache :
Image 23

   * Personnalisation des autorisations:
Image 24

   * Désactivation de l'héritage:
Image 25, 26

   * Ajout des autorisations:
Image 27, 28, 29, 30, 31

   * Même procédure pour le partage de la promotion Basilic:
Image 32


3. Vérification des droits d'accès:

    - Connexion au domaine via le compte utilisateur Roman BELDENT et vérification des droits d'accès:
Image 33

    - L'utilisateur a bien accès au dossier PromoZinc partagé, en revanche il ne peux pas accéder à la PromoBasilic:
Image 34, 35

	* Après vérification pour l'utilisateur Alice Martin, les accès sont bien configurés (accès au partage de sa promo PromoBasilic uniquement).

    - Attribution d'un mappage pour les dossiers partagés:

      * Nous avons déjà un GPO pour le mappage, il faut donc le modifier:
Image 36, 37
       
      * Ajout de 2 lecteurs Z: pour les deux nouvelles promos:
Images 38, 39, 40 ,41 , 42, 43

        * Le lecteur Z: apparait bien :
Image 44

      - Restreindre les fichiers .divx: 

         * L'outil FSRM est déjà installé : 
Image 45

         * Dans groupes de fichiers:
Image 46, 47

         * Dans modèle de filtre de fichiers:

Image 48
        
         * Dans filtres de fichiers:
Image 49, 50

- Définir un quotas de 30go par promotions:
    * Création du modèle:
Image 51, 52, 53
     
    * Application du quota pour les 4 promotions:
Image 54, 55, 56

    * L'interdiction a bien été mise en place: 
Image 57



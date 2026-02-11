# Registre des Risques - Projet Modernisation Infrastructure IT

**Contexte :** Campus de 500 personnes (salariés, formateurs, apprenants). Équipe IT composée du responsable et d'un alternant. 
**Périmètre :** Déploiement serveurs de fichiers, NAS, firewall, VLANs et accès sécurisé Wi-Fi.

## Évaluation des risques

L'évaluation est basée sur l'échelle suivante :
* **Probabilité :** Faible (1), Moyenne (2), Forte (3)
* **Impact :** Faible (1), Moyen (2), Critique (3)
* **Criticité =** Probabilité × Impact

---

## Tableau du Registre des Risques (Classé par criticité)

| | Description du Risque | Catégorie | Probabilité | Impact | Criticité |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **1** | **Surcharge de l'équipe IT :** L'équipe (admin + alternant) doit gérer les incidents quotidiens des 500 utilisateurs, bloquant alors l'avancée du projet. | Organisationnel | Forte | Moyen | **6** |
| **2** | **Coupure prolongée d'accès Internet :** Mauvaise configuration de routage lors de la bascule du Firewall, paralysant les cours. | Technique | Moyen | Critique | **6** |
| **3** | **Erreur configuration firewall ou de segmentation des VLANs :** Mauvaise configuration (mauvais accès aux différents services = faille de sécurité). | Technique | Moyenne | Critique | **6** |
| **4** | **Retard de livraison du matériel :** Délai du fournisseur allongé sur les switchs, le NAS ou le Firewall, décalant l'ensemble du planning de déploiement du projet. | Organisationnel | Forte | Moyen | **6** |
| **5** | **Erreur critique de l'alternant :** Mauvaise manipulation sur un équipement de production (switch/routeur). | Humain | Moyenne | Moyen | **4** |
| **6** | **Incompatibilité matérielle :** Anciens PC, cablages, switchs etc. | Technique | Moyenne | Moyen | **4** |
| **7** | **Perte de données pendant la migration :** Corruption ou effacement des données lors du transfert vers le nouveau NAS. | Technique | Faible | Critique | **3** |
| **8** | **Coupure électrique matérielle :** Micro-coupure ou panne de courant pendant la mise à jour critique d'un équipement (conséquences pouvant etre irréversibles sur le matériel). | Technique | Faible | Critique | **3** |
| **9** | **Absence de l'alternant :** Arrêt ou départ imprévu, réduisant de manière significative la force de travail technique disponible. | Humain | Faible | Moyen | **2** |
| **10** | **Dépassement du budget :** Sous-estimation initiale des coûts annexes (licences obligatoires, câblages supplémentaires..). | Organisationnel | Moyenne | Faible | **2** |

# Mini-PRA : Panne Critique Serveur

**Document pour la continuité des services IT du Campus.**

## 1. Scénario d'Incident Majeur
**"Crash du NAS / Serveur de Fichiers"**
* **Cause possible :** Panne matérielle (disques, carte mère), incendie salle serveur, ou ransomware.
* **Impact :** Accès impossible aux supports de cours (Formateurs/Apprenants) et aux données administratives (Salariés).

## 2. Objectifs de Reprise (SLA)
* **RTO (Délai de reprise) :** 4 Heures maximum pour les données vitales (Administration + Cours du jour).
* **RPO (Perte de données) :** 24 Heures max (Retour à la sauvegarde de la veille au soir).

## 3. Mesures Préventives
* **Architecture :** Disques en RAID 5 ou 6.
* **Sauvegardes :** Backup quotidien automatisé sur support externe déconnecté.
* **Énergie :** Onduleur pilotable pour extinction propre en cas de coupure électrique.

## 4. Procédure de Reprise
* **T0 (Alerte) :** L'alternant confirme la panne physique. Notification immédiate aux usagers (SMS/Mail).
* **T+30min (Décision) :** Si redémarrage impossible, le Responsable IT active le Mode Dégradé.
* **T+1h (Action) :** Isolation du serveur HS. Activation du NAS de secours (ou PC temporaire).
* **T+2h (Restauration) :** Copie prioritaire des dossiers `ADMINISTRATION` et `COURS_ACTUELS`.
* **T+4h (Service Rétabli) :** Redirection des utilisateurs vers le stockage de secours.

## 5. Rôles et Responsabilités
| Acteur | Responsabilité |
| :--- | :--- |
| **Responsable IT** | Décision de déclencher le PRA. Restauration technique des données. |
| **L'Alternant** | Diagnostic premier niveau. Communication avec les formateurs. Installation physique du matériel de secours. |

## 6. Indicateurs de Succès
- Les cours peuvent reprendre avec accès aux supports en moins de 4h.
- Aucune donnée administrative de plus de 24h n'est perdue.

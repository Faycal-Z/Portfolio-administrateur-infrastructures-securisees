#!/bin/bash

# Vérification root
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être lancé avec sudo."
    exit 1
fi

LOG_FILE="/var/log/cleanup.log"
OPTION="$1"
JOURS="$2"

# Si pas de jours précisés, par défaut 7
if [ -z "$JOURS" ]; then
    JOURS=7
fi

echo "Démarrage du nettoyage"
echo "--- Rapport du $(date) ---" >> "$LOG_FILE"

# 1. Afficher l'espace disque avant
echo "Espace avant :"
df -h / | grep /

# 2. Calcul des statistiques (Simulation)
# On compte les lignes (wc -l) pour savoir combien de fichiers sont concernés
NB_TMP=$(find /tmp -type f -mtime +$JOURS 2>/dev/null | wc -l)
NB_LOGS=$(find /var/log -name "*.gz" -type f -mtime +$JOURS 2>/dev/null | wc -l)
TAILLE_CACHE=$(du -sh /var/cache/apt/archives 2>/dev/null | cut -f1)

# Vérification du mode
if [ "$OPTION" == "-f" ] || [ "$OPTION" == "--force" ]; then

    read -p "Confirmer la suppression (Fichiers > $JOURS jours) ? (o/n) " REP

    if [ "$REP" == "o" ]; then
        
        # 3. Suppression fichiers /tmp
        find /tmp -type f -mtime +$JOURS -exec rm -f {} \; 2>/dev/null
        
        # 4. Suppression logs compressés
        find /var/log -name "*.gz" -type f -mtime +$JOURS -exec rm -f {} \; 2>/dev/null

        # 5. Vidage corbeille utilisateurs
        for user in /home/*; do
            rm -rf "$user/.local/share/Trash/*" 2>/dev/null
        done

        # 6. Nettoyage cache APT
        apt-get clean

        echo "Nettoyage effectué."
        
        # Écriture dans le log
        echo "Nettoyage effectué avec succès." >> "$LOG_FILE"
        echo "Statistiques :" >> "$LOG_FILE"
        echo "- Fichiers tmp supprimés : $NB_TMP" >> "$LOG_FILE"
        echo "- Logs archivés supprimés : $NB_LOGS" >> "$LOG_FILE"
        echo "- Cache APT nettoyé : $TAILLE_CACHE" >> "$LOG_FILE"

    else
        echo "Annulation."
    fi

else
    # Mode simulation
    echo "Mode simulation (rien n'est supprimé)"
    echo "Critère d'âge : plus de $JOURS jours"
    echo "Statistiques prévisionnelles :"
    echo "- Fichiers tmp à supprimer : $NB_TMP"
    echo "- Logs à supprimer : $NB_LOGS"
    echo "- Taille du cache APT : $TAILLE_CACHE"
    echo "Utilisez -f pour supprimer réellement"
fi

# 7. Afficher l'espace disque après
echo "Espace après :"
df -h / | grep /

echo "Nettoyage terminé"
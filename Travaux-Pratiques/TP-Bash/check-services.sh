#!/bin/bash

# Définition des couleurs
VERT="\e[32m"
ROUGE="\e[31m"
JAUNE="\e[33m"
NORMAL="\e[0m"

FICHIER_CONF="services.conf"
LOG_FILE="/var/log/services_monitor.log"

# Vérification root (nécessaire pour relancer les services)
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être lancé avec sudo pour redémarrer les services."
    exit 1
fi

# Vérification présence fichier conf
if [ ! -f "$FICHIER_CONF" ]; then
    echo "Erreur : Fichier $FICHIER_CONF manquant."
    exit 1
fi

NB_ACTIF=0
NB_INACTIF=0
NB_RESTART=0

echo "--- Vérification des services ---"

# Lecture du fichier (avec astuce || -n pour lire la dernière ligne même sans saut de ligne)
while read -r SERVICE || [ -n "$SERVICE" ]; do
    
    # Ignorer les lignes vides
    if [ -z "$SERVICE" ]; then
        continue
    fi

    # 1. Vérification de l'état
    if systemctl is-active --quiet "$SERVICE"; then
        echo -e "${VERT}[OK] $SERVICE est actif${NORMAL}"
        ((NB_ACTIF++))
    else
        echo -e "${ROUGE}[KO] $SERVICE est inactif${NORMAL}"
        
        # 2. Tentative de redémarrage (Ajout 5.3)
        echo -e "${JAUNE} -> Tentative de redémarrage de $SERVICE...${NORMAL}"
        systemctl start "$SERVICE" 2>/dev/null
        
        # 3. Vérification après redémarrage
        if systemctl is-active --quiet "$SERVICE"; then
            echo -e "${VERT} -> SUCCÈS : $SERVICE redémarré${NORMAL}"
            echo "$(date) : $SERVICE était down, redémarré avec succès." >> "$LOG_FILE"
            ((NB_RESTART++))
            ((NB_ACTIF++))
        else
            echo -e "${ROUGE} -> ECHEC : Impossible de relancer $SERVICE${NORMAL}"
            echo "$(date) : $SERVICE est down, échec du redémarrage." >> "$LOG_FILE"
            ((NB_INACTIF++))
        fi
    fi

done < "$FICHIER_CONF"

# 4. Affichage du résumé
echo "---------------------------------"
echo "Résumé :"
echo "Actifs (Total)   : $NB_ACTIF"
echo "Inactifs         : $NB_INACTIF"
echo "Redémarrés       : $NB_RESTART"
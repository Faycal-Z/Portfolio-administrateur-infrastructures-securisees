#!/bin/bash

# Variables
VERSION="1.0"
AUTEUR="Faycal"
LOG_FILE="/var/log/sysadmin-tools.log"

# Vérification root
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être lancé avec sudo."
    exit 1
fi

# Fonction de log
log_action() {
    echo "$(date) - User: $SUDO_USER - Action: $1" >> "$LOG_FILE"
}

# Fonction de pause
pause() {
    echo ""
    read -p "Appuyez sur Entrée pour revenir au menu..."
}

# Vérification existence des scripts
for script in ./create-users.sh ./cleanup.sh ./check-services.sh; do
    if [ ! -f "$script" ]; then
        echo "Attention : $script introuvable."
    fi
done

# Boucle du menu
while true; do
    clear
    echo "================================="
    echo "    OUTILS D'ADMINISTRATION      "
    echo "    Version $VERSION par $AUTEUR "
    echo "================================="
    echo "1. Sauvegarde de répertoire"
    echo "2. Monitoring système"
    echo "3. Créer des utilisateurs"
    echo "4. Nettoyage système"
    echo "5. Vérifier les services"
    echo "6. Quitter"
    echo "================================="
    read -p "Votre choix : " CHOIX

    case $CHOIX in
        1)
            # Option 1 : Sauvegarde
            echo "--- Sauvegarde ---"
            if [ -f "./backup.sh" ]; then
                read -p "Répertoire à sauvegarder : " REP
                ./backup.sh "$REP"
                log_action "Lancement backup sur $REP"
            else
                echo "Erreur : script backup.sh manquant."
            fi
            pause
            ;;
        2)
            # Option 2 : Monitoring
            echo "--- Monitoring ---"
            if [ -f "./monitor.sh" ]; then
                ./monitor.sh
                log_action "Lancement monitoring"
            else
                echo "Script monitor.sh manquant. Affichage htop :"
                top -b -n 1 | head -n 10
            fi
            pause
            ;;
        3)
            # Option 3 : Utilisateurs
            echo "--- Création Utilisateurs ---"
            if [ -f "./create-users.sh" ]; then
                read -p "Fichier CSV : " CSV
                read -p "Supprimer les utilisateurs ? (o/n) : " DEL
                
                if [ "$DEL" == "o" ]; then
                    ./create-users.sh "$CSV" --delete
                    log_action "Lancement create-users DELETE sur $CSV"
                else
                    ./create-users.sh "$CSV"
                    log_action "Lancement create-users CREATE sur $CSV"
                fi
            else
                echo "Erreur : script create-users.sh manquant."
            fi
            pause
            ;;
        4)
            # Option 4 : Nettoyage
            echo "--- Nettoyage Système ---"
            if [ -f "./cleanup.sh" ]; then
                read -p "Forcer le nettoyage ? (o/n) : " FORCE
                if [ "$FORCE" == "o" ]; then
                    ./cleanup.sh -f
                    log_action "Lancement cleanup FORCE"
                else
                    ./cleanup.sh
                    log_action "Lancement cleanup SIMULATION"
                fi
            else
                echo "Erreur : script cleanup.sh manquant."
            fi
            pause
            ;;
        5)
            # Option 5 : Services
            echo "--- Vérification Services ---"
            if [ -f "./check-services.sh" ]; then
                ./check-services.sh
                log_action "Lancement check-services"
            else
                echo "Erreur : script check-services.sh manquant."
            fi
            pause
            ;;
        6)
            # Option 6 : Quitter
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Choix invalide."
            sleep 1
            ;;
    esac
done
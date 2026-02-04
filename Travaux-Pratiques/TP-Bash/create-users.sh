#!/bin/bash

#Variables pour les fichiers
LOG_FILE="/var/log/user-creation.log"
RAPPORT_TXT="users_created.txt"

# On utilise > pour vider le fichier au départ
> "$RAPPORT_TXT"

# Vérification de l'argument
if [ -z "$1" ]; then
    echo "Usage : sudo ./create-users.sh <fichier.csv> [--delete]"
    exit 1
fi

FICHIER_CSV="$1"
# Ajout variable pour l'option
OPTION="$2"

# Vérification de l'existence du fichier
if [ ! -f "$FICHIER_CSV" ]; then
    echo "Erreur : Le fichier $FICHIER_CSV est introuvable."
    exit 1
fi

# Ajout affichage du mode
if [ "$OPTION" == "--delete" ]; then
    echo "--- MODE SUPPRESSION ACTIVÉ ---"
else
    echo "--- Démarrage de la création des utilisateurs ---"
fi

# Lecture du fichier ligne par ligne
while IFS=, read -r PRENOM NOM DEPARTEMENT FONCTION
do
    # Saut de la ligne d'en-tête
    if [ "$PRENOM" == "prenom" ]; then
        continue
    fi

    # 1. Création du LOGIN (Sert pour création et suppression)
    LOGIN=$(echo "${PRENOM:0:1}$NOM" | tr '[:upper:]' '[:lower:]')

    # Ajout condition : Mode Suppression OU Mode Création
    if [ "$OPTION" == "--delete" ]; then
        
        # Ajout demande de confirmation
        read -p "Voulez-vous supprimer l'utilisateur $LOGIN ? (o/n) " REP
        
        if [ "$REP" == "o" ]; then
            if id "$LOGIN" &>/dev/null; then
                # Ajout suppression utilisateur et dossier
                userdel -r "$LOGIN"
                echo "Utilisateur $LOGIN supprimé."
                # Ajout log suppression
                echo "$(date) : SUPPRESSION - $LOGIN supprimé" >> "$LOG_FILE"
            else
                echo "L'utilisateur $LOGIN n'existe pas."
            fi
        else
            echo "Suppression annulée pour $LOGIN."
        fi

    else
        # --- MODE CRÉATION (Ton code habituel) ---

        #Création du groupe
        if ! grep -q "^$DEPARTEMENT:" /etc/group; then
            groupadd "$DEPARTEMENT"
            echo "Groupe $DEPARTEMENT créé."
        fi
        
        # 2. Génération mot de passe aléatoire
        PASSWORD=$(openssl rand -base64 12)

        # 3. Création de l'utilisateur
        # Vérification de l'existence
        if id "$LOGIN" &>/dev/null; then
            echo " L'utilisateur $LOGIN existe déjà."

            # Ajout du log de l'erreur
            echo "$(date) : Echec - $LOGIN existe déjà" >> "$LOG_FILE"
        else
            # Création de l'utilisateur et du dossier personnel

            # Ajout du département
            useradd -m -s /bin/bash -c "$PRENOM $NOM" -g "$DEPARTEMENT" "$LOGIN"

            echo "$LOGIN:$PASSWORD" | chpasswd

            echo " Utilisateur créé : $LOGIN (Mdp: $PASSWORD)"

            # Remplissage du rapport et des logs
            echo "Login: $LOGIN | Mdp: $PASSWORD" >> "$RAPPORT_TXT"
            echo "$(date) : Succès - $LOGIN créé" >> "$LOG_FILE"
        fi
    fi

done < "$FICHIER_CSV"

echo "--- Terminé ---"
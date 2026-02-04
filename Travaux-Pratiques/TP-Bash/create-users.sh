#!/bin/bash

#Variables pour les fichiers
LOG_FILE="/var/log/user-creation.log"
RAPPORT_TXT="users_created.txt"

> "$RAPPORT_TXT"

# Vérification de l'argument
if [ -z "$1" ]; then
    echo "Usage : sudo ./create-users.sh <fichier.csv>"
    exit 1
fi

FICHIER_CSV="$1"

# Vérification de l'existence du fichier
if [ ! -f "$FICHIER_CSV" ]; then
    echo "Erreur : Le fichier $FICHIER_CSV est introuvable."
    exit 1
fi

echo "--- Démarrage de la création des utilisateurs ---"

# Lecture du fichier ligne par ligne
while IFS=, read -r PRENOM NOM DEPARTEMENT FONCTION
do
    # Saut de la ligne d'en-tête
    if [ "$PRENOM" == "prenom" ]; then
        continue
    fi

    # Ajout de la création du groupe
    if ! grep -q "^$DEPARTEMENT:" /etc/group; then
        groupadd "$DEPARTEMENT"
        echo "Groupe $DEPARTEMENT créé."
    fi

    # 1. Création du LOGIN (1ère lettre prénom + nom, tout en minuscule)
    LOGIN=$(echo "${PRENOM:0:1}$NOM" | tr '[:upper:]' '[:lower:]')

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

done < "$FICHIER_CSV"
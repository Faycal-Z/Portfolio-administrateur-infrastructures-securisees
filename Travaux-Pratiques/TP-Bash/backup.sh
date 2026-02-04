#!/bin/bash

#On récupère le répertoire à sauvegarder
SOURCE=$1
DESTINATION="/backup"

#Format de la date et nom de l'archive
DATE=$(date +%Y%m%d_%H%M%S)
NOM_ARCHIVE="backup_$DATE.tar.gz"

#Création du dossier de destination
mkdir -p "$DESTINATION"

#Création de l'archive 
tar -czf "$DESTINATION/$NOM_ARCHIVE" "$SOURCE" 2>/dev/null

#Affichage du message de confirmation et de la taille
echo "Sauvegarde réussie dans : $DESTINATION/$NOM_ARCHIVE"
du -h "$DESTINATION/$NOM_ARCHIVE"




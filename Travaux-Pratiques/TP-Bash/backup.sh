#!/bin/bash

#Configuration et ajout du fichier LOGFILE
SOURCE=$1
DESTINATION="/backup"
LOGFILE="/var/log/backup.log"

#Message log
log_message() {
    # Affiche la date, le message, et l'écrit aussi dans le fichier log
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

#Vérification de l'argument et message d'erreur
if [ -z "$1" ]; then
    echo "Erreur : Précisez un dossier."
    exit 1
fi

#Ajout de la création du fichier log et vérification
mkdir -p "$DESTINATION"
touch "$LOGFILE" 2>/dev/null

#Format de la date et nom de l'archive
DATE=$(date +%Y%m%d_%H%M%S)
NOM_ARCHIVE="backup_$DATE.tar.gz"

#Vérification de l'existence du dossier source
if [ ! -d "$SOURCE" ]; then
    log_message "ERREUR : Le dossier source '$SOURCE' n'existe pas !"
    exit 1
fi

#Vérification de l'espace de disque
TAILLE_SOURCE=$(du -s "$SOURCE" | awk '{print $1}')
ESPACE_DISPO=$(df "$DESTINATION" | tail -1 | awk '{print $4}')
if [ "$TAILLE_SOURCE" -gt "$ESPACE_DISPO" ]; then
    log_message "ERREUR : Espace disque insuffisant dans $DESTINATION."
    exit 1
fi


#Création de l'archive 
log_message "Démarrage de la sauvegarde de $SOURCE..."
tar -czf "$DESTINATION/$NOM_ARCHIVE" "$SOURCE" 2>/dev/null

#Vérification et affichage du message
if [ $? -eq 0 ]; then
    log_message "SUCCÈS : Archive créée ($DESTINATION/$NOM_ARCHIVE)"
else
    log_message "ERREUR : Échec de la compression."
    exit 1
fi

#Récupération des anciens fichiers
VIEUX_BACKUPS=$(ls -1t "$DESTINATION"/backup_*.tar.gz 2>/dev/null | tail -n +8)

#Vérification de la liste et rotation des sauvegardes
if [ -n "$VIEUX_BACKUPS" ]; then
   
    NOMBRE=$(echo "$VIEUX_BACKUPS" | wc -l)
    
    log_message "ROTATION : Suppression de $NOMBRE ancienne(s) sauvegarde(s)..."

    #Suppression des anciens backup
    echo "$VIEUX_BACKUPS" | xargs rm -f
    
    log_message "Nettoyage terminé."
else
    log_message "ROTATION : Pas de suppression nécessaire (moins de 7 sauvegardes)."
fi





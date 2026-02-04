#!/bin/bash

#Ajout des couleurs
VERT="\e[32m"
JAUNE="\e[33m"
ROUGE="\e[31m"
RESET="\e[0m"

#Fonction couleurs en fonction du pourcentage
afficher_couleur() {
    local VALEUR=$1
    
    local ENTIER=$(echo "$VALEUR" | awk '{print int($1)}')

    if [ "$ENTIER" -ge 85 ]; then
        echo -e "${ROUGE}${VALEUR}%${RESET}"   
    elif [ "$ENTIER" -ge 70 ]; then
        echo -e "${JAUNE}${VALEUR}%${RESET}"   
    else
        echo -e "${VERT}${VALEUR}%${RESET}"   
    fi
}

#Titre du script
echo "==========================="
echo "         MONITOR           "
echo "==========================="

#Nom du serveur
echo "Serveur   : $(hostname)"

#Date et heure actuelles
echo "Date      : $(date '+%Y-%m-%d %H:%M:%S')"

#Uptime du système
echo "Uptime    : $(uptime)"

#Utilisation CPU
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
COLOR_CPU=$(afficher_couleur "$CPU_USAGE")
echo -e "CPU Usage : $COLOR_CPU"

#Utilisation mémoire
MEM_TOTAL=$(free -h | grep Mem | awk '{print $2}')
MEM_USED=$(free -h | grep Mem | awk '{print $3}')
MEM_PERCENT=$(free | grep Mem | awk '{printf("%.2f", $3/$2 * 100.0)}')
COLOR_MEM=$(afficher_couleur "$MEM_PERCENT")
echo -e "Mémoire   : $MEM_USED / $MEM_TOTAL ($COLOR_MEM)"

#Stockage du disque dans variable
DISK_USAGE=$(df -h | grep -vE '^Filesystem|tmpfs|cdrom|udev|loop' | awk '{ print $5 " " $1 }')
echo "Disque: "
echo "$DISK_USAGE"

#Nombre de processus en cours d'exécution
PROCESS_COUNT=$(ps -e | wc -l)
echo "Processus en cours : $PROCESS_COUNT"

#Récupération des 5 processus qui consomment le plus et affichage
TOP_CPU_LIST=$(ps -eo %cpu,%mem,cmd --sort=-%cpu | head -n 6)
TOP_MEM_LIST=$(ps -eo %mem,%cpu,cmd --sort=-%mem | head -n 6)
echo "TOP 5 CPU"
echo "$TOP_CPU_LIST"
echo "Top 5 RAM"
echo "$TOP_MEM_LIST"

#Création du rapport
if [ "$1" == "-r" ]; then
    # Nom du fichier avec date 
    FICHIER_LOG="/var/log/monitor_$(date +%Y%m%d).txt"

    {
        echo "=================================="
        echo "   MONITOR - $(date)"
        echo "=================================="
        echo "Serveur   : $(hostname)"
        echo "Uptime    : $(uptime -p)"
        echo "CPU Usage : $CPU_USAGE%"
        echo "Mémoire   : $MEM_USED / $MEM_TOTAL ($MEM_PERCENT%)"
        echo "----------------------------------"
        echo "Disque :"
        echo "$DISK_USAGE"
        echo "----------------------------------"
        echo "Processus : $PROCESS_COUNT"
        #Ajout TOP 5 CPU et RAM
        echo "TOP 5 CPU :"
        echo "$TOP_CPU_LIST"
        echo "TOP 5 RAM :"
        echo "$TOP_MEM_LIST"
    } > "$FICHIER_LOG"

    #Message de confirmation
    echo -e "${VERT} Rapport sauvegardé dans : $FICHIER_LOG${RESET}"
fi
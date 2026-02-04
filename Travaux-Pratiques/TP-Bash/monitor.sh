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
echo "CPU Usage : $CPU_USAGE%"

#Utilisation mémoire
MEM_TOTAL=$(free -h | grep Mem | awk '{print $2}')
MEM_USED=$(free -h | grep Mem | awk '{print $3}')
MEM_PERCENT=$(free | grep Mem | awk '{printf("%.2f", $3/$2 * 100.0)}')
echo "Mémoire   : $MEM_USED / $MEM_TOTAL ($MEM_PERCENT%)"

#Utilisation de chaque partition
df -h | grep -vE '^Filesystem|tmpfs|cdrom|udev|loop' | awk '{ print $5 " " $1 }'

#Nombre de processus en cours d'exécution
PROCESS_COUNT=$(ps -e | wc -l)
echo "Processus en cours : $PROCESS_COUNT"
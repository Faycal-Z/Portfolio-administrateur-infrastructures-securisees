🛠️ Installation et Configuration de Veeam Backup & Replication (TP-S08)
Ce document résume l'installation du serveur de sauvegarde Veeam sur une machine virtuelle Windows 10 Pro, hébergée sous Proxmox, dans le cadre du TP de sauvegarde.

1. Création de la Machine Virtuelle (Proxmox)
Création d'une VM Windows 10 respectant les prérequis du TP pour supporter la charge de Veeam.

Nom : TP-S08-Veeam

OS : Windows 10 Pro

CPU : 2 vCores (Type Host)

RAM : 4 Go (4096 Mo)

Disque : 100 Go

Réseau : Carte Intel E1000 sur le pont vmbr2 (LAN)

(Insérer ici une capture d'écran de l'onglet "Résumé" ou "Matériel" de Proxmox)

2. Configuration Initiale de Windows & Clonage
Après l'installation standard de Windows 10, plusieurs actions préparatoires ont été effectuées.

A. Activation du compte Administrateur
Pour respecter les consignes de sécurité du TP et avoir les pleins droits, le compte Administrateur intégré a été activé via l'invite de commande :

DOS

net user administrateur /active:yes
net user administrateur * (Définition du mot de passe)
B. Clonage pour le futur client
Avant d'installer Veeam (pour garder une image "propre"), la VM a été clonée pour créer le futur poste client.

Nom du clone : TP-S08-Win10Client

Mode : Full Clone

(Insérer ici une capture d'écran de Proxmox montrant les deux VMs)

3. Configuration du Serveur Veeam
Sur la VM TP-S08-Veeam, la configuration réseau et système a été finalisée.

A. Renommage et IP Statique
Nom de la machine : Veeam

Adressage IP : Statique

IP : 10.0.1.3

Masque : 255.255.0.0 (/16)

Passerelle : 10.0.0.1

DNS : 8.8.8.8 (Temporaire pour l'installation)

(Insérer ici une capture d'écran de la configuration IPv4 ncpa.cpl)

4. Installation de Veeam Backup & Replication
L'installation a été réalisée à partir de l'image ISO montée directement via le lecteur CD virtuel de Proxmox.

Version : Veeam Backup & Replication 12.2 (Community Edition)

Licence : Aucune (Mode gratuit Community)

Compte de service : LOCAL SYSTEM account (Par défaut)

Base de données : PostgreSQL (Installé automatiquement)

(Insérer ici une capture d'écran de l'installateur Veeam)

5. Validation
L'installation s'est terminée avec succès. L'accès à la console Veeam est fonctionnel via l'écran de login.

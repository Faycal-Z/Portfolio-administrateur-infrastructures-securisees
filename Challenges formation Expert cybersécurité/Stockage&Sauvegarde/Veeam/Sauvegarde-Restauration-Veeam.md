# 🛠️ Sauvegarde et restauration avec Veeam
Pour cet exercice, j'ai procédé à une sauvegarde Veeam et à une restauration.

# 1. Création des dossiers de partage sur TrueNAS

Création d'un dossier de partage UNIXI (NFS) :

![MV](./images/14.png)

Montage du volume NFS :

![MV](./images/27.png)
![MV](./images/28.png)  

# 2. Ajout des volumes dans Veeam :

 Inventory : Unstructured Data et Add Data Source :

 ![MV](./images/17.png)

 ![MV](./images/18.png)

 On commence par le volume dataset SMB :

 ![MV](./images/19.png)

 On ajoute notre utilisateur TrueNAS :

 ![MV](./images/20.png)

 ![MV](./images/24.png)

 ![MV](./images/22.png)

 ![MV](./images/23.png)

 ![MV](./images/26.png)

 On recommence la procedure pour le volume NFS :

 ![MV](./images/29.png)

 ![MV](./images/30.png)

 ![MV](./images/31.png)

 ![MV](./images/32.png)
 
 ![MV](./images/33.png)

 ![MV](./images/34.png)

 Les deux volumes on bien été ajoutés :

 ![MV](./images/35.png)

 
# 3. Configuration d'une Backup :


 

 

 


 

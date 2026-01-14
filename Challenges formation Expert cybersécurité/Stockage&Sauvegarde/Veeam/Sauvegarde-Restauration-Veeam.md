# 🛠️ Sauvegarde et restauration avec Veeam
Pour cet exercice, j'ai procédé à une sauvegarde Veeam et à une restauration.

# 1. Création des dossiers de partage sur TrueNAS

## Création d'un dossier de partage UNIXI (NFS) :

![MV](./images/14.png)

## Montage du volume NFS :

![MV](./images/27.png)
![MV](./images/28.png)  

# 2. Ajout des volumes dans Veeam :

 ## Inventory : Unstructured Data et Add Data Source :

 ![MV](./images/17.png)

 ![MV](./images/18.png)

 ## On commence par le volume dataset SMB :

 ![MV](./images/19.png)

 ## On ajoute notre utilisateur TrueNAS :

 ![MV](./images/20.png)

 ![MV](./images/24.png)

 ![MV](./images/22.png)

 ![MV](./images/23.png)

 ![MV](./images/26.png)

 ## On recommence la procedure pour le volume NFS :

 ![MV](./images/29.png)

 ![MV](./images/30.png)

 ![MV](./images/31.png)

 ![MV](./images/32.png)
 
 ![MV](./images/33.png)

 ![MV](./images/34.png)

 ## Les deux volumes ont bien été ajoutés :

 ![MV](./images/35.png)


# 3. Ajout d'un Backup Repository dans le NFS :

 ![MV](./images/41.png)

 ![MV](./images/42.png)

 ![MV](./images/43.png)

 ![MV](./images/44.png)

 ![MV](./images/45.png)

 ![MV](./images/46.png)

 ![MV](./images/47.png)

 ![MV](./images/48.png)

 ![MV](./images/49.png)

 ![MV](./images/50.png)

 ![MV](./images/51.png)

 ![MV](./images/52.png)
 
# 4. Configuration d'une Backup :

![MV](./images/36.png)

![MV](./images/37.png)

![MV](./images/38.png)

![MV](./images/39.png)

![MV](./images/40.png)

## On sélectionne le Repository NFS que l'on a crée :

![MV](./images/53.png)

![MV](./images/54.png)

![MV](./images/55.png)

![MV](./images/56.png)

## Notre Backup est bien configurée :

![MV](./images/57.png)

## On peut lancer la Backup :

![MV](./images/58.png)

## On constate qu'il y'a des erreurs d'agent mais la Backup est tout de meme effectuée, on peut le constater en allant dans notre volume NFS:

![MV](./images/59.png)

![MV](./images/60.png)

# 4. Restauration

## Pour tester la restauration, on va supprimer les fichiers présents dans le volume SMB :

![MV](./images/61.png)

## On peut désormais lancer la restauration :

![MV](./images/62.png)

![MV](./images/63.png)

![MV](./images/64.png)

![MV](./images/65.png)

![MV](./images/66.png)

![MV](./images/67.png)

![MV](./images/68.png)

![MV](./images/69.png)

![MV](./images/70.png)

![MV](./images/71.png)

## On constate que la restauration a bien été effectuée, les fichiers sont de nouveau disponibles :

![MV](./images/72.png)








 

 

 


 

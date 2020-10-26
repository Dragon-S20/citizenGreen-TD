# Citizen GreenTeam 

@Remy-Mil @Teresa0613 @Dragon-S20 @Yannistan @tekubambam

## **Description du TD**


Il s'agit dans ce TD de concevoir un appareil d'état fonctionnel et "démocratique" afin de gérer un population. 
Il s'appuit sur un collège de sages composé de trois entités (adresses admins).


### **Monnaie de ce cette nation, le token** ```CITIZEN ou CTZ ```


Le ``` CTZ ``` sert de monnaie et de point de citoyenneté dans l'état.
100 CITIZEN sont automatiquement attribués à qui souhaite devenir citoyen.
Un citoyen est par essence vivant, a plus de 18 ans, et ne doit pas demander sa citoyenneté si il est malade.
Lorsque celui-ci ne possède plus de CITIZEN il ne peut plus voter. 
Le super Admin de cette état sera l'adresse d'un smart contract et devra posséder 100% du cap de CITIZEN.

En exemple : voici la fonction (provisioire) ``` register ``` pour l'obtention de la citoyenneté :

``` 
function registerCitizen(address _addrcitizen, unit _age, bool _isIll ) public {
 citizens[_addrcitizen].isAlive = true;   
 citizens[_addrcitizen].nombreToken = 100;
 citizens[_addrcitizen].age = _age;
 citizens[_addrcitizen].isIll = _isIll;
 if (citizens[_addrcitizen].age >=18 && citizens[_addrcitizen].isIll == false) {
  citizens[_addrcitizen].idEnt = ;
}
```

### **Moyen d'achat du** ``` CITIZEN ```

Le CITIZEN ne peut être acheter que par les entreprises (le paiement des salaires se fait en citizen).
Ces entreprises devront s'enregistrer auprès de l'état, et cet enregistrement devra être validé par le conseil des sages.
Il a été défini qu'un système de paies au mois sera mis en place par les entreprises pour chacun de leurs salariés.
Dans l'énoncé des règles devant être respectées par le citoyen, 
nous avons  pris le parti d'ajouter l'obligation de gérer lui-même ses charges.


### **Administrateurs: conseil des sages**

Le conseil des sages, 3 admins, devront participer aux tâches de gouvernances et 
d'administrations de l'état pour cela ils devront mettre en dépôt 100 CITIZEN.
Ce dépôt sera la garantie qu'ils feront correctement leur travail d'administrateur. 
Les administrateurs votent pour effectuer les tâches d'administration comme utiliser les fonds des impôts récoltés 
ou encore valider l'enregistrement d'une entreprise qui pourront ensuite acheter du CITIZEN.
En cas de mauvaise gestion ils pourront passer devant un tribunal populaire. Une mauvaise gestion consiste en un crime contre la nation.
Les administrateurs sont élus par les citoyens. L'élection d'un administrateur dure 1 semaine.
Ils sont élus pour une durée de 8 semaines. Les administrateurs sont des citoyens qui peuvent effectuer des tâches d'administration.

```
**WORK IN PROGRESS**


/*  Structures et Variables d'état:

struct Citizen{
     bool isAdmin; 
     uint nombreToken;//valeur du compte en banque du citoyen
     uint age;
     bool isIll; 
     bool isWorking;
     uint256 idEnt; //numéro de l'entreprise à laquelle il appartient   
     bool isBanned; //block.timestamp de  sanction + 520 semaines 
     bool canVote;
     bool isAlive;
 }
 
 struct Entreprise {
     uint256 id;
     unit256 nombreEmployes ;
     unit256 salary_amount;
     bool isValidated;//validation des sages
     
 }
 
 ```
 
 TO DO :
 
 - Mettre en place : condition de 100 CTZ pour être un sage.
 - Mettre en place le tribunal populaire
 - Conditions de durée de la période éléctorale et de la durée du mandat de sage.
 - Réfléchir à la condition d'accession au rang de sage. Passer de Citoyen à Sage. A définir.
 - Créer un vote interne sur la gestion des fonds entre sages.
 - Focus modifier

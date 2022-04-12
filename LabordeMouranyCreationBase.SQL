/*
 ----------------------------------------------------------------------------
             Génération d'une base de données pour
                        SQL Server 2005
                       (12/1/2022 11:01:16)
 ----------------------------------------------------------------------------
     Nom de la base : S1D_LabordeMouranyCreationBase
     Projet : Espace de travail
     Auteur : CRIIUT
     Date de dernière modification : 12/1/2022 10:58:01
 ----------------------------------------------------------------------------
*/

drop database S1D_LabordeMourany
go

/* -----------------------------------------------------------------------------
      OUVERTURE DE LA BASE S1D_LabordeMouranyCreationBase
----------------------------------------------------------------------------- */

/* Cette portion permet de créer la base de donnée */
create database S1D_LabordeMourany
go

use S1D_LabordeMourany
go



/* -----------------------------------------------------------------------------
      TABLE : RANG
----------------------------------------------------------------------------- */

/* Cette portion permet de créer la table Rang et ses attributs */
create table RANG
  (
     ID_RANG int identity (1, 1)   ,
     CATEGORIE char(32)  not null  ,
     CLASSEMENT int  not null  
     ,
     constraint PK_RANG primary key (ID_RANG)
  ) 
go


/* -----------------------------------------------------------------------------
      TABLE : REGION
----------------------------------------------------------------------------- */

/* Cette portion permet de créer la table Region et son attribut */
create table REGION
  (
     ID_REGION int identity (1, 1)   ,
     NOM_REGION char(32)  not null  
     ,
     constraint PK_REGION primary key (ID_REGION)
  ) 
go


/* -----------------------------------------------------------------------------
      TABLE : APPELLATION_VITICOLE
----------------------------------------------------------------------------- */

/* Cette portion permet de créer la table Appellation Viticole et ses attributs */
create table APPELLATION_VITICOLE
  (
     ID_APPELLATION int identity (1, 1)   ,
     ID_REGION int  not null  ,
     LIBELLE_APPELLATION char(32)  not null  
     ,
     constraint PK_APPELLATION_VITICOLE primary key (ID_APPELLATION)
  ) 
go


/* -----------------------------------------------------------------------------
      TABLE : VILLE
----------------------------------------------------------------------------- */

/* Cette portion permet de créer la table Ville et ses attributs */
create table VILLE
  (
     ID_VILLE int identity (1, 1)   ,
     NOM_VILLE char(32)  not null  ,
     CODE_POSTAL int  not null  
     ,
     constraint PK_VILLE primary key (ID_VILLE)
  ) 
go


/* -----------------------------------------------------------------------------
      TABLE : CHATEAU
----------------------------------------------------------------------------- */

/* Cette portion permet de créer la table Chateau et ses attributs */
create table CHATEAU
  (
     ID_CHATEAU int identity (1, 1)   ,
     ID_VILLE int  not null  ,
     ID_APPELLATION int  not null  ,
     ADRESSE_CHATEAU varchar(128)  not null  ,
     NOM_CHATEAU char(32)  not null  ,
     COORD_BANCAIRES char(32)  not null  ,
     NUM_TEL int  not null  
     ,
     constraint PK_CHATEAU primary key (ID_CHATEAU)
  ) 
go


/* -----------------------------------------------------------------------------
      TABLE : VIN
----------------------------------------------------------------------------- */

/* Cette portion permet de créer la table Vin et son attribut */
create table VIN
  (
     ID_VIN int identity (1, 1)   ,
     ID_RANG int  not null  ,
     ID_STOCK int  null  ,
     ID_CHATEAU int  not null  ,
     NOM_VIN char(32)  not null  ,
     PRIX_VIN int  not null  ,
     MILLESIME int  not null  
     ,
     constraint PK_VIN primary key (ID_VIN)
  ) 
go


/* -----------------------------------------------------------------------------
      TABLE : STOCK
----------------------------------------------------------------------------- */

/* Cette portion permet de créer la table Stock et son attribut */
create table STOCK
  (
     ID_STOCK int identity (1, 1)   ,
     QTE_STOCK int  not null  
     ,
     constraint PK_STOCK primary key (ID_STOCK)
  ) 
go


/* -----------------------------------------------------------------------------
      TABLE : COMMANDES
----------------------------------------------------------------------------- */

/* Cette portion permet de créer la table Commandes (ou Achats) et ses attributs */
create table COMMANDES
  (
     ID_COMMANDE int identity (1, 1)   ,
     DATE_COMMANDE datetime  not null  ,
     QTE_VIN_ACHETEE int  not null  ,
     PRIX_TOTAL int  not null  
     ,
     constraint PK_COMMANDES primary key (ID_COMMANDE)
  ) 
go


/* -----------------------------------------------------------------------------
      TABLE : ACHETER
----------------------------------------------------------------------------- */

/* Cette portion permet de créer la relation Acheter */
create table ACHETER
  (
     ID_COMMANDE int  not null  ,
     ID_VIN int  not null  
     ,
     constraint PK_ACHETER primary key (ID_COMMANDE, ID_VIN)
  ) 
go


/* -----------------------------------------------------------------------------
      REFERENCES SUR LES TABLES
----------------------------------------------------------------------------- */

/* Cette portion permet de gérer les références dans les tables */

/* Cela permet de lier une région à une appellation */
alter table APPELLATION_VITICOLE 
     add constraint FK_APPELLATION_VITICOLE_REGION foreign key (ID_REGION) 
               references REGION (ID_REGION)
go



/* Cela permet de lier un château à une ville (pour l'adresse) */
alter table CHATEAU 
     add constraint FK_CHATEAU_VILLE foreign key (ID_VILLE) 
               references VILLE (ID_VILLE)
go



/* Cela permet de donner une appellation aux châteaux */
alter table CHATEAU 
     add constraint FK_CHATEAU_APPELLATION_VITICOLE foreign key (ID_APPELLATION) 
               references APPELLATION_VITICOLE (ID_APPELLATION)
go



/* Cela permet de donner un rang parmi le classement de 1855 aux vins */
alter table VIN 
     add constraint FK_VIN_RANG foreign key (ID_RANG) 
               references RANG (ID_RANG)
go



/* Cela permet de connaître le stock de chaque vin */
alter table VIN 
     add constraint FK_VIN_STOCK foreign key (ID_STOCK) 
               references STOCK (ID_STOCK)
go



/* Cela permet de connaître quels vins sont produits dans quels châteaux */
alter table VIN 
     add constraint FK_VIN_CHATEAU foreign key (ID_CHATEAU) 
               references CHATEAU (ID_CHATEAU)
go



/* Cela permet de lier les achats aux commandes */
alter table ACHETER 
     add constraint FK_ACHETER_COMMANDES foreign key (ID_COMMANDE) 
               references COMMANDES (ID_COMMANDE)
go



/* Cela permet de dire quels vins sont achetés */
alter table ACHETER 
     add constraint FK_ACHETER_VIN foreign key (ID_VIN) 
               references VIN (ID_VIN)
go



/*
 -----------------------------------------------------------------------------
               FIN DE GENERATION
 -----------------------------------------------------------------------------
*/


/*
 -----------------------------------------------------------------------------
               DONNER DROITS A ENZO x)
 -----------------------------------------------------------------------------
*/

-- on se positionne sur sa base de données
USE S1D_LabordeMourany
-- on crée l’utilisateur etriolet
CREATE USER [IUT\emourany]
-- on lui donne les droits voulus (opérations autorisées) sur toutes les tables de la base
GRANT view definition, select, update, insert, delete
TO [IUT\emourany]
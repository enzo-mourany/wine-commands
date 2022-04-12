/* -----------------------------------------------------------------------------
      REMPLISSAGE DE LA BASE S1D_LabordeMourany
----------------------------------------------------------------------------- */

-- on se positionne sur sa base de données
USE S1D_LabordeMourany
-- on vide les tables
DELETE RANG
DELETE CHATEAU
DELETE APPELLATION_VITICOLE
DELETE VILLE
DELETE VIN
DELETE STOCK
DELETE REGION
DELETE COMMANDES
DELETE ACHETER


-- on crée des villes avec |  nom_ville - code_postal  |
INSERT INTO VILLE(NOM_VILLE, CODE_POSTAL)
VALUES 
      ('Margaux', 33460), ('Médoc', 33340), ('Pauillac', 33250), ('Cérons', 33640), ('Barsac', 33720), ('Saint-Julien', 33250);


-- on crée des régions avec |  nom_region  |
INSERT INTO REGION(NOM_REGION)
VALUES 
      ('Médoc'), ('Graves'), ('Sauternais');


-- on crée des appellations viticoles avec |  id_region - libellé_appelation  |
INSERT INTO APPELLATION_VITICOLE(ID_REGION, LIBELLE_APPELLATION)
VALUES 
      -- 1ere appellation
      ((SELECT ID_REGION FROM REGION WHERE NOM_REGION = 'Médoc'), 'Margaux'), 
      -- 2eme appellation
      ((SELECT ID_REGION FROM REGION WHERE NOM_REGION = 'Médoc'), 'Pauillac'), 
      -- 3eme appellation
      ((SELECT ID_REGION FROM REGION WHERE NOM_REGION = 'Médoc'), 'Saint-Julien'),
      -- 4eme appellation
      ((SELECT ID_REGION FROM REGION WHERE NOM_REGION = 'Graves'), 'Cérons'), 
      -- 5eme appellation
      ((SELECT ID_REGION FROM REGION WHERE NOM_REGION = 'Sauternais'), 'Barsac'),
	  -- 6eme appellation
	  ((SELECT ID_REGION FROM REGION WHERE NOM_REGION = 'Médoc'), 'Médoc');


-- on crée des chateaux avec |  id_ville - id_appellation - adresse_chateau - nom_chateau - coord_bancaires - num_tel  |
INSERT INTO CHATEAU(ID_VILLE, ID_APPELLATION, ADRESSE_CHATEAU, NOM_CHATEAU, COORD_BANCAIRES, NUM_TEL)
VALUES 
      -- 1er chateau
      ((SELECT ID_VILLE FROM VILLE WHERE NOM_VILLE = 'Margaux'),
       (SELECT ID_APPELLATION FROM APPELLATION_VITICOLE WHERE LIBELLE_APPELLATION = 'Margaux'),
       'Margaux-Cantenac', 'Château Margaux', 'FR7810096000308158315481I77', '0557888383'),
       -- 2eme chateau
      ((SELECT ID_VILLE FROM VILLE WHERE NOM_VILLE = 'Cérons'),
       (SELECT ID_APPELLATION FROM APPELLATION_VITICOLE WHERE LIBELLE_APPELLATION = 'Cérons'),
       '49 Chem. des Graves', 'Château Lamothe-Bergeron', 'FR0612739000303562931539N45', '0556589477'),
       -- 3eme chateau
      ((SELECT ID_VILLE FROM VILLE WHERE NOM_VILLE = 'Barsac'),
       (SELECT ID_APPELLATION FROM APPELLATION_VITICOLE WHERE LIBELLE_APPELLATION = 'Barsac'),
       '41 La Grange', 'Château Lagrange', 'FR6230003000501524981455Q51', '0556733838'),
       -- 4eme chateau
      ((SELECT ID_VILLE FROM VILLE WHERE NOM_VILLE = 'Pauillac'),
       (SELECT ID_APPELLATION FROM APPELLATION_VITICOLE WHERE LIBELLE_APPELLATION = 'Pauillac'),
       '27 Rte des Châteaux', 'Château Latour', 'FR3210096000407516234759A09', '0556731980'),
       -- 5eme chateau
      ((SELECT ID_VILLE FROM VILLE WHERE NOM_VILLE = 'Saint-Julien'),
       (SELECT ID_APPELLATION FROM APPELLATION_VITICOLE WHERE LIBELLE_APPELLATION = 'Saint-Julien'),
       'Saint-Julien-Beychevelle', 'Château Gloria', 'FR0710096000703273617379P41', '0556590818');


-- on crée des classifications avec |  categorie - classement  |
INSERT INTO RANG(CATEGORIE,CLASSEMENT)
VALUES
      -- 1er rang
      ('Premier Cru Classé',1),
      -- 2eme rang
      ('Premier Cru Classé',2),
      -- 3eme rang
      ('Deuxième Cru Classé',1),
      -- 4eme rang
      ('Troisième Cru Classé',1),
      -- 5eme rang
      ('Deuxième Cru Classé',2);


-- on crée des stocks avec |  qte_stock  |
INSERT INTO STOCK(QTE_STOCK)
VALUES
      (5), (12), (30), (8), (2);


-- on crée des vins avec |  id_rang - id_stock - nom_vin - prix_vin - millesime  |
INSERT INTO VIN(ID_RANG, ID_STOCK, ID_CHATEAU, NOM_VIN, PRIX_VIN, MILLESIME)
VALUES 
      -- 1er vin
      ((SELECT ID_RANG FROM RANG WHERE CATEGORIE='Premier Cru Classé' AND CLASSEMENT=1),
       (SELECT ID_STOCK FROM STOCK WHERE QTE_STOCK=5),
       (SELECT ID_CHATEAU FROM CHATEAU WHERE NOM_CHATEAU = 'Château Margaux'),
       'Pavillon rouge', 50, 2020), 
       -- 2eme vin
      ((SELECT ID_RANG FROM RANG WHERE CATEGORIE='Premier Cru Classé' AND CLASSEMENT=2),
       (SELECT ID_STOCK FROM STOCK WHERE QTE_STOCK=12),
       (SELECT ID_CHATEAU FROM CHATEAU WHERE NOM_CHATEAU = 'Château Lamothe-Bergeron'),
       'Cru Bourgeois Supérieur', 17, 2018),
       -- 3eme vin
      ((SELECT ID_RANG FROM RANG WHERE CATEGORIE = 'Deuxième Cru Classé' AND CLASSEMENT = 1),
       (SELECT ID_STOCK FROM STOCK WHERE QTE_STOCK = 30),
       (SELECT ID_CHATEAU FROM CHATEAU WHERE NOM_CHATEAU = 'Château Lagrange'),
       'Chateau Lagrange', 23, 2015),
       -- 4eme vin
      ((SELECT ID_RANG FROM RANG WHERE CATEGORIE = 'Deuxième Cru Classé' AND CLASSEMENT = 2),
       (SELECT ID_STOCK FROM STOCK WHERE QTE_STOCK = 8),
       (SELECT ID_CHATEAU FROM CHATEAU WHERE NOM_CHATEAU = 'Château Latour'),
       'Château Latour', 19, 2009),
       -- 5eme vin
      ((SELECT ID_RANG FROM RANG WHERE CATEGORIE = 'Troisième Cru Classé' AND CLASSEMENT = 1),
       (SELECT ID_STOCK FROM STOCK WHERE QTE_STOCK = 2),
       (SELECT ID_CHATEAU FROM CHATEAU WHERE NOM_CHATEAU = 'Château Gloria'),
       'Château Gloria', 15 , 2017);

-- on crée des commandes avec |  date_commande - qte_vin_achetee - prix_total  |
INSERT INTO COMMANDES(DATE_COMMANDE, QTE_VIN_ACHETEE, PRIX_TOTAL)
VALUES
      --1ere commande
      (2022-01-12T11:38:00, 5, 250),
      --2eme commande
      (2022-01-12T11:50:00, 12, 204),
      --3eme commande
      (2022-01-12T11:56:00, 30, 690),
      --4eme commande
      (2022-01-14T10:40:00, 8, 152),
      --5eme commande
      (2022-01-14T10:42:00, 2, 30);
/* -----------------------------------------------------------------------------
      COMMANDES SQL FONCTIONNALITÉS APPLICATION
----------------------------------------------------------------------------- */

/**
* Listes non triées ou filtrées
*/


-- Liste de vins
SELECT nom_vin, prix_vin, millesime, nom_chateau
FROM VIN
    INNER JOIN Chateau ON Vin.ID_CHATEAU = CHATEAU.ID_CHATEAU

-- Liste de châteaux
SELECT nom_chateau, libellé_appelation, adresse_chateau, coord_bancaires, num_tel
FROM Chateau
    INNER JOIN Appellation ON Vin.id_appellation = Appellation.id_appellation

-- Liste des achats
SELECT id_commande, date_commande, qte_vin_achetee, prix_total
FROM COMMANDES


/**
* Liste triées
*/


-- Liste de vins triée par prix
SELECT VIN.ID_VIN, VIN.NOM_VIN, VIN.PRIX_VIN, VIN.MILLESIME
FROM VIN
ORDER BY VIN.PRIX_VIN ASC -- (ou DESC)


-- Liste de vins triée par Nom
SELECT VIN.ID_VIN, VIN.NOM_VIN, VIN.PRIX_VIN, VIN.MILLESIME
FROM VIN
ORDER BY VIN.NOM_VIN ASC -- (ou DESC)


-- Liste de vins triée par Stock
SELECT VIN.ID_VIN, VIN.NOM_VIN, VIN.PRIX_VIN, VIN.MILLESIME, STOCK.QTE_STOCK
FROM VIN
    INNER JOIN STOCK ON VIN.ID_STOCK = STOCK.ID_STOCK
ORDER BY STOCK.QTE_STOCK ASC -- (ou DESC)


-- Liste de châteaux triée par Nom
SELECT nom_chateau, libellé_appelation, adresse_chateau, coord_bancaires, num_tel
FROM Chateau
    INNER JOIN Appellation ON Vin.id_appellation = Appellation.id_appellation
ORDER BY nom_chateau ASC -- (ou DESC)


-- Liste d'achats sur une période donnée
SELECT id_commande, date_commande, qte_vin_achetee, prix_total
FROM COMMANDES
WHERE date_commande >= /* Date de début */ AND date_commande <= /* Date de fin */


-- Liste d'achats auprès d'un château
SELECT ACHETER.ID_COMMANDE, ACHETER.NOM_VIN, CHATEAU.NOM_CHATEAU
FROM ACHETER
    INNER JOIN COMMANDE ON ACHETER.ID_COMMANDE = COMMANDE.ID_COMMANDE
    INNER JOIN VIN ON ACHETER.ID_VIN = VIN.ID_VIN
    INNER JOIN CHATEAU ON VIN.ID_CHATEAU = CHATEAU.ID_CHATEAU
GROUP BY CHATEAU.NOM_CHATEAU


/**
* AJouter ou supprimer des éléments de la base de donnée
*/


-- Ajouter un vin
INSERT INTO VIN(ID_RANG, ID_STOCK, ID_CHATEAU, NOM_VIN, PRIX_VIN, MILLESIME)
VALUES 
      ((SELECT ID_RANG FROM RANG WHERE CATEGORIE= /* Nom de la catégorie */ AND CLASSEMENT= /* Classement dans la catégorie */),
       (SELECT ID_STOCK FROM STOCK WHERE QTE_STOCK= /* Quantité en stock */),
       (SELECT ID_CHATEAU FROM CHATEAU WHERE NOM_CHATEAU = /* Nom du château */),
       /* Nom du vin */, /* Prix du vin */, /* Millésime */), 

-- Ajouter un château
INSERT INTO CHATEAU(ID_VILLE, ID_APPELLATION, ADRESSE_CHATEAU, NOM_CHATEAU, COORD_BANCAIRES, NUM_TEL)
VALUES 
      -- 1er chateau
      ((SELECT ID_VILLE FROM VILLE WHERE NOM_VILLE = /* Nom de la ville */),
       (SELECT ID_APPELLATION FROM APPELLATION_VITICOLE WHERE LIBELLE_APPELLATION = /* Libellé de l'appellation */),
       /* Adresse du château */, /* Nom du château */, /* Coordonnées bancaires du château */, /* Numéro de téléphone du château */),

-- Ajouter un achat
INSERT INTO COMMANDES(DATE_COMMANDE, QTE_VIN_ACHETEE, PRIX_TOTAL)
VALUES
      (/* Date de la commande */, /* Quantité de vin achetée */, /* Prix total */),
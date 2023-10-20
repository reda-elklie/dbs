-- Exercice 1
-- 1. Afficher tous les produits
CREATE PROCEDURE AfficherTousProduits
AS
BEGIN
    SELECT * FROM Produit;
END;

-- 2. Afficher les libellés des produits dont le stock est inférieur à 10
CREATE PROCEDURE AfficherProduitsFaibleStock
AS
BEGIN
    SELECT libelle FROM Produit WHERE stock < 10;
END;

-- 3. Afficher les informations d'un produit en fonction de son numéro
CREATE PROCEDURE AfficherInfosProduit
    NumProduit INT
AS
BEGIN
    SELECT libelle, PU, stock FROM Produit WHERE NumProduit = NumProduit;
END;

-- 4. Supprimer un produit en fonction de son numéro
CREATE PROCEDURE SupprimerProduit
    NumProduit INT
AS
BEGIN
    DELETE FROM Produit WHERE NumProduit = NumProduit;
END;

-- Exercice 2
-- Mise à jour du stock après une opération de vente de produits
CREATE PROCEDURE MiseAJourStock
    NumProduit INT,
    QuantiteVendue INT
AS
BEGIN
    DECLARE StockActuel INT;
    SELECT StockActuel = stock FROM Produit WHERE NumProduit = NumProduit;

    IF (QuantiteVendue > StockActuel)
        PRINT 'Opération impossible';
    ELSE
    BEGIN
        IF (StockActuel - QuantiteVendue < 10)
            PRINT 'Besoin de réapprovisionnement';
        ELSE
        BEGIN
            UPDATE Produit SET stock = StockActuel - QuantiteVendue WHERE NumProduit = NumProduit;
            SELECT 'Opération effectuée avec succès, la nouvelle valeur du stock est ' + CAST(StockActuel - QuantiteVendue AS NVARCHAR(50));
        END
    END
END;

-- Exercice 3
-- Retourner le prix moyen des produits
CREATE PROCEDURE PrixMoyenProduits
    PrixMoyen DECIMAL(10, 2) OUTPUT
AS
BEGIN
    SELECT PrixMoyen = AVG(PU) FROM Produit;
END;

-- Exercice 4
-- Retourner le factoriel d'un nombre entier
CREATE PROCEDURE CalculerFactoriel
    nombre INT,
    factoriel BIGINT OUTPUT
AS
BEGIN
    DECLARE resultat BIGINT = 1;
    DECLARE i INT = 1;
    
    WHILE i <= nombre
    BEGIN
        SET resultat = resultat * i;
        SET i = i + 1;
    END

    SELECT factoriel = resultat;
END;

-- Exercice 5
-- Procédure pour effectuer des opérations arithmétiques simples
CREATE PROCEDURE OperationArithmetique
    num1 INT,
    num2 INT,
    operateur CHAR(1),
    resultat INT OUTPUT
AS
BEGIN
    IF operateur = '+'
        SET resultat = num1 + num2;
    ELSE IF operateur = '-'
        SET resultat = num1 - num2;
    ELSE IF operateur = '*'
        SET resultat = num1 * num2;
    ELSE IF operateur = '/'
    BEGIN
        IF num2 = 0
            SET resultat = NULL;
        ELSE
            SET resultat = num1 / num2;
    END
    ELSE IF operateur = '%'
    BEGIN
        IF num2 = 0
            SET resultat = NULL;
        ELSE
            SET resultat = num1 % num2;
    END
END;

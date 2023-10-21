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
DROP PROCEDURE IF EXISTS facto;
DELIMITER $$ 
CREATE PROCEDURE facto(IN nombre INT, OUT f BIGINT)
BEGIN
    DECLARE result BIGINT DEFAULT 1;
    DECLARE i INT DEFAULT 1;

    WHILE i <= nombre DO
        SET result = result * i;
        SET i = i + 1;
    END WHILE;

    SET f = result;
END $$
DELIMITER ;

CALL facto(1, @f);
SELECT @f;

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


/* souloution 2 */


ROP PROCEDURE IF EXISTS ope;
DELIMITER $$ 
CREATE PROCEDURE ope(IN nb1 INT, in operation varchar(1),in nb2 int , OUT p BIGINT)
BEGIN
    DECLARE result varchar(50) DEFAULT null;
if(operation='+') then 
	set result = nb1+nb2;
elseif(operation='-') then 
	set result = nb1-nb2;
elseif(operation='*') then 
	set result = nb1*nb2;
elseif(operation='/') then
	if (nb2>0) then 
		set result = nb1/nb2;
	else set result = 'erreur div / 0';
	end if;
end if;
  set p = result;
END $$
DELIMITER ;

CALL ope(10,"/",2, @p);
SELECT @p;

/*Exercice 6 */
USE YourDatabaseName; -- Replace YourDatabaseName with your actual database name

-- PS1
CREATE PROCEDURE PS1_ListeIngredients
AS
BEGIN
    SELECT I.NumIng, I.NomIng, F.RSFou AS RaisonSocialeFournisseur
    FROM Ingredients I
    JOIN Fournisseur F ON I.NumFou = F.NumFou;
END;

-- PS2
CREATE PROCEDURE PS2_InfoRecette
AS
BEGIN
    SELECT CR.NumRec, COUNT(CR.NumIng) AS NombreIngredients, SUM(I.PUIng * CR.QteUtilisee) AS MontantRecette
    FROM Composition_Recette CR
    JOIN Ingredients I ON CR.NumIng = I.NumIng
    GROUP BY CR.NumRec;
END;

-- PS3
CREATE PROCEDURE PS3_RecettesPlus10Ingredients
AS
BEGIN
    SELECT R.NumRec, R.NomRec
    FROM Recettes R
    JOIN Composition_Recette CR ON R.NumRec = CR.NumRec
    GROUP BY R.NumRec, R.NomRec
    HAVING COUNT(CR.NumIng) > 10;
END;

-- PS4
CREATE PROCEDURE PS4_NomRecette
    @NumRec INT
AS
BEGIN
    SELECT NomRec
    FROM Recettes
    WHERE NumRec = @NumRec;
END;

-- PS5
CREATE PROCEDURE PS5_MeilleurIngredient
    @NumRec INT
AS
BEGIN
    DECLARE @Ingredient NVARCHAR(100);
    SELECT TOP 1 @Ingredient = I.NomIng
    FROM Composition_Recette CR
    JOIN Ingredients I ON CR.NumIng = I.NumIng
    WHERE CR.NumRec = @NumRec
    ORDER BY I.PUIng;
    IF (@Ingredient IS NULL)
        SELECT 'Aucun ingrédient associé' AS Result;
    ELSE
        SELECT @Ingredient AS Result;
END;

-- PS6
CREATE PROCEDURE PS6_ListeIngredientsPourRecette
    @NumRec INT
AS
BEGIN
    SELECT I.NomIng, CR.QteUtilisee, I.PUIng
    FROM Composition_Recette CR
    JOIN Ingredients I ON CR.NumIng = I.NumIng
    WHERE CR.NumRec = @NumRec;
END;

-- PS7
CREATE PROCEDURE PS7_RecetteDetails
    @NumRec INT
AS
BEGIN
    EXEC PS4_NomRecette @NumRec;
    EXEC PS6_ListeIngredientsPourRecette @NumRec;
    EXEC PS5_MeilleurIngredient @NumRec;
END;

-- PS8
CREATE PROCEDURE PS8_DetailsFournisseur
    @NumFou INT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Fournisseur WHERE NumFou = @NumFou)
        SELECT 'Aucun fournisseur ne porte ce numéro' AS Result;
    ELSE
    BEGIN
        IF NOT EXISTS (SELECT * FROM Ingredients WHERE NumFou = @NumFou)
        BEGIN
            SELECT 'Ce fournisseur n''a aucun ingrédient associé. Il sera supprimé' AS Result;
            DELETE FROM Fournisseur WHERE NumFou = @NumFou;
        END
        ELSE
            SELECT NumIng, NomIng FROM Ingredients WHERE NumFou = @NumFou;
    END
END;

-- PS9
CREATE PROCEDURE PS9_DetailsRecette
    @NumRec INT
AS
BEGIN
    DECLARE @PrixRevient INT;
    SELECT @PrixRevient = SUM(CR.QteUtilisee * I.PUIng)
    FROM Composition_Recette CR
    JOIN Ingredients I ON CR.NumIng = I.NumIng
    WHERE CR.NumRec = @NumRec;

    SELECT 'Recette : ' + R.NomRec + ', temps de préparation : ' + CONVERT(NVARCHAR(10), R.TempsPreparation) AS Message,
        I.NomIng, CR.QteUtilisee AS Quantite, R.MethodePreparation, 
        CASE WHEN @PrixRevient < 50 THEN 'Prix intéressant' ELSE '' END AS Commentaire
    FROM Recettes R
    JOIN Composition_Recette CR ON R.NumRec = CR.NumRec
    JOIN Ingredients I ON CR.NumIng = I.NumIng
    WHERE R.NumRec = @NumRec;
END;


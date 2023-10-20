



/* -- 11 */
select nomecr,prenomecr from ecrivain 
join ecrire on ecrivain.numecr=ecrire.numecr
join ouvrage on ecrire.numouvr=ouvrage.numouvr
join tarifer on ouvrage.numouvr=tarifer.numouvr
where tarifer.prixvente >=30 and tarifer.datedeb<= '2002-10-01';


/* -- 12 */
select nomecr,prenomecr,LIBRUB from ecrivain 
join ecrire on ecrire.numecr = ecrire.numecr
join ouvrage on ecrire.numouvr=ouvrage.numouvr 
join classification on ouvrage.numrub=classification.numrub
where LIBRUB = 'finances publiques';

/* -- 13 */
/* -- 14*/
select ouvrage.numouvr ,ouvrage.nomouvr , tarifer.prixvente , round(tarifer.prixvente/0.155,2) as PRIX_HT
from ouvrage
join tarifer on tarifer.numouvr=ouvrage.numouvr;

/* -- 15*/
select count(*) from ecrivain
where languecr='anglais' or languecr='allemand';

/* -- 16 */
select sum(stocker.qtestock) from stocker
join ouvrage on stocker.numouvr=ouvrage.numouvr
join depot on stocker.numdep = depot.numdep
where depot.villedep='Grenoblois' and ouvrage.numouvr='gestion de portefeuilles';


/* -- 17 */
select ouvrage.nomouvr as 'the expensive one' from ouvrage
join tarifer on ouvrage.numouvr=tarifer.numouvr
where tarifer.prixvente=(select max(tarifer.prixvente) from tarifer);

/* -- 18 */
select ecrivain.nomecr , ecrivain.prenomecr ,count(numecr) as the_nb_ecrivain from ecrivain
group by ecrivain.nomecr
order by the_nb_ecrivain desc;
/* -- 19 */
SELECT O.LIBRUB, SUM(S.QTESTOCK) AS NombreExemplairesEnStock
FROM OUVRAGE O
JOIN STOCKER S ON O.NUMOUVR = S.NUMOUVR
JOIN DEPOT D ON S.NUMDEP = D.NUMDEP
WHERE D.VILLEDEP = 'Grenoble'
GROUP BY O.LIBRUB;

/*-- 22*/
SELECT E.NOMECR, E.PRENOMECR
FROM ECRIVAIN E
LEFT JOIN ECRIRE EC ON E.NUMECR = EC.NUMECR
WHERE EC.NUMECR IS NULL;
/* -- 23*/
UPDATE STOCKER
SET QTESTOCK = 0
WHERE NUMOUVR = 6 AND NUMDEP = 'Lyon2';

/*--24*/
DELETE FROM OUVRAGE
WHERE NOMED = 'Vuibert';

/*25*/
CREATE TABLE EditeursParis AS
SELECT NOMED, TELED
FROM EDITEUR
WHERE VILLEED = 'Paris';
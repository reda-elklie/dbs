create database functions collate 'utf8mb4_general_ci';
use functions;
/* Exercice 1 */
drop function if exists dateConverter;
delimiter $$
create function dateConverter(input_date varchar(40))
returns varchar(50)
deterministic
begin
declare dateFormatted varchar(50);
set dateFormatted = date_format(input_date ,'%d %M %Y') ;
return dateFormatted;
end $$
delimiter ;
SELECT dateConverter('2005-02-20') AS formatted_date;


/*Exercice 2 */
drop function dataDiff;
delimiter $$
create function dataDiff(d1 date , d2 date , choix varchar(50))
returns varchar(50)
deterministic
begin
declare result varchar(50);
if(choix='jour') then 
	set result=timestampdiff(day,d1,d2);
elseif(choix='mois') then 
	set result=timestampdiff(month,d1,d2);
elseif(choix='annee') then 
	set result=timestampdiff(year,d1,d2);
elseif(choix='heur') then 
	set result=timestampdiff(hour,d1,d2);
else 
	set result = 'Erreur';
end if;
return concat('la differens entre les deux est : ',ABS(result));
end $$
delimiter ;
select dataDiff('2005-02-20','2023-10-13','heur');









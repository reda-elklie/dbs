create database instruction collate 'utf8mb4_general_ci';
use instruction;

drop function if exists hello;
delimiter $$
create function hello()
	returns varchar(50)
    deterministic
    begin
    return "hello";
    end $$

delimiter ;

select hello();

/* Addition function */
drop function if exists addition;
delimiter $$
create function addition(a int , b int)
returns float
deterministic
begin
declare c int default 0;
set c = a + b;
return a + b;

end $$
delimiter ;

select addition(5,2);

drop function if exists produit;
delimiter $$
create function produit(a int , b int)
returns float 
deterministic
begin
declare c int ;
select(a*b) into c; /* affectarion (a*b)= c */
return c;
end $$
delimiter ;
select produit(3,7);

/*Condition */
/* -- syntax
if conditiont then 
	code 
else if condition then 
	code 
end if;

 */

drop function if exists comparaison;
delimiter $$
create function comparaison(a int, b int)
returns varchar(50)
deterministic
begin
declare res varchar(50);
if(a>b) then 
	set res='a superieur a b';
else if (a<b) then 
	set res = 'a inferieur a b';
else 
	set res = 'a egale a b';
end if;
end if;
return res;
end $$
delimiter ;

select comparaison (30,30);

/* Exercice 

Ax+B=0
x= -B/A

si A = 0 et B = 0
  X = R
Si A = 0 et B != 0 
 Ensemble vide
 
 Si a!=0
  X = -B/A

*/
drop function if exists eqp;
delimiter $$
create function eqp(a int , b int)
returns varchar(50)
deterministic 
begin
declare x varchar(50);
if (a=0) then
	if (b=0) then 
		set x = 'Ensemebl R';
	end if;
	if(b!=0) then 
		set x = 'Ensemble vide ';
	end if;
end if;
if(a!=0) then 
set x = round(-b/a,2);
end if;
return x;
end $$
delimiter ;

select eqp(0,0);
select eqp(0,01);
select eqp(2,4);


/* Exercice Equation deuxieme degree 

  Rappel mathématique equation deuxième degrès
Ax²+Bx+C = 0

A=0 et B=0 et C=0
   X=R
A=0 B=0 et C!=0
   Ensemble vide
A=0  B!=0
		X = -C/B
A!=0
 Delta = (B*B) - (4*A*C)

si delta = 0
   x1 = x2 = -B/2A
si delta > 0
   x1 = (-b+ racine(delta)) / (2*A)
   x2 = (-b-racine(delta))/(2*A)
si delta <0
  impossible dans R
*/

drop function if exists equation_2degree;
delimiter $$
create function equation_2degree(a int , b int , c int)
returns varchar(50)
deterministic
begin 
declare x varchar(50);
declare delta float; 

if (a=0) then
	if(b=0) then 
		if (c=0) then 
			set x = 'Ensemble R';
		end if;
		if(c!=0) then 
			set x ='Ensemble Vide ';
		end if;
	end if;
    if (b!=0) then 
		set x = round(-c/b,2);
	end if;
end if;

if (a!=0) then 
	set Delta = (B*B) - (4*A*C);
	if (delta=0) then 
		set x = concat('le resulta est ', round(-b/(2*a)),2);
	end if;
	if (delta > 0) then 
		set x = concat ('x1=',round((-b+ sqrt(delta)),2) / (2*A),' ', 'x2=',round((-b-sqrt(delta))/(2*A)),2);
	end if;
	if (delta <0) then 
		set x = 'Imposible dans le R';
	end if;
end if;
return x;
end $$
delimiter ;
select equation_2degree(0,0,0);   
select equation_2degree(0,0,1);   
select equation_2degree(0,2,2);   
select equation_2degree(1,2,1);
select equation_2degree(2,5,1);
select equation_2degree(8,2,1);

/*Cases (jour de la semaine )*/
drop function if exists jsemain;
delimiter $$
create function jsemain(j int)
returns varchar(50)
deterministic
begin 
declare jour varchar(54);
set jour = case j 
when j=1 then 'dimanche'
when j=2 then 'Lundi'
when j=3 then 'Mardi'
when j=4 then 'Mercredi'
when j=5 then 'Jeudi'
when j=6 then 'Vendredi'
when j=7 then 'Samedi'
else 
	'Erreur'
end;
return jour;
end $$
delimiter ;
select jsemain(6);

/* Le boucles */

/* Exercice 
ecrire une fonction qui permet de faire la somme des n premier entier paires (utiliser une incremetation par 1 et le modulo)
 */
 /* Solution */
 drop function if exists snep; # somme nombre entier  premier
 delimiter $$
 create function snep(n int)
 returns int 
 deterministic
 begin	 
	declare somme int default 0;
	declare i int default 1;
    while n>0 do
		if i % 2 = 0 then 
        set somme = somme + i;
        set n = n -1 ;
        end if;
        set i=i+1;
	end while ;
        return somme;
 end $$
 delimiter ;
 select snep(05);
 
 
 
 
drop database if exists vols_203;

create database vols_203 collate utf8mb4_general_ci;
use vols_203;

create table Pilote(numpilote int auto_increment primary key,
nom varchar(50) ,
titre varchar(50) ,
villepilote varchar(50) ,
daten date,
datedebut date);

alter table pilote add column salaire float;

create table Vol(numvol int auto_increment primary key,
villed varchar(50) ,
villea varchar(50) ,
dated date ,
datea date , 
numpil int not null,
numav int not null);
create table Avion(numav int auto_increment primary key,
typeav  varchar(50) ,
capav int);

alter table vol add constraint fk_vol_pilote foreign key(numpil) references pilote(numpilote);
alter table vol add constraint fk_vol_avion foreign key(numav) references avion(numav);
insert into avion values (1,'boeing',350),
                        (2,'caravel',50),
                        (3,'airbus',500);

insert into pilote values (1,'hassan','M.','tetouan','2000-01-01','2022-01-01'),
                        (2,'saida','Mme.','casablanca','1980-01-01','2005-01-01'),
                        (3,'youssef','M.','tanger','1983-01-01','2002-01-01');
                        
insert into pilote values (4,'hasan','M.','ttouan','2000-01-01','2022-01-01',100.5),
                        (5,'saia','Mme.','caablanca','1980-01-01','2005-01-01',4210),
                        (6,'youef','M.','taner','1983-01-01','2002-01-01',2100);
                    
                    
                    
					
insert into vol values (1,'tetouan','casablanca','2023-09-10','2023-09-10',1,1),
                        (2,'casablanca','tetouan','2023-09-10','2023-09-10',1,1),
                        (3,'tanger','casablanca','2023-09-11','2023-09-11',2,2),
                        (4,'casablanca','tanger','2023-09-11','2023-09-11',2,2),
                        (5,'agadir','casablanca','2023-09-11','2023-09-11',3,3),
                        (6,'casablanca','agadir','2023-09-11','2023-09-11',3,3);
insert into vol values (7,'tetouan','casablanca','2023-09-10','2023-09-12',1,1),
                        (8,'casablanca','tetouan','2023-09-10','2023-09-12',1,1),
                        (9,'tanger','casablanca','2023-09-11','2023-09-13',1,2),
                        (10,'casablanca','tanger','2023-09-11','2023-09-13',1,2),
                        (11,'agadir','casablanca','2023-09-11','2023-09-13',3,3),
                        (12,'casablanca','agadir','2023-09-11','2023-09-13',3,3);
                        
                        
                        
                        
/*qte */
drop function calculate;
 delimiter $$
 create	function calculate(pilote_id INT)
 returns varchar(50)
 reads sql data 
 begin
 declare duree int;
SELECT DATEDIFF(datedebut, daten) INTO duree
    FROM Pilote
    WHERE numpilote = pilote_id;
	return concat(duree, ' mois') ;
 end $$
 delimiter ;
select calculate(1);

/* qte 2 */



drop function if exists e1;
delimiter $$
create function e1(n int)
	returns int
    reads sql data
begin
	declare r int;
    set r = (select count(*) from 
		(select count(numvol) nbvols, numpil 
		from vol
		group by numpil
		having count(numvol)>1) f);
    return r;
end $$
delimiter ;

select e1(1);


select count(*) from 
(select count(numvol) nbVols , numpil 
from vol 
group by numpil 
having count(numvol)>1);


drop function countSalaire;
delimiter $$
create function countSalaire(slr float)
returns float
reads sql data 
begin
declare salire float default null ;
set salire = (select count(*) from pilote  where salaire<slr) ;
return	salire;

end	$$
delimiter ;

select countSalaire(2100);




















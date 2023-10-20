create database avion_ collate utf8mb3_general_ci;
use avion_;
/* -- 01 */
create table avion(
	numAv int not null,
    typeAv varchar(20),
    capAv int,
    VilleAv varchar(50)
);
create table pilote(
	numPil int ,
    nomPil varchar(50),
    titre varchar(50),
    villePil varchar(50)
);

create table vol(
	numVol int,
    villeD varchar(50),
    villeA varchar(50),
    DateD date ,
    dateA date,
    numPil int,
    numAv int
);

/* -- 02 */
# primary keys --
alter table avion 
add primary key (numAv);

alter table pilote
add primary key (numPil);

alter table vol
add primary key(numVol); 

# foreign keys --

alter table vol 
add constraint fk_avion
foreign key(numAv)
references Avion(numAv);

alter table vol 
add constraint fk_pil
foreign key (numPil)
references Pilote(numPil);

/* -- 03 */
 # --- 	
alter table pilote
add constraint c_titre check (titre in ('m','melle','mme'));

# ---
alter table pilote
add constraint not_null_nom check (nomPil is not null);

alter table pilote 
add constraint cp_ville check (villePil is not null);

alter table avion 
add constraint ca_ville check(villeAv is not null);
 
 # ---
 
alter table avion 
add constraint c_capAv check(capAv between 50 and 100);

/* -- 04 */

alter table pilote
add DateN date ;

/* -- 05 */ 

alter table vol 
add constraint check_dateA_D check(dateD<= dateA);

/* -- 06 */

alter table avion 
drop column villeAv;

/* -- 07 */

alter table vol 
drop foreign key fk_pil;

drop table pilote;

/* -- 08 */

insert into avion(numAv,typeAv,capAv)
values
	(100,'type A',60),
    (101,'type B', 65 ),
    (102,'type C', 70 );

INSERT INTO VOL (NumVol, VilleD, VilleA, DateD, DateA, NumPil, NumAv)
VALUES
    (1, 'Paris', 'New York', '2023-10-01', '2023-10-02', 1, 1),
    (2, 'London', 'Los Angeles', '2023-10-03', '2023-10-04', 2, 2),
    (3, 'Berlin', 'Tokyo', '2023-10-05', '2023-10-06', 3, 3);

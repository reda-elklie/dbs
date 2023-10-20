/* -- 01 */
create database ecole_203 collate utf8mb3_general_ci;
use ecole_203;
/* -- 02 */
create table etudiant(
	NEtudiant int primary key not null,
    nom varchar(20) ,
    prenom varchar(20)  
);



create table matiere(
	codeMat int primary key not null,
    LibelleMat varchar(50) ,
    CoeffMat int not null
);





create table evaluer(
	NEtudiant int,
    CodeMat int,
	DateExamen datetime,
    Note float not null,
    primary key(NEtudiant,CodeMat,DateExamen)	
);


/* -- 03 */
alter table evaluer
add constraint fk_etudiant 
foreign key (NEtudiant)
references etudiant(NEtudiant);

alter table evaluer
add constraint fk_matiere
foreign key (codeMat)
references matiere(codeMat);

/* -- 04 */

alter table etudiant
add groupe int not null ;
 
/* -- 05 */ 

alter table matiere 
add constraint uc_libelleMat unique (LibelleMat);

/* -- 06 */

alter table etudiant 
add Age int;

alter table etudiant 
add constraint check_age check (age > 16);

/* -- 07 */

alter table evaluer 
add constraint c_note check (note>=0 and note<=20);

/* -- 08 */
 INSERT INTO ETUDIANT (NEtudiant, Nom, Prenom, Groupe, Age)
VALUES
    (1, 'Doe', 'John', 1, 18),
    (2, 'Smith', 'Jane', 2, 20),
    (3, 'Johnson', 'Robert', 1, 17);


INSERT INTO EVALUER (NEtudiant, CodeMat, DateExamen, Note)
VALUES
    (1, 101, '2023-09-01', 18.5),
    (1, 102, '2023-09-02', 15.0),
    (2, 101, '2023-09-01', 16.5),
    (2, 103, '2023-09-02', 14.0),
    (3, 102, '2023-09-01', 17.0);


INSERT INTO MATIERE (CodeMat, LibelleMat, CoeffMat)
VALUES
    (101, 'Mathématiques', 3.0),
    (102, 'Français', 2.5),
    (103, 'Histoire', 2.0);

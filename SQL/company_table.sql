create schema if not exists company_constraints;
use company_constraints;

-- restrição atribuída a um domínio
-- create domain D_num as int check(D_num> 0 and D_num< 21);


create table employee(
	fname varchar(15) NOT NULL,
	Minit char,
	Lname varchar(15) NOT NULL,
	Ssn char(9) NOT NULL,
	Bdate date,
	Adress varchar(30),
	sex char,
	Salary decimal(10,2),
	super_ssn char(9),
	Dno int NOT NULL,
    constraint chk_salary_employee check (Salary> 2000.0),
	constraint pk_employee primary key (Ssn)
);

desc departament;

create table departament(
	Dname varchar(15) not null,
	Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
	constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept Unique (Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber)
);

create table project(
	Pname varchar(15) not null,
	Pnumber int not null,
	Plocation varchar(15),
	Dnum int not null,
	primary key (Pnumber),
	constraint unique_project unique (Pname),
	constraint fk_project foreign key (Dnum) references departament(Dnumber)
);

create table works_on(
	Essn char(9) not null,
	Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn,Pno),
    constraint fk_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_works_on2 foreign key (Pno) references project(Pnumber)
);

create table dependent(
Essn char(9) not null,
Dependent_name varchar(15) not null,
Sex char, -- F ou M
Bdate date,
Relationship varchar (8),
Age int not null,
constraint chk_age_dependent check (Age<22),
primary key (Essn, Dependent_name),
constraint fk_dependant foreign key (Essn) references employee(Ssn)
);

show tables;
desc employee;

select * from information_schema.table_constraints
	where constraint_schema = 'company_constraints';
    
alter table dependent drop constraint fk_dependant;

alter table employee
	add constraint fk_employee
    foreign key(super_ssn) references employee(ssn)
    on delete set null
    on update cascade;
--Ερώτημα 1:
Ερώτημα_1.png

--Ερώτημα 2:
create database personnel;
show databases;

+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| new_personnel      |
| performance_schema |
| personnel          |
| phpmyadmin         |
| test               |
+--------------------+

--Ερώτημα 3:
use personnel;

MariaDB [personnel]>

--Eρώτημα 4:
show tables;

MariaDB [personnel]> show tables;
Empty set (0.001 sec)

--Ερώτημα 5:
create table DEPT(
DEPTNO int(2) not null,
DNAME varchar(30),
LOC varchar(30),
primary key (DEPTNO));

MariaDB [personnel]> describe dept
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| DEPTNO | int(2)      | NO   | PRI | NULL    |       |
| DNAME  | varchar(30) | YES  |     | NULL    |       |
| LOC    | varchar(30) | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+

create table JOB(
JOBCODE int(3) not null,
JOB_DESCR varchar(30),
SAL decimal(8,2),
primary key (JOBCODE));

MariaDB [personnel]> describe job;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| JOBCODE   | int(3)       | NO   | PRI | NULL    |       |
| JOB_DESCR | varchar(30)  | YES  |     | NULL    |       |
| SAL       | decimal(8,2) | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+

create table EMP(
EMPNO int(3) not null,
NAME varchar(30),
JOBNO int(3),
DEPTNO int(2),
COMM decimal(8,2),
primary key (EMPNO),
foreign key (JOBNO) references JOB(JOBCODE),
foreign key (DEPTNO) references DEPT(DEPTNO));

+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| EMPNO  | int(3)       | NO   | PRI | NULL    |       |
| NAME   | varchar(30)  | YES  |     | NULL    |       |
| JOBNO  | int(3)       | YES  | MUL | NULL    |       |
| DEPTNO | int(2)       | YES  | MUL | NULL    |       |
| COMM   | decimal(8,2) | YES  |     | NULL    |       |
+--------+--------------+------+-----+---------+-------+

--Η εισαγωγή δεδομένων γίνεται στα Αγγλικά γιατί οι ελληνικοί χαρακτήρες
--εμφανίζονται ως '???'

insert into DEPT(DEPTNO, DNAME, LOC)
values
(50, 'SALES', 'ATHENS'),
(60, 'ACCOUNTING', 'ATHENS'),
(70, 'PAYROLL', 'VOLOS');

MariaDB [personnel]> select * from dept;
+--------+------------+--------+
| DEPTNO | DNAME      | LOC    |
+--------+------------+--------+
|     50 | SALES      | ATHENS |
|     60 | ACCOUNTING | ATHENS |
|     70 | PAYROLL    | VOLOS  |
+--------+------------+--------+

insert into JOB(JOBCODE, JOB_DESCR, SAL)
values
(100, 'SALESMAN', 2200),
(200, 'ANALYST', 2000),
(300, 'OPERATOR', 1000);

MariaDB [personnel]> select * from job;
+---------+-----------+---------+
| JOBCODE | JOB_DESCR | SAL     |
+---------+-----------+---------+
|     100 | SALESMAN  | 2200.00 |
|     200 | ANALYST   | 2000.00 |
|     300 | OPERATOR  | 1000.00 |
+---------+-----------+---------+

insert into EMP(EMPNO, NAME, JOBNO, DEPTNO, COMM)
values
(10, 'SPYROY', 100, 50, 450),
(20, 'XRHSTOY', 200, 50, NULL),
(30, 'NIKOY', 300, 60, NULL),
(40, 'SPYROY', 200, 50, NULL);

MariaDB [personnel]> select * from emp;
+-------+---------+-------+--------+--------+
| EMPNO | NAME    | JOBNO | DEPTNO | COMM   |
+-------+---------+-------+--------+--------+
|    10 | SPYROY  |   100 |     50 | 450.00 |
|    20 | XRHSTOY |   200 |     50 |   NULL |
|    30 | NIKOY   |   300 |     60 |   NULL |
|    40 | SPYROY  |   200 |     50 |   NULL |
+-------+---------+-------+--------+--------+

--Ερώτημα 6:
select
e.empno,
e.name,
j.job_descr,
j.sal,
e.deptno
from EMP e
join JOB j on e.jobno= j.jobcode
where j.job_descr= 'SALESMAN';

+-------+--------+-----------+---------+--------+
| empno | name   | job_descr | sal     | deptno |
+-------+--------+-----------+---------+--------+
|    10 | SPYROY | SALESMAN  | 2200.00 |     50 |
+-------+--------+-----------+---------+--------+

--Ερώτημα 7:
select
max(j.sal) as 'max_sal',
min(j.sal) as 'min_sal',
avg(j.sal) as 'avg_sal',
count(j.sal) as 'count_sal',
count(e.comm) as 'count_comm',
count(*) as 'total_emp'
from EMP e
join JOB j on e.jobno= j.jobcode;

+---------+---------+-------------+-----------+------------+-----------+
| max_sal | min_sal | avg_sal     | count_sal | count_comm | total_emp |
+---------+---------+-------------+-----------+------------+-----------+
| 2200.00 | 1000.00 | 1800.000000 |         4 |          1 |         4 |
+---------+---------+-------------+-----------+------------+-----------+

--Ερώτημα 8:
select
max(j.sal) as 'max_analyst_sal',
avg(j.sal) as 'avg_analyst_sal'
from EMP e
join JOB j on e.jobno= j.jobcode
where j.job_descr= 'ANALYST';

+-----------------+-----------------+
| max_analyst_sal | avg_analyst_sal |
+-----------------+-----------------+
|         2000.00 |     2000.000000 |
+-----------------+-----------------+

--Ερώτημα 9:
select
e.empno,
e.name,
j.job_descr,
j.sal,
e.deptno
from EMP e
join JOB j on e.jobno= j.jobcode
where j.job_descr= 'ANALYST'
and j.sal between 1000 and 2500;

+-------+---------+-----------+---------+--------+
| empno | name    | job_descr | sal     | deptno |
+-------+---------+-----------+---------+--------+
|    20 | XRHSTOY | ANALYST   | 2000.00 |     50 |
|    40 | SPYROY  | ANALYST   | 2000.00 |     50 |
+-------+---------+-----------+---------+--------+

--Ερώτημα 10:
select
e.empno,
e.name,
j.job_descr,
j.sal,
e.deptno
from EMP e
join JOB j on e.jobno= j.jobcode
where e.name like '%R%';

+-------+---------+-----------+---------+--------+
| empno | name    | job_descr | sal     | deptno |
+-------+---------+-----------+---------+--------+
|    10 | SPYROY  | SALESMAN  | 2200.00 |     50 |
|    20 | XRHSTOY | ANALYST   | 2000.00 |     50 |
|    40 | SPYROY  | ANALYST   | 2000.00 |     50 |
+-------+---------+-----------+---------+--------+

--Ερώτημα 11:
select
e.empno,
e.name,
j.job_descr,
j.sal,
e.deptno
from emp e
join JOB j on e.jobno= j.jobcode
order by e.deptno asc, j.sal asc;

+-------+---------+-----------+---------+--------+
| empno | name    | job_descr | sal     | deptno |
+-------+---------+-----------+---------+--------+
|    20 | XRHSTOY | ANALYST   | 2000.00 |     50 |
|    40 | SPYROY  | ANALYST   | 2000.00 |     50 |
|    10 | SPYROY  | SALESMAN  | 2200.00 |     50 |
|    30 | NIKOY   | OPERATOR  | 1000.00 |     60 |
+-------+---------+-----------+---------+--------+

--Ερώτημα 12:
select
e.deptno,
avg(j.sal) as 'avg_sal',
count(e.empno) as 'emp_count'
from emp e
join job j on e.jobno= j.jobcode
group by e.deptno;

+--------+-------------+-----------+
| deptno | avg_sal     | emp_count |
+--------+-------------+-----------+
|     50 | 2066.666667 |         3 |
|     60 | 1000.000000 |         1 |
+--------+-------------+-----------+
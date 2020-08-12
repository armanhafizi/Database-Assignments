create database testbench4;
use testbench4;



CREATE TABLE Salesman
(
    salesman_id varchar(10) PRIMARY KEY NOT NULL,
    name varchar(20) NOT NULL,
    city varchar(20) NOT NULL,
    commission int
);




CREATE TABLE Customer
(
    customer_id varchar(10) PRIMARY KEY NOT NULL,
    name varchar(20) NOT NULL,
    city varchar(20) NOT NULL,
    salesman_id varchar(10) NOT NULL,
	FOREIGN KEY (salesman_id) REFERENCES testbench4.Salesman (salesman_id)
);



CREATE TABLE ordr
(
    ord_no int PRIMARY KEY NOT NULL,
    purch_amt int NOT NULL,
    ord_date varchar(10) NOT NULL,
    customer_id varchar(10) NOT NULL,
    salesman_id varcharacter(10) NOT NULL,
    FOREIGN KEY (salesman_id) REFERENCES testbench4.Salesman (salesman_id),
    FOREIGN KEY (customer_id) REFERENCES testbench4.Customer (customer_id)
);



insert into Salesman(salesman_id, name, city, commission) values
  ('1111', 'Ali', 'Tehran', 12),
  ('2222', 'Arman', 'Bushehr', 37),
  ('3333', 'Reza', 'Mashhad', 0);


insert into Customer(customer_id, name, city, salesman_id) values
  ('11', 'Ahmad', 'Shiraz', '2222'),
  ('22', 'Mohsen', 'Arak', '2222'),
  ('33', 'Mahsa', 'Kazeroon', '3333'),
  ('44', 'Farah', 'Tabriz', '1111'),
  ('55', 'Hossein', 'Mahshahr', '1111'),
  ('66', 'Sanaz', 'Yazd', '1111'),
  ('77', 'Parastoo', 'Shiraz', '1111');


insert into ordr(ord_no, purch_amt, ord_date, customer_id, salesman_id) values
  ('1', 2, '07/05/93', '55', '1111'),
  ('2', 1, '08/06/96', '44', '1111'),
  ('3', 1, '19/11/95', '44', '1111'),
  ('4', 3, '02/01/96', '66', '1111'),
  ('5', 2, '09/01/96', '33', '3333'),
  ('6', 8, '07/05/97', '22', '2222'),
  ('7', 6, '14/07/90', '11', '2222'),
  ('8', 4, '11/04/91', '11', '2222'),
  ('9', 1, '22/08/91', '55', '1111');


create view v1(order_no, salesman_id, customer_id)
  as select ordr.ord_no, ordr.salesman_id, ordr.customer_id
  from ordr;


create view v2(ord_date, salesman_id)
	as select ordr.ord_date, ordr.salesman_id
    from ordr
    where purch_amt = (select max(ordr.purch_amt) from ordr where ord_date = ordr.ord_date)
    group by ordr.ord_date;


create view v3( name, average, total)
	as select Salesman.name, avg(ordr.purch_amt), sum(ordr.purch_amt)
    from ordr, Salesman
    where Salesman.salesman_id = ordr.Salesman_id
    group by ordr.salesman_id;
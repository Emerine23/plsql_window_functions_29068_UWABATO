create table Customers(Customer_id varchar(21) primary key,customer_name varchar(21),Place varchar(21));

insert into Customers values (101,'Alice','Kigali');
insert into Customers values (102,'Keza','Huye');
insert into Customers values (103,'John','Nyanza');	
insert into Customers values (104,'Jimmy','Kigali');
insert into Customers values (105,'Alex','Rubavu');

Create table Products (product_id varchar(21) primary key, product_name varchar(21),product_price number);

insert into Products values('P01','Laptop',800000);
insert into Products values('P02','Phone',100000);
insert into Products values('P03','Headphones',60000);
insert into Products values('P04','Desktop',1500000);
insert into products values('P05','Printers',600000);
insert into products values('P06','Scanner',500000);

Create table Sales (sales_id varchar(21) primary key, Customer_id varchar(21),product_id varchar(21),sales_date DATE, quantity INT, 
foreign key (Customer_id) references Customers(Customer_id),foreign key(product_id) references Products(product_id));

insert into Sales values (1,101,'P01',To_DATE('10/01/2025','DD/MM/YYYY'),1);
insert into Sales values (2,102,'P02',To_DATE('15/01/2025','DD/MM/YYYY'),4);	
insert into Sales values (3,103,'P03',To_DATE('20/01/2025','DD/MM/YYYY'),3);
insert into Sales values (4,104,'P04',To_DATE('25/01/2025','DD/MM/YYYY'),6);
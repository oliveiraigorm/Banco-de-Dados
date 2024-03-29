
-- pgsqlds2_create_db.sql: DVD Store Database Version 2.1 Build Script - Postgres version
-- Copyright (C) 2011 Vmware, Inc. 
-- Last updated 2/13/11
-- Tables

CREATE TABLE CUSTOMERS
  (
  CUSTOMERID SERIAL PRIMARY KEY, 
  FIRSTNAME VARCHAR(50) NOT NULL, 
  LASTNAME VARCHAR(50) NOT NULL, 
  ADDRESS1 VARCHAR(50) NOT NULL, 
  ADDRESS2 VARCHAR(50), 
  CITY VARCHAR(50) NOT NULL, 
  STATE VARCHAR(50), 
  ZIP VARCHAR(9), 
  COUNTRY VARCHAR(50) NOT NULL, 
  REGION SMALLINT NOT NULL,
  EMAIL VARCHAR(50),
  PHONE VARCHAR(50),
  CREDITCARDTYPE INT NOT NULL,
  CREDITCARD VARCHAR(50) NOT NULL, 
  CREDITCARDEXPIRATION VARCHAR(50) NOT NULL, 
  USERNAME VARCHAR(50) NOT NULL, 
  PASSWORD VARCHAR(50) NOT NULL, 
  AGE SMALLINT, 
  INCOME INT,
  GENDER VARCHAR(1) 
  )
  ;
  
CREATE TABLE CUST_HIST
  (
  CUSTOMERID INT NOT NULL, 
  ORDERID INT NOT NULL, 
  PROD_ID INT NOT NULL 
  )
  ;
  
CREATE TABLE ORDERS
  (
  ORDERID SERIAL PRIMARY KEY, 
  ORDERDATE DATE NOT NULL, 
  CUSTOMERID INT, 
  NETAMOUNT NUMERIC NOT NULL, 
  TAX NUMERIC NOT NULL, 
  TOTALAMOUNT NUMERIC NOT NULL
  )
  ; 
  
CREATE TABLE ORDERLINES
  (
  ORDERLINEID serial NOT NULL, 
  ORDERID INT NOT NULL, 
  PROD_ID INT NOT NULL, 
  QUANTITY SMALLINT NOT NULL, 
  ORDERDATE DATE NOT NULL
  )
  ; 
  
CREATE TABLE PRODUCTS
  (
  PROD_ID SERIAL PRIMARY KEY, 
  CATEGORY SMALLINT NOT NULL, 
  TITLE TEXT NOT NULL, 
  ACTOR TEXT NOT NULL, 
  PRICE NUMERIC NOT NULL, 
  SPECIAL SMALLINT,
  COMMON_PROD_ID INT NOT NULL 
  )
  ;

CREATE TABLE INVENTORY
  (
  PROD_ID INT NOT NULL PRIMARY KEY,
  QUAN_IN_STOCK INT NOT NULL,
  SALES INT NOT NULL
  ) WITH (fillfactor=85)
  ;
   

CREATE TABLE CATEGORIES
  (
  CATEGORY SERIAL PRIMARY KEY, 
  CATEGORYNAME VARCHAR(50) NOT NULL  
  )
  ;
   
  
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (1,'Action');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (2,'Animation');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (3,'Children');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (4,'Classics');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (5,'Comedy');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (6,'Documentary');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (7,'Drama');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (8,'Family');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (9,'Foreign');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (10,'Games');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (11,'Horror');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (12,'Music');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (13,'New');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (14,'Sci-Fi');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (15,'Sports');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (16,'Travel');
  

CREATE TABLE REORDER
  (
  PROD_ID INT NOT NULL,
  DATE_LOW DATE NOT NULL,
  QUAN_LOW INT NOT NULL,
  DATE_REORDERED DATE,
  QUAN_REORDERED INT,
  DATE_EXPECTED DATE
  )
  ;

  alter table orders add constraint fk_orders_customers 
    foreign key (customerid) references customers(customerid)
    on delete restrict on update restrict;

  alter table cust_hist add constraint fk_products_hist
    foreign key (prod_id) references products(prod_id)
    on delete restrict on update restrict;

  alter table cust_hist add constraint fk_orders_hist
    foreign key (orderid) references orders(orderid)
    on delete restrict on update restrict;
  
  alter table cust_hist add constraint pk_cust_hist
    primary key (customerid, prod_id, orderid);

  alter table products add constraint fk_products_categories
    foreign key (category) references categories(category)
    on delete restrict on update restrict;

  alter table orderlines add constraint fk_orderlines_products
    foreign key (prod_id) references products(prod_id)
    on delete restrict on update restrict;

  alter table orderlines add constraint pk_orderlines
    primary key (orderlineid, prod_id, orderid);

  alter table inventory add constraint fk_inventory_products
    foreign key (prod_id) references products(prod_id)
    on delete restrict on update restrict;



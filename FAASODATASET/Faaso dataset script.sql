-- CREATE DATABASE
CREATE DATABASE FASSOS_PORTFOLIO__PROJECT;

-- DATABASE SELECTED
USE FASSOS_PORTFOLIO__PROJECT;

-- 1.CREATE TABLE DRIVER
CREATE TABLE driver(driver_id int,reg_date date);

-- INSERT THE VALUES INTO DRIVER TABLE
INSERT INTO driver values
(1,'2021-01-01'),
(2,'2021-01-03'),
(3,'2021-01-08'),
(4,'2021-01-15');

-- 2.CREATE TABLE INGREDIENTS
CREATE TABLE ingredients(ingredients_id int,ingredients_name varchar(60));

-- INSERT INTO VALUES INTO INGREDINETS TABLE
INSERT INTO ingredients values
(1,'BBQ Cicken'),
(2,'Chilli Sauce'),
(3,'Chicken'),
(4,'Cheese'),
(5,'Kebab'),
(6,'Mushrooms'),
(7,'Onions'),
(8,'Egg'),
(9,'Peppers'),
(10,'schezwan sauce'),
(11,'Tomatoes'),
(12,'Tomato Sauce');

-- 3.CREATE TABLE ROLLS

CREATE TABLE rolls(roll_id int ,roll_name varchar(15));

-- INSERT THE  VALUES INTO TABLE NAME ROLLS
INSERT INTO rolls VALUES
(1,'Non Veg roll'),
(2,'Veg roll');

-- 4.CREATE TABLE rolls_recipes
CREATE TABLE rolls_recipes(roll_id integer,ingredients varchar(24)); 

-- INSERT THE VALUES INTO TABLE NAME rolls_recipes
INSERT INTO rolls_recipes(roll_id ,ingredients) 
 VALUES (1,'1,2,3,4,5,6,8,10'),
  (2,'4,6,7,9,11,12');

-- 5.CREATE TABLE DRIVER_ORDER

CREATE TABLE driver_order(order_id integer,driver_id integer,pickup_time datetime,
distance VARCHAR(7),duration VARCHAR(10),cancellation VARCHAR(23));

-- INSERT THE VALUES INTO TABLE NAME DRIVER_ORDER

INSERT INTO driver_order(order_id,driver_id,pickup_time,distance,duration,cancellation) 
 VALUES(1,1,'2021-01-01 18:15:34','20km','32 minutes',''),
(2,1,'2021-01-01 19:10:54','20km','27 minutes',''),
(3,1,'2021-01-03 00:12:37','13.4km','20 mins','NaN'),
(4,2,'2021-01-04 13:53:03','23.4','40','NaN'),
(5,3,'2021-01-08 21:10:57','10','15','NaN'),
(6,3,null,null,null,'Cancellation'),
(7,2,'2020-01-08 21:30:45','25km','25mins',null),
(8,2,'2020-01-10 00:15:02','23.4 km','15 minute',null),
(9,2,null,null,null,'Customer Cancellation'),
(10,1,'2020-01-11 18:50:20','10km','10minutes',null);

-- 6.CREATE TABLE CUSTOMER_ORDERS

CREATE TABLE customer_orders(order_id integer,customer_id integer,roll_id integer,not_include_items VARCHAR(4),
extra_items_included VARCHAR(4),order_date datetime);

-- INSERT THE VALUES INTO customers_table
INSERT INTO customer_orders(order_id,customer_id,roll_id,not_include_items,extra_items_included,order_date)
values (1,101,1,'','','2021-01-01  18:05:02'),
(2,101,1,'','','2021-01-01 19:00:52'),
(3,102,1,'','','2021-01-02 23:51:23'),
(3,102,2,'','NaN','2021-01-02 23:51:23'),
(4,103,1,'4','','2021-01-04 13:23:46'),
(4,103,1,'4','','2021-01-04 13:23:46'),
(4,103,2,'4','','2021-01-04 13:23:46'),
(5,104,1,null,'1','2021-01-08 21:00:29'),
(6,101,2,null,null,'2021-01-08 21:03:13'),
(7,105,2,null,'1','2021-01-08 21:20:29'),
(8,102,1,null,null,'2021-01-09 23:54:33'),
(9,103,1,'4','1,5','2021-01-10 11:22:59'),
(10,104,1,null,null,'2021-01-11 18:34:49'),
(10,104,1,'2,6','1,4','2021-01-11 18:34:49');







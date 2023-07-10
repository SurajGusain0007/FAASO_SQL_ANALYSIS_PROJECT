-- Driver and Customer Experience

USE FASSOS__PORTFOLIO__PROJECT;

-- FETCH ALL THE RECORDS OF THE TABLE

SELECT * FROM driver;
SELECT * FROM ingredients;
SELECT * FROM rolls;
SELECT * FROM rolls_recipes;
SELECT * FROM driver_order;
SELECT * FROM customer_orders;

-- 1. What was the avergae time in minutes it took for each driver to arrive at the fasoos HQ to pickup the order?
WITH date_diff(diff_time,driver_id) AS(
SELECT TIMESTAMPDIFF(MINUTE,TIME(c.order_date),TIME(d.pickup_time)) as diff_time,d.driver_id
FROM driver_order AS  d
JOIN customer_orders AS c
ON  d.order_id=c.order_id
where d.pickup_time IS NOT NULL)

Select driver_id,round(avg(diff_time),2) as Avg_time
FROM date_diff
GROUP BY driver_id;

-- 2 IS THERE ANY RELATIONSHIP BETWEEN THE NUMBER OF ROLLS AND HOW LONG THE ORDER TAKES TO PREPARE ?


WITH date_diff(roll_id,order_id,customer_id,diff_time,driver_id) AS(
SELECT c.roll_id ,d.order_id,c.customer_id ,TIMESTAMPDIFF(MINUTE,TIME(c.order_date),TIME(d.pickup_time)) as diff_time,d.driver_id
FROM driver_order AS  d
JOIN customer_orders AS c
ON  d.order_id=c.order_id
where d.pickup_time IS NOT NULL)

SELECT a.order_id,COUNT(a.roll_id) as total_roll_id,round(SUM(diff_time)/COUNT(roll_id),0) as avg_time_taken FROM
(SELECT customer_id,order_id,roll_id,diff_time
FROM date_diff) a
GROUP BY a.order_id;

-- 3 What was the average distance travelled for each customer?
WITH date_diff(roll_id,order_id,customer_id,distance,diff_time,driver_id) AS(
SELECT c.roll_id ,d.order_id,c.customer_id ,distance,TIMESTAMPDIFF(MINUTE,TIME(c.order_date),TIME(d.pickup_time)) as diff_time,d.driver_id
FROM driver_order AS  d
JOIN customer_orders AS c
ON  d.order_id=c.order_id
where d.pickup_time IS NOT NULL)


SELECT X.customer_id,AVG(distance) as avg_distance FROM
(SELECT roll_id,customer_id,diff_time,order_id,cast(trim(REPLACE(lower(distance),"km","")) AS DECIMAL(4,2)) distance
FROM date_diff) x
GROUP BY customer_id;


-- 4 What was the differnce between the longest and shortest delivery times for all orders?
SELECT MAX(d)-MIN(d) AS difference
FROM
(SELECT cast(x.duration_  AS DECIMAL) as d
FROM
(SELECT *,
CASE WHEN duration LIKE '%min%' THEN substring(duration,1,2) ELSE duration END AS duration_
FROM driver_order
WHERE duration is NOT NULL) x)y ;

-- 5.WHat was the average speed for each driver for each delivery and do you notice any trend for these values?

WITH TABLE1 (Speed,order_id,driver_id)
as
(SELECT distance/time_ AS Speed,order_id,driver_id
from
(SELECT cast(trim(REPLACE(lower(distance),"km","")) AS DECIMAL) distance
,CASE WHEN duration LIKE '%min%' THEN substring(duration,1,2) ELSE duration END AS  Time_,order_id,driver_id
FROM DRIVER_ORDER) FINAL)

SELECT X.order_id,count(roll_id),round(avg(speed),2) as Average_speed FROM
(select Speed,C.order_id,driver_id,roll_id from table1 T
join customer_orders C
on T.order_id=C.order_id
WHERE Speed IS NOT NULL) X
GROUP BY X.order_id;

-- 6. WHAT IS THE SUCCESSFUL PERCENTAGE FOR EACH DRIVER

SELECT driver_id,(round(SUM(PERCEN)/COUNT(DRIVER_ID),2)*100) AS SUCCESSFUL_DELIVERY_PERCENTAGE
FROM 
(SELECT driver_id,
CASE WHEN Cancellation LIKE '%Cancel%' THEN 0
ELSE 1 END AS PERCEN
FROM driver_order) FINAL
GROUP BY driver_id
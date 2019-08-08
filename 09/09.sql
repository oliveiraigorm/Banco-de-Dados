
--09
--Igor MIranda Oliveira

--2

SELECT categoryname FROM categories NATURAL JOIN (SELECT category FROM products NATURAL JOIN (
		SELECT prod_id FROM (SELECT prod_id, SUM(quantity) 
		FROM orderlines WHERE orderdate > '2009-01-15'::date 
		GROUP BY(prod_id)) as a WHERE count > '35') as b) AS c
		
		
--3

CREATE OR REPLACE FUNCTION disp ()
RETURNS TABLE(categoria VARCHAR, quantidade BIGINT) AS $$
BEGIN
RETURN QUERY SELECT categoryname, SUM(quan_in_stock) FROM 
(SELECT * FROM inventory NATURAL JOIN products)as a 
NATURAL JOIN categories GROUP BY(categories.categoryname);
END
$$
LANGUAGE 'plpgsql'

--4

CREATE view vendas AS SELECT * FROM (SELECT prod_id, SUM(quantity) 
		FROM orderlines WHERE orderdate > '2009-01-15'::date 
		GROUP BY(prod_id)) AS a FULL OUTER JOIN
		 (SELECT prod_id AS prodid, sales FROM inventory) AS b
		 ON a.prod_id = b.prodid

--5

SELECT age, COUNT(age) FROM customers NATURAL JOIN (SELECT * FROM orders NATURAL JOIN
(SELECT orderid FROM categories NATURAL JOIN orderlines WHERE categoryname = 'Games')AS b)AS A 
GROUP BY (age) ORDER BY COUNT(age) DESC LIMIT 10

--6

SELECT title, count FROM products NATURAL JOIN (SELECT prod_id, COUNT(prod_id) FROM cust_hist GROUP BY (prod_id)
 ORDER BY (COUNT(prod_id)) DESC LIMIT 10) AS a

--7

SELECT prod_id AS prodid, sales FROM inventory ORDER BY (sales) DESC LIMIT 3

SELECT cron.schedule(

--8

CREATE OR REPLACE FUNCTION avisa()
 RETURNS trigger AS
$$
DECLARE
	registro RECORD;
BEGIN
	
   FOR registro IN
       SELECT prod_id FROM cust_hist NATURAL JOIN inventory 
	WHERE inventory.quan_in_stock = 0
	LOOP
		RAISE NOTICE 'O produto % está sem estoque!!', registro.prod_id;
	END LOOP;
END
$$

LANGUAGE 'plpgsql'

CREATE TRIGGER avisa
  AFTER INSERT
  ON cust_hist
  EXECUTE PROCEDURE avisa();

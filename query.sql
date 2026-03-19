SELECT COUNT(*) FROM walmart;

DROP TABLE walmart;

SELECT * FROM walmart;

SELECT payment_method,COUNT(*)
FROM walmart
GROUP BY payment_method;

SELECT COUNT(DISTINCT branch)
FROM walmart;

--Finding the different payment method and number of transcation,number of quantity

SELECT payment_method,COUNT(*) AS no_of_transcation,SUM(quantity) AS no_of_quantity
FROM walmart
GROUP BY payment_method;

--Identify the highest rated category in each branch,displaying the branch,category
--avg rating

SELECT *
FROM 
(
	SELECT category,branch,AVG(rating) as avg_rating,
	RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) as rank
	FROM walmart
	GROUP BY 1,2
)
WHERE rank=1;


--Identify the busiest day based on the number of transcation
SELECT branch,TO_CHAR(TO_DATE(date,'DD-MM-YY'),'Day') as formatted_date,
COUNT(*) as no_of_transcation
FROM walmart
GROUP BY 1,2;


---Calculate the total quantity and list the payment method payment method
SELECT SUM(quantity) AS total_quantity,payment_method
FROM walmart
GROUP BY 2;


--list the average rating,min,max of products by each city

SELECT city,category,AVG(rating) AS avg_rating,MIN(rating) AS min_rating,MAX(rating) AS max_rating
FROM walmart
GROUP BY 1,2;


--common method for each branch 
SELECT branch,payment_method,COUNT(*) AS total_transcation,
RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
FROM walmart
GROUP BY 1,2;


SELECT 
CASE
	WHEN EXTRACT(HOUR FROM(time::time))< 12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
END Day_time,
COUNT(*)
FROM walmart
GROUP BY 1;


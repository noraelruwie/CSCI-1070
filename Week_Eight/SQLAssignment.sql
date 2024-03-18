-- question 1, 2 pts
SELECT * 
From customer 
Where last_name LIKE 'T%'
ORDER BY first_name ASC; 

-- question 2, 2 points
SELECT * 
FROM rental 
WHERE return_date >= '2005-05-28' AND return_date <= '2005-06-01';

-- question 3, 3 pts

SELECT film.title AS movie_title, COUNT (rental.rental_id) AS rental_count 
FROM film 
JOIN inventory ON film.film_id = inventory.film_id 
JOIN rental ON inventory.inventory_id = rental.inventory_id 
GROUP BY film.title 
ORDER BY rental_count DESC 
LIMIT 10; 

-- question 4, 3 points 

SELECT
	customer.customer_id, 
	CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name, 
	SUM(payment.amount) as total_spent 
	
FROM 
	customer 
JOIN 
	payment ON customer.customer_id = payment.customer_id 
GROUP BY 
	customer.customer_id, 
	customer.first_name, 
	customer.last_name 
ORDER BY 
	total_spent; 
	
-- question 5, 3 points 

SELECT 
	a.actor_id, 
	CONCAT(a.first_name, ' ', a.last_name) as actor_name, 
	COUNT(*) AS movie_count 
FROM 
	actor a 
JOIN 
	film_actor fa ON a.actor_id = fa.actor_id 
JOIN 
	film f ON fa.film_id = f.film_id 
JOIN 
	inventory i ON f.film_id = i.film_id 
JOIN 
	rental r ON i.inventory_id = r.inventory_id 
WHERE 
	EXTRACT(YEAR FROM r.rental_date) = 2006 
GROUP BY 
	a.actor_id, 
	actor_name 
ORDER BY 
	movie_count DESC 
LIMIT 
	1; 
	
-- question 6, 4 points 
-- For question 4 I retrieved data from the customer table and from the payment table. I started by making a column called customer_name, and a column called total_spent which was the SUM of all payment amounts. I grouped the data by customer and then I ordered it by the total spent to show from the least spent to most spent. 
-- For question 5 I began by retrieving the data from the actor, film_actor, film, and rental tables. I then joined the actor table with the film_actor table uding the actor_id column and then I joined the film table using the film_id column. Finally I joined the rental table using the film_id column in order to be able to filter rentals from 2006. I used the WHERE clause to enable filtering rentals from the year 2006 using the EXTRACT(Year FROM r.rental_date) function. 
-- the data is grouped using the GROUP BY clause. I grouped actor_id and actor_name. Then I counted the movies each actor was in using the COUNT(*) clause. 
-- I ordered the movie count data using the ORDER BY clause and then I limited the results to 1 so I would only see the actor with the most movies in 2006. 

-- question 7, 4 points 

SELECT 
	c.name AS genre, 
	AVG(f.rental_rate) AS average_rental_rate 
	
FROM 
	film f 
JOIN
	film_category fc ON f.film_id = fc.film_id
JOIN 
	category c ON fc.category_id = c.category_id
GROUP BY 
	c.name;

-- question 8, 4 points

SELECT 
	c.name AS cateogry_name, 
	COUNT(r.rental_id) AS total_rentals, 
	SUM(p.amount) AS total_sales 
FROM 
	category c 
JOIN 
	film_category fc ON c.category_id = fc.category_id 
JOIN
	inventory i ON fc.film_id = i.film_id 
JOIN 
	rental r ON i.inventory_id = r.inventory_id 
JOIN 
	payment p ON r.rental_id = p.rental_id 
GROUP BY 
	c.name 
ORDER BY 
	total_rentals DESC 
LIMIT 
	5; 

-- Extra Credit, 2 points 
SELECT 
	EXTRACT(MONTH FROM rental_date) AS rental_month, 
	EXTRACT (YEAR FROM rental_date) AS rental_year, 
	c.name AS category, 
	COUNT(*) AS total_rentals 
FROM 
	rental r 
JOIN 
	inventory i ON r.inventory_id = i.inventory_id 
JOIN 
	film_category fc ON i.film_id = fc.film_id 
JOIN 
	category c ON fc.category_id = c.category_id 
GROUP BY 
	rental_month, 
	rental_year, 
	category
ORDER BY 
	rental_month, 
	rental_year, 
	total_rentals DESC 


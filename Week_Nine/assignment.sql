-- Question One, three points 
ALTER TABLE rental
ADD COLUMN status VARCHAR(50);

UPDATE rental
SET status = subquery.status
FROM (
    SELECT 
        rental_id,
        CASE
            WHEN return_date IS NULL THEN 'Not Returned'
            WHEN return_date > rental_date + (film.rental_duration || ' days')::interval THEN 'Late'
            WHEN return_date < rental_date + (film.rental_duration || ' days')::interval THEN 'Early'
            ELSE 'On Time'
        END AS status
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
) AS subquery
WHERE rental.rental_id = subquery.rental_id;

SELECT * from rental;

-- Question Two, two points
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       a.address,
       ci.city,
       SUM(p.amount) AS total_payment_amount
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN payment p ON c.customer_id = p.customer_id
WHERE ci.city IN ('Kansas City', 'Saint Louis')
GROUP BY c.customer_id, c.first_name, c.last_name, a.address, ci.city;

-- Question Three, two points

SELECT c.name AS category_name, COUNT(fc.film_id) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- Question Four, one point
-- The reason for there being a table for category and a table for film_category is to make sure there is a good management of data and it makes for more efficient querying. The cateogry table has information about film categories and has columns like "category_id" and "name". The Film_cateogry table is almost like a map between films and categories that establishes many-many relationships between films and their cateogies. This is because a film can have many vateogires and a category can have many films. Seperating them erases confusion and data redundancy. 

-- Question Five, three points 
SELECT f.film_id, 
       f.title, 
       f.length
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date >= '2005-05-15' AND r.return_date <= '2005-05-31';

-- Question Six, three points
SELECT film_id, title, rental_rate
FROM film
WHERE rental_rate < (SELECT AVG(rental_rate) FROM film);

-- Question Seven, three points 

SELECT
    CASE
        WHEN return_date IS NULL THEN 'Not Returned'
        WHEN return_date > rental_date + (film.rental_duration || ' days')::interval THEN 'Late'
        WHEN return_date < rental_date + (film.rental_duration || ' days')::interval THEN 'Early'
        ELSE 'On Time'
    END AS return_status,
    COUNT(*) AS num_films
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY return_status;

-- Question Eight, five points 
SELECT
    film_id,
    title,
    length,
    PERCENT_RANK() OVER (ORDER BY length) AS duration_percentile
FROM
    film;
-- Question Nine, three points 

EXPLAIN SELECT film_id, 
       title, 
       rental_rate
FROM film
WHERE rental_rate < (SELECT AVG(rental_rate) FROM film);






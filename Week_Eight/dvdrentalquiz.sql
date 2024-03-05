SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

Select * 
FROM payment 
WHERE amount >= 9.99;

SELECT rental.rental_id, rental.rental_date, rental.customer_id, film.title, payment.amount
FROM rental
JOIN payment ON rental.rental_id = payment.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE payment.amount = (
    SELECT MAX(amount)
    FROM payment
);

SELECT 
    staff.first_name || ' ' || staff.last_name AS full_name,
    staff.email,
    address.address,
    city.city,
    country.country
FROM 
    staff
JOIN 
    address ON staff.address_id = address.address_id
JOIN 
    city ON address.city_id = city.city_id
JOIN 
    country ON city.country_id = country.country_id;


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
	
-- I don't have a career that I am set on yet, but I do like the prospect of getting into product managemnt. I am currently trying to get a minor in BTM while majoring in computer science which could help me with a product management job.
-- Extra credit (1 pt) The crows foot notation is a way of showing the relationship between two entities in an entity-relationship mode. It shows how many instances one entity is connected to another entity. There are also different ways to decipher it, like a solid line means that theres a one-one relationshop between entitties while a circle or a > can mean that one entity might be associated with more than one other entity. We can also see if it is required for an entity to be associated with another entity. a small circle means its optional while a solid line means its mandatory. 

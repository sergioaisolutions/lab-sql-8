USE sakila;

-- EXERCISE 1

SELECT s.store_id, c.city, cc.country
FROM sakila.store s
JOIN sakila.address a USING(address_id)
JOIN sakila.city c ON a.city_id = c.city_id
JOIN sakila.country cc ON c.country_id = cc.country_id;

-- EXERCISE 2

SELECT s.store_id, SUM(p.amount)
FROM sakila.store s
JOIN sakila.payment p
ON s.manager_staff_id = p.staff_id
GROUP BY s.store_id;

-- EXERCISE 3

SELECT c.name, AVG(f.length) AS avg_length
FROM sakila.film f
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;

-- EXERCISE 4

SELECT f.title, COUNT(DISTINCT r.rental_id) AS rental_freq
FROM sakila.film f
JOIN sakila.inventory i USING(film_id)
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_freq DESC;

-- EXERCISE 5

SELECT c.name, SUM(p.amount) AS gross_revenue
FROM sakila.category c
JOIN sakila.film_category fc USING (category_id)
JOIN sakila.inventory i ON fc.film_id = i.film_id
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
JOIN sakila.payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC;

-- EXERCISE 6

SELECT COUNT(*)
FROM sakila.film f
JOIN sakila.inventory i
USING(film_id)
JOIN sakila.store s ON i.store_id = s.store_id
WHERE f.title = 'ACADEMY DINOSAUR' AND s.store_id = 1;

-- EXERCISE 7

SELECT a.first_name, a.last_name, fa.film_id, f.title
FROM sakila.actor a
RIGHT JOIN sakila.film_actor fa USING(actor_id)
INNER JOIN sakila.film f ON fa.film_id = f.film_id;

-- EXERCISE 8 (NO > 3 RENTALS CONDITION BECAUSE THAT SCENARIO DOES NOT EXIST)

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer, f.title AS film, COUNT(DISTINCT r.rental_id) AS rentals
FROM sakila.customer c
JOIN sakila.rental r USING(customer_id)
JOIN sakila.inventory i ON r.inventory_id = i.inventory_id
JOIN sakila.film f ON i.film_id = f.film_id
GROUP BY customer, film
ORDER BY rentals DESC;

-- EXERCISE 9

SELECT f.title as film_name, a.first_name AS actor_name, COUNT(fa.actor_id) as times
FROM sakila.actor a
JOIN sakila.film_actor fa USING(actor_id)
JOIN sakila.film f ON fa.film_id = f.film_id
GROUP BY film_name
ORDER BY times DESC;
USE sakila;

SELECT store_id, city, country 
FROM sakila.store s
LEFT JOIN address a ON s.address_id = a.address_id
LEFT JOIN city c ON a.city_id = c.city_id
LEFT JOIN country cn ON c.country_id = cn.country_id;

SELECT s.store_id, SUM(amount)  
FROM sakila.payment p
LEFT JOIN sakila.rental r ON p.rental_id = r.rental_id
LEFT JOIN sakila.inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN sakila.store s ON i.store_id = s.store_id
GROUP BY s.store_id;

SELECT name, AVG(length)  
FROM sakila.film f
LEFT JOIN sakila.film_category fc ON f.film_id = fc.film_id
LEFT JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY c.category_id;

SELECT name, MAX(length)  
FROM sakila.film f
LEFT JOIN sakila.film_category fc ON f.film_id = fc.film_id
LEFT JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY MAX(length) DESC;

SELECT title, COUNT(rental_id)  
FROM sakila.rental r
LEFT JOIN sakila.inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN sakila.film f ON i.film_id = f.film_id
GROUP BY title
ORDER BY COUNT(rental_id) DESC;

SELECT name, SUM(amount)  
FROM sakila.payment p
LEFT JOIN sakila.rental r ON p.rental_id = r.rental_id
LEFT JOIN sakila.inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN sakila.film_category fc ON i.film_id = fc.film_id
LEFT JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY name
ORDER BY SUM(amount) DESC
LIMIT 5;

SELECT inventory_id, title, s.store_id  
FROM sakila.inventory i 
LEFT JOIN sakila.film f ON i.film_id = f.film_id
LEFT JOIN sakila.store s ON i.store_id = s.store_id
WHERE title = 'Academy Dinosaur' AND s.store_id = 1;


SELECT *  
FROM sakila.rental
WHERE inventory_id NOT IN (
SELECT inventory_id  
FROM sakila.inventory i 
LEFT JOIN sakila.film f ON i.film_id = f.film_id
LEFT JOIN sakila.store s ON i.store_id = s.store_id
WHERE title = 'Academy Dinosaur' AND s.store_id = 1
)
ORDER BY inventory_id; 
-- No está disponible
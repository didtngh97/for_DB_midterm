WITH film_rent_more_than_26 AS(
WITH film_rent_count AS(
WITH rent_inven_film AS(
WITH inven_film AS (
SELECT inventory.film_id, title, inventory_id 
FROM inventory JOIN film
WHERE inventory.film_id = film.film_id
),
rent_date_between AS (
SELECT * 
FROM rental
WHERE unix_timestamp(rental_date) >= unix_timestamp('2005.06.01')
AND unix_timestamp(rental_date) <= unix_timestamp('2005.08.31')
)
SELECT film_id, title, rental_id
FROM inven_film JOIN rent_date_between
WHERE inven_film.inventory_id = rent_date_between.inventory_id
)
SELECT film_id, title, COUNT(rental_id) as ctRental
FROM rent_inven_film
GROUP BY film_id, title
)
SELECT *
FROM film_rent_count
WHERE ctRental > 26
)
SELECT *
FROM film_rent_more_than_26
ORDER BY ctRental DESC

INTO OUTFILE '/var/lib/mysql-files/problem3.csv'
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';
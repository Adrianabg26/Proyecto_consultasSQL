-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.

SELECT title
FROM film
WHERE rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

SELECT actor_id, CONCAT(first_name,' ', last_name) as "nombre completo"
FROM actor
WHERE actor_id BETWEEN 30 AND 40;


-- 4. Obtén las películas cuyo idioma coincide con el idioma original.

SELECT title
FROM film
WHERE language_id = original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.

select title, length
from film
order by length asc;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select CONCAT(first_name,' ', last_name)
from actor
where last_name like '%ALLEN%';

/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento.*/

select count (rating), rating
from film 
group by rating;

/*8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.*/

select title, rating, length 
from film 
where rating = 'PG-13' or length > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select variance(replacement_cost)
from film;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select MIN(length), MAX(length)
from film;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT amount, payment_date
FROM payment
ORDER BY payment_date DESC
LIMIT 1 OFFSET 2;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.

select title, rating
from film 
where rating not in ('NC-17','G');

/* 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film 
 y muestra la clasificación junto con el promedio de duración.*/

select round(avg(length),2),rating
from film
group by rating;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select title, length 
from film 
where length > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?

select sum(amount)
from payment;

-- 16. Muestra los 10 clientes con mayor valor de id.

select first_name, last_name, customer_id
from customer
order by customer_id desc
limit 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’

select actor.first_name, actor.last_name, film.title
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT title 
FROM film;

/*19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.*/

SELECT title, name, length
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE length > 180 AND category.name = 'Comedy';

/*20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.*/

SELECT c.name as categoria, round(AVG(f.length),2) as duracion
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT round(AVG(EXTRACT (DAY FROM (return_date - rental_date))),2) as "duracion media"
FROM rental;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT CONCAT(first_name,' ' ,last_name) as "Actores y Actrices"
FROM actor;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT COUNT (rental_id) as "cantidad de alquileres", rental_date as "dia"
FROM rental
GROUP BY rental_date
ORDER BY COUNT (rental_id) desc;

-- 24. Encuentra las películas con una duración superior al promedio

SELECT title, length
FROM film
WHERE length > (select avg(length) from film);

-- 25. Averigua el número de alquileres registrados por mes

SELECT count(rental_id) as "Número de alquileres" , EXTRACT(MONTH FROM rental_date) as "Mes"
FROM rental
group BY EXTRACT (MONTH FROM rental_date);

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select AVG(amount),STDDEV(amount), VARIANCE(amount)
FROM payment;

-- 27. ¿Qué películas se alquilan por encima del precio medio?

select title
from film
where rental_rate > (select avg(rental_rate) from film);

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.

select actor.actor_id,count(actor.actor_id)
from actor
join film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id
having count(actor.actor_id)>40

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

select title, count(i.inventory_id)
from film f
left join inventory i on f.film_id = i.film_id
group by title;

-- 30. Obtener los actores y el número de películas en las que ha actuado.

select a.actor_id,CONCAT(first_name,' ', last_name), count(film_id)
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id;

/*31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.*/

select title, CONCAT(first_name, ' ', last_name) as "actores"
from film
left join film_actor on film.film_id = film_actor.film_id
left join actor on actor.actor_id = film_actor.actor_id;

/*32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.*/

select CONCAT(first_name, ' ', last_name) as "actores", title
from actor
left join film_actor on actor.actor_id = film_actor.actor_id
left join film on film.film_id = film_actor.film_id;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler

select title, rental_date
from film f
left join inventory i on f.film_id = i.film_id
left join rental r on i.inventory_id = r.inventory_id;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select CONCAT(first_name, ' ', last_name), SUM(amount)
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id
order by SUM(amount) desc limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'

select CONCAT(first_name, ' ', last_name) as "Nombre actor"
from actor 
where first_name = 'JOHNNY';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

select first_name AS "Nombre", last_name AS "Apellido"
from actor;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor

select MIN(actor_id) as "Actor id más bajo", MAX(actor_id) as "Actor id más alto"
from actor;

-- 38. Cuenta cuántos actores hay en la tabla “actor”

select COUNT(*)
from actor;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select CONCAT(last_name, ' ',first_name) as "Actores"
from actor
order by last_name;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.

select film_id, title
from film
Order by film_id limit 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

select first_name, COUNT(first_name)
from actor
group by first_name
order by COUNT(first_name) desc
limit 1;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

select rental_id, CONCAT(c.first_name,' ', c.last_name) AS "Nombre cliente" 
from rental r   
join customer c on c.customer_id = r.customer_id;

/*43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.*/

select CONCAT(c.first_name,' ', c.last_name) AS "Nombre cliente", rental_date AS "Fecha de alquiler"
from customer c
left join rental r on c.customer_id = r.customer_id;

/*44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/

select title, name
from film
cross join category;

/*No aporta valor. Cada película se combina con cada una de las categorías. El resultado no tendría sentido, ya que
 no representa las relaciones entre las películas y sus categorías*/

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.

select distinct CONCAT(first_name, ' ', last_name) as "Actores de acción"
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.

select CONCAT(first_name,' ', last_name) as "Actores que no han participado en peliculas"
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
left join film f on fa.film_id = f.film_id
where f.film_id is null;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

select CONCAT(first_name,' ', last_name), COUNT(film_id)
from actor a
join film_actor fc on a.actor_id = fc.actor_id
group by a.actor_id;

/*48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.*/

CREATE VIEW actor_num_peliculas AS
select CONCAT(first_name,' ', last_name), COUNT(film_id)
from actor a
join film_actor fc on a.actor_id = fc.actor_id
group by a.actor_id;

SELECT * 
FROM actor_num_peliculas;

-- 49. Calcula el número total de alquileres realizados por cada cliente

SELECT COUNT(rental_id) as "Número total de alquileres" , CONCAT(first_name,' ', last_name) AS "Nombre cliente"
FROM rental  r 
JOIN customer c ON r.customer_id = c.customer_id 
GROUP BY c.customer_id;

-- 50. Calcula la duración total de las películas en la categoría 'Action'

SELECT SUM(length) as "Duración total películas"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE name = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

CREATE TEMPORARY TABLE cliente_rentas_temporal AS
SELECT COUNT(rental_id) as "Número total de alquileres" , CONCAT(first_name,' ', last_name) AS "Nombre cliente"
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
GROUP BY c.customer_id;

/*52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.*/

CREATE TEMPORARY TABLE peliculas_alquiladas as  
SELECT title, COUNT(rental_id)  
FROM film f  
JOIN inventory i on f.film_id = i.film_id  
JOIN rental r on i.inventory_id = r.inventory_id  
GROUP BY title 
HAVING COUNT(rental_id) >= 10;

/*53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.*/

SELECT title, CONCAT(first_name,' ', last_name) as "Nombre de cliente", return_date
from film f
JOIN inventory i on f.film_id = i.film_id
JOIN rental r on i.inventory_id = r.inventory_id
JOIN customer c on r.customer_id = c.customer_id
WHERE CONCAT(first_name,' ', last_name) = 'TAMMY SANDERS'
and return_date is null
ORDER BY title;

/*54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.*/

SELECT DISTINCT CONCAT(a.first_name, ' ', a.last_name), a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name;

/*55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.*/

SELECT DISTINCT CONCAT(a.first_name, ' ', a.last_name) AS "Nombre actores", a.last_name 
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
        SELECT MIN(r.rental_date)
        FROM rental AS r
        JOIN inventory AS i ON r.inventory_id = i.inventory_id
        JOIN film AS f ON i.film_id = f.film_id
        WHERE f.title = 'SPARTACUS CHEAPER'
    )
ORDER BY a.last_name;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’

SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Nombre actores"
FROM actor AS a
WHERE NOT EXISTS (
    SELECT 1
    FROM film_actor AS fa
    JOIN film AS f ON fa.film_id = f.film_id
    JOIN film_category AS fc ON f.film_id = fc.film_id
    JOIN category AS c ON fc.category_id = c.category_id
    WHERE a.actor_id = fa.actor_id AND c.name = 'Music'
);

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días

SELECT title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE EXTRACT(DAY FROM return_date - rental_date) > 8;

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’

SELECT title, c.name
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE name = 'Animation';

/* 59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.*/

SELECT title, length
FROM film
WHERE length = (SELECT length
FROM film
WHERE title = 'DANCING FEVER')
AND title != 'DANCING FEVER'
ORDER BY title;

/*60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.*/

SELECT CONCAT(c.first_name,' ', c.last_name) AS "Nombre cliente", last_name AS "Apellido", COUNT(DISTINCT i.film_id) AS "Número de alquileres"
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on i.inventory_id = r.inventory_id
group by c.customer_id
having count (DISTINCT i.film_id)>=7
ORDER BY last_name;

/*61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.*/

SELECT c.name,COUNT(r.rental_id)
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY c.name;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT COUNT(c.name) , c.name
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE release_year = 2006
GROUP BY c.name;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT CONCAT(First_name,' ', last_name), s.store_id
FROM store s
CROSS JOIN staff;

/* 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.*/

SELECT c.customer_id, CONCAT(first_name,' ',last_name) AS "Nombre cliente", COUNT(r.rental_id) AS "Cantidad de peliculas alquiladas" 
FROM customer c
JOIN rental r on c.customer_id = r.customer_id 
GROUP BY c.customer_id  
ORDER BY c.customer_id;


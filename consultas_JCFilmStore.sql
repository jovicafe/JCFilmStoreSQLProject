--Actualizar las estadísticasa de las tablas
analyze;

--Referencia de la Ruta de la consulta

--C:\Users\jovic\JCFilmStoreSQLProject\consultas.sql

--1. Crea el esquema de la BBDD.
--Ver PARTE I , y .png disponible en el proyecto

--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select f.title as "FilmTitle"
from film f
where f.rating ='R';
	
--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

select a.first_name,a.last_name
from actor a 
where a.actor_id <40 and a.actor_id >30;

--4. Obtén las películas cuyo idioma coincide con el idioma original.
	-- NOTA : VALOR NULL en toda la columna. 
select *
from film f
where f.language_id= f.original_language;

--5. Ordena las películas por duración de forma ascendente.

select *
from film f
order by f.length asc;

--6.Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

	select  a.last_name, a.first_name
	from actor a
	where a.last_name ilike'%allen%'
	

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra
-- la clasificación junto con el recuento.

	-- suponiendo que la clasificación se refiere a rating
	
		select count(distinct film_id) as "TotalFilms", f.rating 
		from film f 
		group by f.rating;
		
--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.


		select f.title, f.length 
		from film f 
		where f.rating = 'PG-13' and f.length >180;
		
--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

	-- buscamos la Varianza pero por referencia la desviación estandar por ayudar a la interpretación
		
		select round(variance(f.replacement_cost),3) as "Varianza",
			round(stddev(f."replacement_cost"),3) as "DesvStandard",
			round(avg(f.replacement_cost),3) as "Promedio"
		from film f;
		
--10.Encuentra la mayor y menor duración de una película de nuestra BBDD.
		
		select min(f.length ), max(f.length )
		from film f;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
		
		select p.rental_id, p.amount,p.payment_date
		from payment p
		where  rental_id =
			(select r.rental_id
			from rental r
			order by r.rental_date desc --ordenado del último al primero
			limit 1 offset 2) -- tercera posición
			;
--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.

		select f.title
		from film f 
		where f.rating <>'NC-17'and f.rating  <> 'G';
		
--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación 
--junto con el promedio de duración.
		
		select f.rating, AVG(f.length )
		from film f
		group by f.rating;
		
--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

		select f.title, f.length
		from film f
		where f.length >180;

--15. ¿Cuánto dinero ha generado en total la empresa?
		select sum(p.amount)
		from payment p;
		
 --16. Muestra los 10 clientes con mayor valor de id.
 
		select *
		from customer c
		order by c.customer_id desc
		limit 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
		select a.actor_id, f.film_id, a.first_name , a.last_name 
		from film_actor f
		inner join actor a
		on f.actor_id =a.actor_id
		where f.film_id = (
			select f2.film_id --f2.title 
			from film f2
			where f2.title ilike 'Egg Igby');
			
--18. Selecciona todos los nombres de las películas únicos.
		select distinct  f.title
		from film f;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
		
	--Alternativa1:
		with ComedyCategory as(
			select c."category_id"
			from category c
			where c."name" ilike '%comed%' )
			
		select f.title, f.film_id--, f.length
		from film f
		where 
			f.length  > 180 and f.film_id in (
				select f2.film_id
				from film_category f2
				where f2.category_id  in 
				(select ComedyCategory."category_id" from ComedyCategory)
				);
		
		--Alternativa 2:
		with ComedyCategory as (
			  select c."category_id"
			  from category c
			  where c."name" ilike '%comed%'
			)
			select f.title, f.film_id
			from film f
			where f.length > 180 and
				exists(
			    select 1
			    from film_category fc
			    inner join ComedyCategory cc 
			    on  fc."category_id"= cc."category_id"
			    where fc.film_id = f.film_id);
	
	
		 
--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos 
--y muestra el nombre de la categoría junto con el promedio de duración.

	with promedio_lenght_categoria as (
			select f2.category_id, AVG(f.length) as promedio_lenght
			from film f
			inner join film_category f2
			on f.film_id=f2.film_id
			group by f2.category_id)
			
		select c."name" as "CategoryName", round(plc.promedio_lenght,2) as "AvgLenght"
		from promedio_lenght_categoria plc
		inner join category c
		on plc.category_id = c.category_id
		where round(plc.promedio_lenght,2)>110;
		
--21. ¿Cuál es la media de duración del alquiler de las películas?
	
		select justify_interval(AVG(return_date - rental_date)) as "RentalAVG"
		from rental r ;
		-- cuidado resultado postgres indica 24h 26 minutos que es 1 dias más 
			
--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
		select datos.name_lastname, count(datos.name_lastname) as "num_actors"
		from (select concat(first_name,' ',last_name) as name_lastname 
		from actor a) as datos
		group by datos.name_lastname 
		order by num_actors desc
		
		-- el listado tiene duplicados para Susan Davis 
		/*select distinct  concat(first_name,' ',last_name) as Name_Lastname 
		from actor a;
		
		select concat(first_name,' ',last_name) as Name_Lastname 
		from actor a;
		
		select datos.name_lastname, count(datos.name_lastname) as "num_actors",datos.actor_id 
		from (select concat(first_name,' ',last_name) as name_lastname, a.actor_id 
		from actor a) as datos
		group by datos.name_lastname,datos.actor_id 
		order by num_actors desc;*/
		
--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
		
		select rental_date::date, count(rental_date::date) as total_rental_byday
		from rental r
		group by r.rental_date::date
		order by count(rental_date::date) desc

--24. Encuentra las películas con una duración superior al promedio.
		
		with length_average as(
			select AVG(f.length) as avg_length
			from film f 
			)
		select f.film_id, f.title, f.length
		from film f
		where f.length > (select * from length_average)
		order by f.length;

--25. Averigua el número de alquileres registrados por mes.
		
		with rentals as (
		select to_char(r.rental_date ::date,'YYYY/MM') as year_month,count(to_char(r.rental_date::date,'YYYY/MM')) as total_alquileres
		from rental r 
		group by r.rental_date::date
		order by r.rental_date::date desc
		)
		select rl.year_month, sum(rl.total_alquileres) as total_rentals_bymonth
		from rentals rl
		group by rl.year_month;
		

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
		
		select avg(p.amount),stddev(p.amount), variance(p.amount)
		from payment p;
		
--27. ¿Qué películas se alquilan por encima del precio medio?

		with inventory_film as(
			select f.film_id, i.inventory_id, f.title
			from inventory i
			inner join film f
			on i.film_id = f.film_id
			),
		highvalue_rental_inventory_ids as(
		select distinct p.rental_id, r.inventory_id,p.amount
		from payment p
		inner join rental r
		on p.rental_id=r.rental_id
		where p.amount > (
			select avg(p.amount)
			from payment p)
		--order by p.amount desc
			)
		select distinct ifl.film_id, ifl.title
		from inventory_film ifl
		where ifl.inventory_id in (
			select hri.inventory_id
			from highvalue_rental_inventory_ids hri)
			;
		
			
--28. Muestra el id de los actores que hayan participado en más de 40 películas.
		
		select f.actor_id, count (distinct f.film_id ) as total_films
		from film_actor f
		group by f.actor_id
		having count (distinct f.film_id ) >40
		

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
		
		select  i.film_id, count(distinct i.inventory_id) as total_inventario
		from inventory i
		right join film f
		on i.film_id= f.film_id
		group by i.film_id
		order by total_inventario asc;
		
		
--30. Obtener los actores y el número de películas en las que ha actuado.
		select f.actor_id, count (distinct f.film_id ) as total_films, a.first_name,a.last_name
		from film_actor f
		inner join actor a
		on f.actor_id=a.actor_id
		group by f.actor_id,a.first_name, a.last_name;
		
--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas
-- películas no tienen actores asociados.
		
		with actordetails_film as(
		select f.actor_id,f.film_id,a.first_name,a.last_name
		from  film_actor f
		inner join actor a
		on f.actor_id=a.actor_id)
			
		select f.film_id, f.title,adf.actor_id,adf.first_name,adf.last_name
		from film f
		left join actordetails_film adf
		on f.film_id=adf.film_id
		order by f.film_id ;
		
		--revisamos las películas sin actores vinculados de la lista 
		/*with films_actorslinked as (--listado de peliculas incluidas en listado de actores
		select f.film_id 
		from film_actor f
		)--,
		--allfilm_ids as(--listado de films
		--select fm.film_id
		--from film fm)
		select *
		from film f
		where not exists(
			select fal.film_id
			from films_actorslinked fal
			where fal.film_id=f.film_id)
		
		
		
		
		-- actores que tienen peliculas asociadas. 
		select a.actor_id, a.first_name,a.last_name
		from actor a
		where exists (
			select 1
			from film_actor f
			where a.actor_id=f.actor_id )
		
		select *
		from film f
		where exists
		
		*/
		
		
--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos
-- actores no han actuado en ninguna película.
	
	with filmdetails_actor as(
		select f.actor_id,f.film_id,f2.title
		from  film_actor f
		inner join film f2 
		on f.film_id =f2.film_id)
		
	select *
	from actor a
	left join filmdetails_actor fda
	on a.actor_id = fda.actor_id
		
--33. Obtener todas las películas que tenemos y todos los registros de alquiler.		

	select f.film_id, f.title, i.inventory_id, i.store_id,r.rental_id
	from inventory i
	left join film f
	on i.film_id=f.film_id
	left join rental r
	on i.inventory_id= r.inventory_id;
	
	
34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

	Select p.customer_id,sum(p.amount) as total_amount
	from payment p
	group by p.customer_id
	order by  total_amount desc
	limit 5;
	
35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

	select a.actor_id,a.first_name, a.last_name
	from actor a
	where a.first_name ilike 'Johnny';

36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido.

	select a.first_name as "Nombre", a.last_name as "Apellido"
	from actor a ;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
	
	select min(a.actor_id) as lower_actorid, max(a.actor_id) as higher_actorid
	from actor a;
		
	
--38. Cuenta cuántos actores hay en la tabla “actor”.
	select count(distinct a.actor_id)
	from actor a
	
--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
	
	select *
	from actor a
	order by a.last_name asc;
	
--40. Selecciona las primeras 5 películas de la tabla “film”.
	
	select *
	from film f
	limit 5;
	
--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo 
--nombre. ¿Cuál es el nombre más repetido?
	
 	select a.first_name , count(distinct a.actor_id) as total_actors
 	from actor a
 	group by a.first_name
 	order by count(distinct a.actor_id) desc;
 	
--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
 	
 		select r.rental_id ,r.rental_date ,c.customer_id, concat(c.first_name,' ',c.last_name ) as customer
 		from rental r
 		left join customer c
 		on r.customer_id =c.customer_id;
 			
 	
--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que 
--no tienen alquileres.
 		
 		select r.rental_id ,r.rental_date ,c.customer_id, concat(c.first_name,' ',c.last_name ) as customer
 		from customer c
 		left join rental r
 		on c.customer_id=r.customer_id;
 		
--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta?
-- ¿Por qué? Deja después de la consulta la contestación.
	 	
 		select *
 		from film f
 		cross join category c;
 		
 		/*no aporta valor a esta consulta, porque cada película tiene una categoría, por lo que
 		estariamos creando registros de valores que no se usarian*/
 		
--45. Encuentra los actores que han participado en películas de la categoría 'Action'.
 		
 		
 		with category_film as(
 			select f.category_id, f.film_id,c."name"
 			from film_category f 
 			left join category c
 			on f.category_id=c.category_id 
 			)
 			
	 		select f.actor_id,f,f.film_id 
	 		from film_actor f
	 		where f.film_id  in(
	 			select cf.film_id--, cf.category_id
	 			from category_film cf
	 			where cf.name ilike 'action');

--46. Encuentra todos los actores que no han participado en películas.

		select a.actor_id 
		from actor a
		where a.actor_id not in(
			select fa.actor_id
			from film_actor fa
			where fa.actor_id is not null);
			
		--or 
		
		select a.actor_id, a.first_name, a.last_name
		from actor a
		left join film_actor fa 
		on fa.actor_id = a.actor_id
		where fa.actor_id is null;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
	
		select a.actor_id,a.first_name,count(distinct f.film_id ) as total_films
		from actor a
		left join film_actor f
		on a.actor_id=f.actor_id
		group by a.actor_id;
	
	
--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas
-- en las que han participado.
		
		create view actor_num_peliculas as
			select a.actor_id,a.first_name,count(distinct f.film_id ) as total_films
			from actor a
			left join film_actor f
			on a.actor_id=f.actor_id
			group by a.actor_id;
		

--49. Calcula el número total de alquileres realizados por cada cliente.
			
		select r.customer_id, count(distinct r.rental_id)
		from rental r
		group by r.customer_id;
		
--50. Calcula la duración total de las películas en la categoría 'Action'.
		with category_filmsname as(
			select f.category_id, f.film_id,c.name 
			from film_category f
			left join category c
			on f.category_id=c.category_id)
			
			select cf.name, sum(f.length)
			from film f
			left join category_filmsname cf
			on f.film_id=cf.film_id
			where cf.name ilike '%Action%'
			group by cf.name;

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total
-- de alquileres por cliente.
			
		create temp table cliente_rentas_temporal as
		select r.customer_id, count(distinct r.rental_id) as total_rentals
		from rental r
		group by r.customer_id;

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
--películas que han sido alquiladas al menos 10 veces.
		
		create temp table peliculas_alquiladas as
		select i.film_id, count(r.rental_id) as Total_rentals2
		from rental r
		left join inventory i
		on r.inventory_id=i.inventory_id
		group by i.film_id
		having count(r.rental_id)>=10;
		
		
--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre
-- ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por 
--título de película.
		
	select f.title as film_title,r.return_date, r.customer_id
	from rental r
	left join inventory i 
	on r.inventory_id=i.inventory_id
	left join film f
	on i.film_id = f.film_id
	where r.return_date is null and r.customer_id in
		(select c.customer_id
		from customer c
		where concat(c.first_name,' ',c.last_name) ilike '%Tammy Sanders')
	order by f.title asc;
		
--54. Encuentra los nombres de los actores que han actuado en al menos una  película que pertenece
-- a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
	
	with scifi_films as(
	select f.film_id
	from category c
	join film_category f
	on c.category_id=f.category_id
	where c.name ilike '%sci-fi%')
	
	
	select a.first_name, a.last_name
	from actor a
	where exists(
		select 1
		from scifi_films sf
		left join film_actor fa
		on fa.film_id=sf.film_id
		where fa.actor_id=a.actor_id)
	order by a.last_name asc;
		

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron
-- después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados
--alfabéticamente por apellido.
		with films_filtered as (
		select r.rental_id,i.inventory_id,i.film_id 
		from rental r
		join inventory i
		on r.inventory_id =i.inventory_id
		where r.rental_date >
			(select min(r2.rental_date)
			from rental r2
			left join inventory i
			on r2.inventory_id =i.inventory_id 
			left join film f
			on i.film_id =f.film_id
			where f.title ilike '%Spartacus Cheaper%'
				))
		
				
		select a.first_name, a.last_name
		from actor a
		where a.actor_id in(
			select f.actor_id
			from film_actor f
			where f.film_id in (
				select ff.film_id from films_filtered ff)
				)
		order by a.last_name asc;

		
--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la 
--categoría ‘Music’.
		
	with music_films as(
	select f.film_id
	from category c
	join film_category f
	on c.category_id=f.category_id
	where c.name ilike '%music%')
	
	
	select a.first_name, a.last_name
	from actor a
	where not exists(
		select 1
		from music_films mf
		left join film_actor fa
		on mf.film_id=fa.film_id
		where fa.actor_id=a.actor_id);
		

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
	
		select f.title
		from film f
		where f.film_id in(
			select i.film_id
			from inventory i
			where exists(
				select 1
				from rental r 
				where (r.return_date::date -r.rental_date::date) > 8 and
				r.inventory_id=i.inventory_id
				));
			
	
--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
			select f.title
			from film f
			where exists(
				select f2.film_id
				from film_category f2
				inner join category c
				on f2.category_id =c.category_id 
				where f2.film_id =f.film_id and c."name" ='Animation');
				
--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el
--título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
		
			select f.title
			from film f
			where f.length = (
				select f.length
				from film f
				where f.title ilike 'Dancing Fever')-- no hay 'Dancing Fever'
			order by f.title asc;
		
--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
--Ordena los resultados alfabéticamente por apellido.
		
			select r.customer_id,c.first_name, c.last_name ,count(distinct i.film_id ) as totalrented_diffilms
			from rental r
			left join customer c
			on r.customer_id =c.customer_id
			left join inventory i 
			on r.inventory_id =i.inventory_id
			group by r.customer_id,c.first_name,c.last_name
			having count(distinct i.film_id )>=7
			order by c.last_name;
			
		
		
--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la
-- categoría junto con el recuento de alquileres.
		
		select c."name",count(distinct i.film_id) as total_films,count(r.rental_id) as total_rentals
		from rental r
		left join inventory i
		on r.inventory_id =i.inventory_id 
		left join film_category fc
		on i.film_id=fc.film_id
		left join category c 
		on fc.category_id =c.category_id
		group by c."name";
				
			/*
			
			select count( distinct film_id)
			from film f
			*/
			
		
--62. Encuentra el número de películas por categoría estrenadas en 2006.
			select fc.category_id,c.name ,f.release_year, count(distinct f.film_id)
			from film f
			left join film_category fc
			on f.film_id =fc.film_id
			left join category c 
			on fc.category_id =c.category_id
			group by fc.category_id, c.name, f.release_year
			having f.release_year=2006;
		
		
--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
			select *
			from staff s
			cross join store j;
			
			

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID 
--del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
		
			select r.customer_id,count(distinct r.rental_id) as rentals_bycustomer,c.first_name, c.last_name
			from rental r
			left join customer c
			on r.customer_id=c.customer_id
			group by r.customer_id, c.first_name, c.last_name;
			
			

		
		
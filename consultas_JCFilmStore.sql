--Actualizar las estadísticasa de las tablas
analyze;

--Referencia de la Ruta de la consulta

--C:\Users\jovic\JCFilmStoreSQLProject\consultas.sql

--1. Crea el esquema de la BBDD.
--Ver PARTE I , y .png disponible en el proyecto

--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select f.title
from film f
where f.rating ='R'

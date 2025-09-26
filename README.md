# JCFilmStoreSQLProject
SQL test project to apply different queries to find relevant info for given DB.
//
Parte I: Configuracion Inicio de proyecto:

Paso 1: creamos proyecto en GIthub

"New repository" con nombre de jovicafe/JCFilmStoreSQLProyect

Indicamos que se cree un Readme tambien. 

Luego vamso a local y clonamos el repositorio desde github
Microsoft Windows [Versión 10.0.19045.6216]
(c) Microsoft Corporation. Todos los derechos reservados.

C:\Users\jovic>git clone https://github.com/jovicafe/JCFilmStoreSQLProject
Cloning into 'JCFilmStoreSQLProject'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (3/3), done.

Paso 2: Se crea el diagrama de la base de datos en formato .png  y luego se mueve a la carpeta del proyecto.

C:\Users\jovic\JCFilmStoreSQLProject>move "C:\Users\jovic\OneDrive\the power24-25\SQL\FilmStore - publicSchema.png" "esquema_BBDD.png"

Paso 3: Se crea fichero para almacenar las consultas 
C:\Users\jovic\JCFilmStoreSQLProject>echo. > consultas.sql

Paso 4: Comprobamos el directorio 
C:\Users\jovic\JCFilmStoreSQLProject>dir
 El volumen de la unidad C es Windows
 El número de serie del volumen es: 8EC2-36D1

 Directorio de C:\Users\jovic\JCFilmStoreSQLProject

01/09/2025  14:44    <DIR>          .
01/09/2025  14:44    <DIR>          ..
01/09/2025  14:24                 3 consultas.sql
01/09/2025  14:24           142.665 esquema_BBDD.png
01/09/2025  13:58               106 README.md
               3 archivos        142.774 bytes
               2 dirs  215.187.173.376 bytes libres


Paso 5: Validamos que cambios se hayan sincronizado

C:\Users\jovic\JCFilmStoreSQLProject>git status
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        consultas.sql
        esquema_BBDD.png

nothing added to commit but untracked files present (use "git add" to track)

C:\Users\jovic\JCFilmStoreSQLProject>git add .

C:\Users\jovic\JCFilmStoreSQLProject>git status
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   consultas.sql
        new file:   esquema_BBDD.png


C:\Users\jovic\JCFilmStoreSQLProject>git commit -m "folder setup"
[main 08f1639] folder setup
 2 files changed, 1 insertion(+)
 create mode 100644 consultas.sql
 create mode 100644 esquema_BBDD.png

C:\Users\jovic\JCFilmStoreSQLProject>git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (4/4), 117.88 KiB | 16.84 MiB/s, done.
Total 4 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To https://github.com/jovicafe/JCFilmStoreSQLProject
   51c703e..08f1639  main -> main

C:\Users\jovic\JCFilmStoreSQLProject>



Paso 6:  Actualiza  estadísticas de la tabla 

Sql:
Analyze; 



Paso 7: actualizar el nombre del archivo de SQL para las consultas

C:\Users\jovic\JCFilmStoreSQLProject>git pull
Already up to date.

C:\Users\jovic\JCFilmStoreSQLProject>git mv "consultas.sql" "consultas_JCFilmStore.sql"

C:\Users\jovic\JCFilmStoreSQLProject>git commit -m "Renombra consultas.sql a consultas_proyecto.sql"
[main 1cd89f5] Renombra consultas.sql a consultas_proyecto.sql
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename consultas.sql => consultas_JCFilmStore.sql (100%)

C:\Users\jovic\JCFilmStoreSQLProject>git commit -m "Renombra consultas.sql a consultas_JCFilmStore.sql"
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean

C:\Users\jovic\JCFilmStoreSQLProject>git push origin main
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 4 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 255 bytes | 255.00 KiB/s, done.
Total 2 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/jovicafe/JCFilmStoreSQLProject
   08f1639..1cd89f5  main -> main

Parte II :  DataProject -LógicaConsultasSQL 

1. Crea el esquema de la BBDD.
    Ver PARTE I , y .png disponible en el proyecto

2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’.
    Según la tabla "Film", la única columna que cuenta con clasificación es 'Rating'
    
    en 194 películas con esa clasificación. 

3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
    Son 9 actores que tienen un ID mayor de 30 y menor que 40. 

4. Obtén las películas cuyo idioma coincide con el idioma original.
    El lenguaje original, se entiende que corresponde con la columna "
    En la DB cargada se indica en los registros como valor "NULL".
    EG: 
        Insert into film
         (film_id,title,description,release_year,language_id,original_language_id,rental_duration,rental_rate,length,replacement_cost,rating,special_features,last_update)
        Values
         ('7','AIRPLANE SIERRA','A Touching Saga of a Hunter And a Butler who must Discover a Butler in A Jet Boat','2006','1',NULL,'6','4.99','62','28.99','PG-13',string_to_array('Trailers,Deleted Scenes',','),'2006-02-15 05:03:42.000')


5. Ordena las películas por duración de forma ascendente.
    Ordenadas de manera ascendente,  la más corta con 46 minutos  (KWAI HOMEWARD)  y la que más duración tiene es de  185 min (POND SEATTLE).
    
6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido.
    
    Son estos tres actores quienes tienen apellido que contiene Allen
    ALLEN	CUBA
    ALLEN	KIM
    ALLEN	MERYL
    
7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
    Estos serían los totales de películas por cada categoría. 
    Total     Clasificación
    178	G
    194	PG
    223	PG-13
    195	R
    210	NC-17
    

8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
    Son 9 películas con esa duración
    Title                                  Length
    CHICAGO NORTH	185
    CONSPIRACY SPIRIT	184
    FRONTIER CABIN	183
    GANGS PRIDE	185
    HOTEL HAPPINESS	181
    JACKET FRISCO	181
    POND SEATTLE	185
    REDS POCUS	182
    THEORY MERMAID	184
    

9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
     existe un varianza de 36.613 unidades cuadradas. Por referencia sabemos que tiene una desviación estandar de 6  sobre la media que es 19,9.

10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
    Las películas de la DB duran min 46 minutos y max 185minutos. 
    
11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
        Costo cero , con id 11676 y fue en la fecha 2006-02-14 15:16:03.000

    
12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
        Tenemos 612 títulos de películas que cumplen esa condición

13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.
        Son  5 categorias  y estas son su duración promedio
        NC-17	113.2285714285714286
        G	111.0505617977528090
        R	118.6615384615384615
        PG-13	120.4439461883408072
        PG	112.0051546391752577
        

14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
    Hay 39 títulos de películas con duración mayor a 180 minutos. 
    
15. ¿Cuánto dinero ha generado en total la empresa?
        El total de los "mount" de Payment son 67416.51
        
16. Muestra los 10 clientes con mayor valor de id.
        Estos son los 10 clientes
        599	2	AUSTIN	CINTRON
        598	1	WADE	DELVALLE
        597	1	FREDDIE	DUGGAN
        596	1	ENRIQUE	FORSYTHE
        595	1	TERRENCE	GUNDERSON
        594	1	EDUARDO	HIATT
        593	2	RENE	MCALISTER
        592	1	TERRANCE	ROUSH
        591	1	KENT	ARSENAULT
        590	2	SETH	HANNON
        
        

17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
    Son 5 actores  que participan en la película EGG IGBY. 
        Actor ID  Film ID  Firt Name  Last Name
        20	274	LUCILLE	TRACY
        38	274	TOM	MCKELLEN
        50	274	NATALIE	HOPKINS
        154	274	MERYL	GIBSON
        162	274	OPRAH	KILMER

18. Selecciona todos los nombres de las películas únicos.
    Tenemos 1000 nombres de películas con nombres distintos. 

19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.

    Buscamos el Category Id para Comedias , que es 5. 
    Validamos que el category_id de film_category sea 5 para generar un listado de Film_id
    Finalmente validamos la  tabla film donde su duración sea mayor a 180min y se encuentre su id en el listado anterior. 
    
    Tenemos 3 pelñiculas que cumplen con esa condición. 
    SATURN NAME	765
    CONTROL ANTHEM	182
    SEARCHERS WAIT	774
    

20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

    CategoryName AvgName
    Action	111.61
    Animation	111.02
    Classics	111.67
    Comedy	115.83
    Drama	120.84
    Family	114.78
    Foreign	121.70
    Games	127.84
    Horror	112.48
    Music	113.65
    New	111.13
    Sports	128.20
    Travel	113.32
    
21. ¿Cuál es la media de duración del alquiler de las películas?

    Media de duración  24:36:28.541706. Postgres aplica este tipo de cálculo sin redondear a veces a dias las 24h. 
    Aplicamos  justify_interval para corregir  a 5 days 00:36:28.541706.
    
22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
    Columna creada con el nombre : name_lastname obtenemos una lista de 200 registros
    Hay que tener en cuenta que  uno de ellos 'Susan Davis' se repite 2 veces pero cuentan con id diferente 110 y 101.
    
    
23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
    Agrupados por dia/mes/año teniendo  mayor cantidad de alquileres el 31 de Julio de 2005 con 679 alquileres, y 
    El 24 de mayo con solo 8 alquileres.

24. Encuentra las películas con una duración superior al promedio.
    Hay 489 películas mayores a la media de duración  de 115,272
    
25. Averigua el número de alquileres registrados por mes.
    Estos son los alquileres registrados por mes
        2005/05	1156
        2005/08	5686
        2005/07	6709
        2005/06	2311
        2006/02	182
    
26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

    Promedio 4.2006673312979002
    Stddev	2.3629938536099744	
    Variance 5.5837399521985169

27. ¿Qué películas se alquilan por encima del precio medio?
    Siento el precio medio de 4,20

28. Muestra el id de los actores que hayan participado en más de 40 películas.
    Estos dos  id de actores 
    102	41
    107	42
    

29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
    Lista de todas las películas y conteo de total de id´s de inventario por cada pelicula
    
30. Obtener los actores y el número de películas en las que ha actuado.
     Con las dos tablas film actor y actor para luego  agregar nombre y apellido del actor. 
    
31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

    Obtenemos el listado revisando antes que si existen  3 peliculas en las que no hay actores vinculados.
        257	DRUMLINE CYCLONE
        323	FLIGHT LIES
        803	SLACKER LIAISONS
    
    Tenemos un left join priorizando la tabla peliculas. 


32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
    Realizamos un left join con la tabla actores, con una CTE  dodne unimos  film_actor y film , para tener los detalles de la película como el título. 
    
33. Obtener todas las películas que tenemos y todos los registros de alquiler.
    Anidados con left joins las tablas inventory, film y rental teniendo 16k registros igual al total de rentals. 

34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros
    Estos son los id´s de clientes que más dinero se han gastado 
    526	221.55
    148	216.54
    144	195.58
    137	194.61
    178	194.61
    

35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

    Estos son los dos actores cuyo primer nombre es Johnny, sin embargo  sus nombre estan en mayúsculas 
    5	JOHNNY	LOLLOBRIGIDA
    40	JOHNNY	CAGE
    

36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
    Renombrada, considerando la mayúscula al inicio de cada nombre de columna
    
37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
 
    Estos son los id´s : 1 y 200
    
38. Cuenta cuántos actores hay en la tabla “actor”.
    Hay 200 
    
39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
    Una vez ordenados el primer apellido es AKROYD  y el último ZELLWEGER
    
40. Selecciona las primeras 5 películas de la tabla “film”.
    1	ACADEMY DINOSAUR
    2	ACE GOLDFINGER
    3	ADAPTATION HOLES
    4	AFFAIR PREJUDICE
    5	AFRICAN EGG
    

41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
    Son 3 nombres que se repiten 4 veces 
    PENELOPE	4
    KENNETH	4
    JULIA	4


42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

    Left join de rental y customer  tables
    
43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
    
    Left join de customer con rental, mantenineod todos los customers independientemente si hay algún rental vinculado,. 
    
44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
    El Cross Join de todos contra todos, no aporta valor a la consulta 

45. Encuentra los actores que han participado en películas de la categoría 'Action'.
    CTE para obtener un listado de categorías con su nombres
    Luego una subconsulta para tener un listado de las los id´s de peliculas donde su nombre de categoría es similar a 'action'

46. Encuentra todos los actores que no han participado en películas.
    No encontramos actores que no hayan participado en películas 
    
47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
    Contamos total ids de películas para cada uno de los actores agrupados por Ids de actor
    
48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

    Vista creada con misma query que la  pregunta 47
    
49. Calcula el número total de alquileres realizados por cada cliente.
    Conteo de rentals_ids por cada customer_id
    
50. Calcula la duración total de las películas en la categoría 'Action'.
    7143 total de duración de todas las películas 'Action' 

51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
        Updated Rows	599
        Execute time	0.027s
        Start time	Fri Sep 26 11:43:38 CEST 2025
        Finish time	Fri Sep 26 11:43:38 CEST 2025
        Query	create temp table cliente_rentas_temporal as
                    select r.customer_id, count(distinct r.rental_id) as total_rentals
                    from rental r
                    group by r.customer_id
        

52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
        Updated Rows	792
        Execute time	0.021s
        Start time	Fri Sep 26 11:44:36 CEST 2025
        Finish time	Fri Sep 26 11:44:36 CEST 2025
        Query	create temp table peliculas_alquiladas as
                    select i.film_id, count(r.rental_id) as Total_rentals2
                    from rental r
                    left join inventory i
                    on r.inventory_id=i.inventory_id
                    group by i.film_id
                    having count(r.rental_id)>=10
        

53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

    Son 3 películas que no se han devuelto y han sido alquiladas por Tammy Sanders con Id cliente 75
    LUST LOCK		75
    SLEEPY JAPANESE	75
    TROUBLE DATE		75
    

54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
    Tenemos 167  nombres de actores. ( con sus apellidos conrrespondientes).


55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película  ‘Spartacus Cheaper’se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

    Creamos una cte  para conocer las películas que cumplen con la condición y luego filtramos todos los actores que participan en ese listado de películas. 

56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

    Hay 56 actores que no han actuado en categoría music. 
    
57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

    Consideramos para indicar que dura más de 8 días solo el día de devolución - día de alquiler sin considerar horas o minutos. 
    Los no devueltos están excluidos de la condición, al no tener claro el número de días de duración del alquiler. 

58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
    
    Tenemos 66 peliculas con esta categoría. 

59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
    Se busca similar a 'Dancing Fever' ya que el titilo está en mayúsculas 
    Duración de 144 min y 8 películas que también tienen esa duración. 
    DANCING FEVER
    FACTORY DRAGON
    LAMBS CINCINATTI
    PACIFIC AMISTAD
    PRESIDENT BANG
    STRICTLY SCARFACE
    TOWERS HURRICANE
    VIRTUAL SPOILERS
    

60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
    Son 599 clientes que han alquilado al menos 7 películas diferentes. 
    

61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
    Estos son los totales de películas alquiladas por categoría , y el total de alquileres.
    Action	61	1112
    Animation	64	1166
    Children	58	945
    Classics	54	939
    Comedy	56	941
    Documentary	63	1050
    Drama	61	1060
    Family	67	1096
    Foreign	67	1033
    Games	58	969
    Horror	53	846
    Music	51	830
    New	60	940
    Sci-Fi	59	1101
    Sports	73	1179
    Travel	53	837
    

62. Encuentra el número de películas por categoría estrenadas en 2006. 
    Todas las películas tienen release year 2006. 
        

63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos. 
    Un crosso join entre las dos tablas de staff y stores.

64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

    Contamos los rental ID´s  por cada customer Id
//
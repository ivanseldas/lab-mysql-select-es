/*
QUERY 1: ¿Quién ha publicado qué y dónde?
En este desafío escribirás una consulta SELECT de MySQL que una varias tablas para descubrir qué títulos 
ha publicado cada autor en qué editoriales. Tu salida debe tener al menos las siguientes columnas:
	AUTHOR ID - el ID del autor
	LAST NAME - apellido del autor
	FIRST NAME - nombre del autor
	TITLE - nombre del título publicado
	PUBLISHER - nombre de la editorial donde se publicó el título
*/

SELECT 
	authors.au_id AS 'AUTHOR ID',
	authors.au_lname AS 'LAST NAME',
	authors.au_fname AS 'FIRST NAME',
	titles.title AS 'TITLE',
    publishers.pub_name AS 'PUBLISHER'
FROM 
	authors 
INNER JOIN 
	titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN
	titles ON titleauthor.title_id = titles.title_id
INNER JOIN
	publishers ON titles.pub_id = publishers.pub_id 
ORDER BY
	authors.au_id;

 /*
 QUERY 2: ¿Quién ha publicado cuántos y dónde?
 Partiendo de tu solución en el Desafío 1, consulta cuántos títulos ha publicado cada autor en cada editorial.
 */
SELECT 
    authors.au_id AS 'AUTHOR ID',
    authors.au_lname AS 'LAST NAME',
    authors.au_fname AS 'FIRST NAME',
    publishers.pub_name AS 'PUBLISHER',
    COUNT(titles.title_id) AS 'TITLE COUNT'
FROM 
    authors 
INNER JOIN 
    titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN
    titles ON titleauthor.title_id = titles.title_id
INNER JOIN
    publishers ON titles.pub_id = publishers.pub_id 
GROUP BY
	authors.au_id,
    publishers.pub_name
ORDER BY
    authors.au_id DESC;
    
/*
QUERY 3 : Autores mas vendidos
¿Quiénes son los 3 principales autores que han vendido el mayor número de títulos? Escribe una consulta para averiguarlo.
Tu salida debería tener las siguientes columnas:
	AUTHOR ID - el ID del autor
	LAST NAME - apellido del autor
	FIRST NAME - nombre del autor
	TOTAL - número total de títulos vendidos de este autor
Tu salida debería estar ordenada basándose en TOTAL de mayor a menor.
Solo muestra los 3 mejores autores en ventas.
*/

SELECT
	authors.au_id AS 'AUTHOR ID',
	authors.au_lname AS 'LAST NAME',
	authors.au_fname AS 'FIRST NAME',
    SUM(sales.qty) AS 'TOTAL'
FROM
	authors
INNER JOIN
	titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN
	sales ON titleauthor.title_id = sales.title_id
GROUP BY
	authors.au_id
ORDER BY TOTAL DESC
LIMIT 3;

/*
QUERY 4 = Ranking de Autores Más Vendidos
Ahora modifica tu solución en el Desafío 3 para que la salida muestre a todos los 23 autores en lugar de solo los 3 principales. 
Ten en cuenta que los autores que han vendido 0 títulos también deben aparecer en tu salida 
(idealmente muestra 0 en lugar de NULL como TOTAL). También ordena tus resultados basándose en TOTAL de mayor a menor.
 */
 SELECT
	authors.au_id AS 'AUTHOR ID',
	authors.au_lname AS 'LAST NAME',
	authors.au_fname AS 'FIRST NAME',
    COALESCE(SUM(sales.qty), 0) AS 'TOTAL'
FROM
	authors
LEFT JOIN
	titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN
	sales ON titleauthor.title_id = sales.title_id
GROUP BY
	authors.au_id
ORDER BY 
	TOTAL DESC;
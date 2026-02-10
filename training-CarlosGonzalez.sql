--1 Muestra las competiciones celebradas en Estados Unidos.

 SELECT nombre, fecha_inicio, fecha_fin, nombre_pais 
    FROM competicion c 
        INNER JOIN nacionalidad n ON c.codpais = n.codpais 
    WHERE nombre_pais = 'Estados Unidos';


--2 Muestra los eventos(pruebas realizadas) en la competición del año 2023, junto
--  con el nombre de la disciplina y el nombre de la competición. Ordémalos por la
--  distancia de la disciplina.

SELECT e.id 'evento', d.nombre 'disciplina' , c.nombre 'competicion'
    FROM eventos e
        INNER JOIN competicion c ON e.id_competicion = c.id
        INNER JOIN disciplinas d ON e.id_disciplina = d.id
    WHERE YEAR(c.fecha_inicio) = 2023
    ORDER BY  d.distancia ASC;


--3 Cuántas atletas hay de cada país. Quédate sólo con los países que tienes dos
--  atletas o más. Ordénalos por cantidad

SELECT n.nombre_pais 'nombre', pais 'codigo', COUNT(*) 'cantidad atletas'
    FROM atletas a
        INNER JOIN nacionalidad n ON a.pais = n.codpais
    GROUP BY pais
        HAVING COUNT(*) >=2
    ORDER BY COUNT(*) DESC;


--4 Muestra para cada carrera de los mundiales del 2023 el mejor tiempo y el peor
--  tiempo

SELECT d.id, d.nombre , MIN(r.resultado)'mejor_tiempo', MAX(r.resultado)'peor_tiempo'
    
    FROM disciplinas d 
        INNER JOIN eventos e ON e.id_disciplina = d.id
        INNER JOIN resultados r ON r.id_evento = e.id
    WHERE YEAR(e.fecha) = 2023
        GROUP BY d.id;
    

--5 Para cada atleta muestra su nombre y su apellido en una única columna, el
-- tiempo obtenido . Descarta aquellos atletas que no tengan tiempo.

SELECT CONCAT(a.nombre, ' ', a.apellido) 'nombre atleta', e.id_competicion, r.puesto, r.resultado
    FROM resultados r
        INNER JOIN atletas a ON r.id_atleta = a.id
        INNER JOIN eventos e ON r.id_evento = e.id
    WHERE r.resultado IS NOT NULL;

--6 Mostrar los nombres de las carreras femeninas de menos de 600 metros.

SELECT nombre 
    FROM disciplinas
    WHERE es_masculina = 0 AND distancia < 600;

--7 Mostrar todas las puntuaciones del atleta Noah Lies en todas las disciplinas
--  donde puede participar(masculinas). Mostrar null si no ha participado en una
--  disciplina. Mostrar los nombres, fechas, lugares y resultados
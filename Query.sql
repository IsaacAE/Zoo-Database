-- Alimentos de tipo semilla y que requieren refigeracion 
-- que son distribuidos en biomas distintos del aviario. 
SELECT * FROM alimento 
	WHERE tipo = 'semilla'
	AND nombre IN (
		SELECT insumo.nombre FROM insumo JOIN distribuir ON insumo.nombre = distribuir.nombre
			WHERE tipobioma != 'aviario' 
			AND  refrigeracion = TRUE
	);

-- Clientes que fueron notificados de un evento con  descuento 
-- mayor a 1 y no asistieron a dicho evento.
SELECT * FROM cliente
	WHERE idcliente NOT IN (
		SELECT notificar.idcliente FROM notificar JOIN asistir ON notificar.idevento = asistir.idevento
			WHERE descuento > '$1.00'::money
	);

--Cuidadores que cuidan aves en bioma distinto de la tundra  y que además su RFC empieza con A,E,I
SELECT *  FROM cuidador
	WHERE (rfc LIKE 'E%'
	OR rfc LIKE 'A%'
	OR rfc LIKE 'I%')
	AND (rfc IN (
		SELECT rfc FROM animal
			WHERE esave = TRUE
			AND tipobioma != 'Tundra'
	));
	
-- Clientes que más han comprados tickets de cada servicio por bioma
SELECT DISTINCT ON (tipobioma, tiposervicio) idcliente, tipobioma, tiposervicio, numtickets FROM (
   	SELECT idcliente, tipobioma, tiposervicio, COUNT(idcliente) AS numtickets FROM ticket
    GROUP BY idcliente, tiposervicio, tipobioma) AS T
ORDER BY
    tipobioma, tiposervicio, numtickets DESC;

-- Aves cuyo peso es mayor a 20 kg, que no están en el aviario y cuyo cuidador es de genero Femenino (F)
SELECT * FROM animal
   	WHERE esave = TRUE
   	AND peso > 20 
   	AND tipobioma != 'aviario'
   	AND rfc IN (
   		SELECT rfc FROM cuidador
   		WHERE genero = 'F'	
   	);
   	
-- Los proveedores cuyo genero es Otro (O) y proveen  medicinas que se distribuyen en el bioma desierto o aviario
SELECT * FROM proveedor
	WHERE genero = 'O'
	AND rfc IN (
		SELECT rfc FROM proveer JOIN distribuir ON proveer.nombre = distribuir.nombre
			WHERE tipobioma = 'desierto' 
			OR tipobioma = 'aviario'
	);
	
-- Veterinarios que tienen unicamente correo y han atendido a animales carnívoros

SELECT * FROM veterinario
	WHERE rfc IN (
		SELECT rfc FROM correoveterinario
    		GROUP BY rfc
    		HAVING COUNT(*) < 2
	) AND rfc IN (
		SELECT atender.rfc FROM atender JOIN animal ON atender.idanimal = animal.idanimal
			WHERE alimentacion = 'carnivoro'
	);
	
-- Animales omnivoros que no son aves, cuyo número de jaula es par y no han sido atendidos 
SELECT * FROM animal
	WHERE numjaula % 2 = 0
	AND esave = FALSE
	AND idanimal NOT IN (
		SELECT idanimal FROM atender 
	);

-- Veterianrios cuyo salario es menor a 10,000 y que trabajen en biomas donde se distribuye
-- al menos dos alimentos de tipo dulce
SELECT * FROM veterinario
	WHERE salario < '$10000.00'::money
	AND rfc IN (
		SELECT rfc FROM trabajar
			WHERE tipobioma IN (
				SELECT tipobioma FROM distribuir
					WHERE nombre IN (
						SELECT nombre FROM alimento
							WHERE tipo = 'dulce'
						)
	    		GROUP BY tipobioma
	    		HAVING COUNT(*) >= 2
			) 
	); 
	
-- Ingresos registrados por mes y año.
SELECT SUM(costounitario - descuento), EXTRACT(YEAR FROM fecha) AS anio, EXTRACT(MONTH FROM fecha) AS mes FROM TICKET
	GROUP BY mes, anio
	ORDER BY anio, mes;
	
-- Los meses que han generado más de 1500
SELECT SUM(costounitario - descuento), EXTRACT(YEAR FROM fecha) AS anio, EXTRACT(MONTH FROM fecha) AS mes FROM TICKET
	GROUP BY mes, anio
	HAVING SUM(costounitario - descuento) > '$1500.00'::money
	ORDER BY anio, mes;
	
-- Eventos que tuviesen al menos 5 asistentes con descuento
SELECT * FROM evento
	WHERE idevento IN (
		SELECT notificar.idevento FROM asistir JOIN notificar ON asistir.idcliente = notificar.idcliente
			GROUP BY notificar.idevento 
			HAVING COUNT(asistir.idevento) > 5
	)
	
-- Nombres de cuidadores tales que existe un proovedor con el mismo nombre pero no un veterinario con tal nombre.
SELECT nombre FROM cuidador
	WHERE nombre IN (
		SELECT nombre FROM proveedor
			WHERE nombre NOT IN (
				SELECT nombre FROM veterinario
			)
	)

-- Eventos cuya asistencia fue de al menos un cuarto de la capaccidad.
SELECT * FROM evento
	WHERE idevento IN (
		SELECT evento.idevento FROM 
			evento JOIN asistir ON evento.idevento = asistir.idevento 
			GROUP BY evento.idevento
			HAVING count(asistir.idcliente) >= capacidad/4
		);
		
-- Nombres de cuidadores, veterinarios o proveedores cuyo numero telefonico empiece en 55 y termine en 04
SELECT nombre FROM veterinario
	WHERE rfc IN (
		SELECT rfc FROM telefonoveterinario
			WHERE telefono::VARCHAR LIKE '55%04'
	)
UNION
SELECT nombre FROM cuidador
	WHERE rfc IN (
		SELECT rfc FROM telefonocuidador
			WHERE telefono::VARCHAR LIKE '55%04'
	)
UNION
SELECT nombre FROM proveedor
	WHERE rfc IN (
		SELECT rfc FROM telefonoproveedor
			WHERE telefono::VARCHAR LIKE '55%04'
	);
	
                    
                   
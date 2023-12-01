-- Dado un rfc y una tabla devuelve el correo de un trabajador correspondiente a esa tabla y rfc si lo hay.
CREATE OR REPLACE PROCEDURE crea_correo(
	rfcP IN VARCHAR(50),
	tabla IN VARCHAR(50),
	correo OUT VARCHAR(50)
) AS $$
DECLARE 
	id_query VARCHAR;
BEGIN
   	IF tabla = 'veterinario' THEN 
   		IF rfcP IN (SELECT rfc FROM veterinario) THEN
   			SELECT nombre INTO id_query FROM veterinario
   				WHERE rfc = rfcP;
   		ELSE 
   			RAISE EXCEPTION 'RFC % no encontrado en %', rfcP, tabla;
   		END IF;
   	ELSE 
	    IF tabla = 'cuidador' THEN 
	   	 	IF rfcP IN (SELECT rfc FROM cuidador) THEN
	   			SELECT nombre INTO id_query FROM cuidador
	   				WHERE rfc = rfcP;
	   		ELSE 
	   			RAISE EXCEPTION 'RFC % no encontrado en %', rfcP, tabla;
	   		END IF;
	   	ELSE 
		    IF tabla = 'proveedor' THEN 
		   		IF rfcP IN (SELECT rfc FROM proveedor) THEN
		   			SELECT nombre INTO id_query FROM proveedor
		   				WHERE rfc = rfcP;
		   		ELSE 
		   			RAISE EXCEPTION 'RFC % no encontrado en %', rfcP, tabla;
		   		END IF;
		   	ELSE
	   			RAISE EXCEPTION 'No existe el trabajador de clase %', tabla;
		   	END IF;
		END IF;
	END IF;
	correo := id_query || rfcP || '@gmail.com'; 
END;
$$
Language plpgsql;

-- Elimina los productos caducados
CREATE OR REPLACE PROCEDURE caducados()
AS $$
BEGIN
    DELETE FROM insumo WHERE caducidad < CURRENT_DATE;
END;
$$
LANGUAGE plpgsql;

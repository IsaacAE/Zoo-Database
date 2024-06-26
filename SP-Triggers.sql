---------------------------------------------- TRIGGERS --------------------------------------------------

-- Trigger para validar el RFC antes de un Veterinario
CREATE OR REPLACE FUNCTION validar_rfc_veterinario()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica si el RFC existe en la tabla Cuidador
    IF EXISTS (SELECT 1 FROM Cuidador WHERE RFC = NEW.RFC) THEN
        RAISE EXCEPTION 'El RFC ya existe en la tabla Cuidador';
    END IF;

    -- Verifica si el RFC existe en la tabla Proveedor
    IF EXISTS (SELECT 1 FROM Proveedor WHERE RFC = NEW.RFC) THEN
        RAISE EXCEPTION 'El RFC ya existe en la tabla Proveedor';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Asociar el trigger a la tabla Veterinario
CREATE or replace TRIGGER validar_rfc_en_veterinario
BEFORE INSERT OR UPDATE ON Veterinario
FOR EACH ROW
EXECUTE FUNCTION validar_rfc_veterinario();


-- Crear el trigger para validar el RFC antes de la inserción en Veterinario
CREATE OR REPLACE FUNCTION validar_rfc_cuidador()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar si el RFC existe en la tabla Cuidador
    IF EXISTS (SELECT 1 FROM Veterinario WHERE RFC = NEW.RFC) THEN
        RAISE EXCEPTION 'El RFC ya existe en la tabla Veterinario';
    END IF;

    -- Verificar si el RFC existe en la tabla Proveedor
    IF EXISTS (SELECT 1 FROM Proveedor WHERE RFC = NEW.RFC) THEN
        RAISE EXCEPTION 'El RFC ya existe en la tabla Proveedor';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Asociar el trigger a la tabla Veterinario
CREATE or replace TRIGGER validar_rfc_en_cuidador
BEFORE INSERT OR UPDATE ON Cuidador
FOR EACH ROW
EXECUTE FUNCTION validar_rfc_cuidador();

-- Crear el trigger para validar el RFC antes de la inserción en Veterinario
CREATE OR REPLACE FUNCTION validar_rfc_proveedor()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar si el RFC existe en la tabla Cuidador
    IF EXISTS (SELECT 1 FROM Veterinario WHERE RFC = NEW.RFC) THEN
        RAISE EXCEPTION 'El RFC ya existe en la tabla Veterinario';
    END IF;

    -- Verificar si el RFC existe en la tabla Proveedor
    IF EXISTS (SELECT 1 FROM Cuidador WHERE RFC = NEW.RFC) THEN
        RAISE EXCEPTION 'El RFC ya existe en la tabla Cuidador';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Asociar el trigger a la tabla Veterinario
CREATE or replace TRIGGER validar_rfc_en_proveedor
BEFORE INSERT OR UPDATE ON Proveedor
FOR EACH ROW
EXECUTE FUNCTION validar_rfc_proveedor();


CREATE OR REPLACE FUNCTION validar_cuidador_unico()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM Animal WHERE RFC = NEW.RFC
    ) THEN
        RAISE EXCEPTION 'El RFC ya existe en la tabla Animal';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE or replace TRIGGER validar_cuidador_animal
BEFORE INSERT OR UPDATE ON Animal
FOR EACH ROW
EXECUTE FUNCTION validar_cuidador_unico();


CREATE OR REPLACE FUNCTION contar_tipos_bioma()
RETURNS TRIGGER AS $$
DECLARE
    num_tipos_bioma INTEGER;
BEGIN
    SELECT COUNT(DISTINCT tipoBioma)
    INTO num_tipos_bioma
    FROM Trabajar
    WHERE RFC = NEW.RFC;

    IF num_tipos_bioma > 2 THEN
        RAISE EXCEPTION 'El RFC tiene más de 2 tipos de bioma distintos en la relación Trabajar';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE or replace TRIGGER verificar_tipos_bioma
AFTER INSERT OR UPDATE ON Trabajar
FOR EACH ROW
EXECUTE FUNCTION contar_tipos_bioma();



CREATE OR REPLACE FUNCTION validar_medicina()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica si el nombre existe en la tabla Alimento
    IF EXISTS (SELECT 1 FROM Alimento WHERE nombre = NEW.nombre) THEN
        RAISE EXCEPTION 'El nombre del insumo ya existe en la tabla Alimento';
    END IF;


    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Asociar el trigger a la tabla Medicina
CREATE or replace TRIGGER validar_insumo_medicina
BEFORE INSERT OR UPDATE ON Medicina
FOR EACH ROW
EXECUTE FUNCTION validar_medicina();


--Trigger para verificar que un insumo que pretende ser alimento no es ya medicina
CREATE OR REPLACE FUNCTION validar_alimento()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica si el nombre existe en la tabla Medicina
    IF EXISTS (SELECT 1 FROM Medicina WHERE nombre = NEW.nombre) THEN
        RAISE EXCEPTION 'El nombre del insumo ya existe en la tabla Alimento';
    END IF;


    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Asociar el trigger a la tabla Alimento
CREATE or replace TRIGGER validar_insumo_alimento
BEFORE INSERT OR UPDATE ON Alimento
FOR EACH ROW
EXECUTE FUNCTION validar_alimento();

CREATE OR REPLACE FUNCTION verificar_mismo_bioma()
RETURNS TRIGGER AS $$
DECLARE
    tipo_bioma_animal VARCHAR;
    conjunto_tipoBioma_trabajar VARCHAR[];
BEGIN
    -- Obtener el tipoBioma de Animal correspondiente al idAnimal en la relación Atender
    SELECT tipoBioma INTO tipo_bioma_animal
    FROM Animal
    WHERE idAnimal = NEW.idAnimal;

    -- Obtener el conjunto de tipoBioma de Trabajar correspondiente al RFC en la relación Atender
    SELECT ARRAY_AGG(DISTINCT tipoBioma) INTO conjunto_tipoBioma_trabajar
    FROM Trabajar
    WHERE RFC = NEW.RFC;

    -- Verificar si el tipoBioma del Animal está en el conjunto de tipoBioma de Trabajar
    IF NOT tipo_bioma_animal = ANY(conjunto_tipoBioma_trabajar) THEN
        RAISE EXCEPTION 'El animal no está en el mismo bioma en el cual trabaja el veterinario';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE or replace TRIGGER validar_bioma_atender
BEFORE INSERT OR UPDATE ON Atender
FOR EACH ROW
EXECUTE FUNCTION verificar_mismo_bioma();


CREATE OR REPLACE FUNCTION verificar_asistencia() 
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM Asistir 
        WHERE idEvento = NEW.idEvento 
        AND idCliente = NEW.idCliente 
    ) THEN
        RAISE EXCEPTION 'Un mismo cliente no puede asistir varias veces a un mismo evento';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create or replace TRIGGER validar_asistencia
BEFORE INSERT OR UPDATE ON Asistir
FOR EACH ROW
EXECUTE FUNCTION verificar_asistencia();


CREATE OR REPLACE FUNCTION verificar_ave_aviario() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipoBioma = 'aviario' AND NEW.esAve = false THEN
        RAISE EXCEPTION 'Solo puede haber aves en el aviario';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE or replace TRIGGER validar_ave_aviario
BEFORE INSERT OR UPDATE ON Animal
FOR EACH ROW
EXECUTE FUNCTION verificar_ave_aviario();


CREATE OR REPLACE FUNCTION validar_especie_ave() 
RETURNS TRIGGER AS $$
DECLARE
    especies_aves TEXT[] := ARRAY['aguila calva', 'aguila real', 'condor', 'cuervo', 'guacamaya', 'loro australiano', 'aguila arpia', 'buho', 'lechuza', 'tucan']; -- Lista de especies válidas para aves
BEGIN
    IF NEW.esAve = true AND NEW.especie NOT IN (SELECT unnest(especies_aves)) THEN
        RAISE EXCEPTION 'La especie de ave no es válida. Las especies válidas son: %', array_to_string(especies_aves, ', ');
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create or replace TRIGGER verificar_especie_ave
BEFORE INSERT OR UPDATE ON Animal
FOR EACH ROW
EXECUTE FUNCTION validar_especie_ave();



CREATE OR REPLACE FUNCTION verificar_distribucion() 
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM Distribuir 
        WHERE tipoBioma = NEW.tipoBioma
        AND nombre = NEW.nombre
    ) THEN
        RAISE EXCEPTION 'No se puede distribuir el mismo insumo al mismo bioma';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create or replace TRIGGER validar_distribucion
BEFORE INSERT OR UPDATE ON Distribuir
FOR EACH ROW
EXECUTE FUNCTION verificar_distribucion();


CREATE OR REPLACE FUNCTION verificar_trabajo_bioma() 
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM Trabajar 
        WHERE RFC = NEW.RFC
        AND tipoBioma = NEW.tipoBioma
    ) THEN
        RAISE EXCEPTION 'No puedes registrar doble vez una misma tupla';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create or replace TRIGGER validar_trabajo_bioma
BEFORE INSERT OR UPDATE ON Trabajar
FOR EACH ROW
EXECUTE FUNCTION verificar_trabajo_bioma();


CREATE OR REPLACE FUNCTION verificar_tupla_atender() 
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM Atender 
        WHERE RFC = NEW.RFC 
        AND idAnimal = NEW.idAnimal 
        AND indMedicas = NEW.indMedicas
    ) THEN
        RAISE EXCEPTION 'La tupla con RFC: %, idAnimal: % y indMedicas: % ya existe en la tabla Atender', NEW.RFC, NEW.idAnimal, NEW.indMedicas;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create or replace TRIGGER validar_tupla_atender
BEFORE INSERT OR UPDATE ON Atender
FOR EACH ROW
EXECUTE FUNCTION verificar_tupla_atender();


create or replace function validar_no_numeros()
returns trigger as $$
declare 
	currCol text;
	new_val text;
begin
	-- Iterate through each column in the specified table
    for currCol in
        select column_name
        from information_schema.columns
        where table_name = TG_TABLE_NAME
    loop 
    	execute 'SELECT ($1).' || currCol || '::text' into new_val using new;
    	
    	if(select data_type from information_schema.columns where table_name = TG_TABLE_NAME AND column_name = currCol)
    	 	not in ('numeric', 'double precision', 'integer', 'real') AND 
           new_val ~ '^\d+$' THEN 
		    RAISE EXCEPTION 'Valor no numerico en columna %', currCol;
        END IF; 
    end loop;
    
	return new;
end;
$$ 
language plpgsql;

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on alimento
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on animal
for each row
execute function validar_no_numeros();


create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on asistir
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on atender
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on bioma
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on cliente
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on correocliente
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on correoproveedor
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on correoveterinario
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on cuidador
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on distribuir
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on evento
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on insumo
for each row
execute function validar_no_numeros();


create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on jaula
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on medicina
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on notificar
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on proveedor
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on proveer
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on servicio
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on ticket
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on trabajar
for each row
execute function validar_no_numeros();

create or replace trigger validar_no_numericos
BEFORE INSERT OR UPDATE on veterinario
for each row
execute function validar_no_numeros();

---------------------------------------------- SPs --------------------------------------------------

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
Language plpgsql;
















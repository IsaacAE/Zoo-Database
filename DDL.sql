DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE TABLE Cuidador(
	RFC VARCHAR(13),
	nombre VARCHAR(50),
	apellidoPat VARCHAR(50),
	apellidoMat VARCHAR(50),
	genero char(1),
	diaTrabajo VARCHAR(20),
	horaInicio time,
	horaFin time,
	salario money,
	estado VARCHAR(50),
	colonia VARCHAR(50),
	calle VARCHAR(50),
	numExt int,
	numInt int,
	inicioContrato date,
	finContrato date,
	nacimiento date
);

-- Cuidador Restricciones de Dominio
ALTER TABLE Cuidador ALTER COLUMN RFC SET NOT NULL;	
ALTER TABLE Cuidador ADD CONSTRAINT RFC CHECK (RFC ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');  
ALTER TABLE Cuidador ALTER COLUMN NOMBRE SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT nombreNN CHECK(nombre <> '');
ALTER TABLE Cuidador ALTER COLUMN apellidoPat SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT apellidoPNN CHECK(apellidoPat <> '');
ALTER TABLE Cuidador ALTER COLUMN apellidoMat SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT apellidoMNN CHECK(apellidoMat <> '');
ALTER TABLE Cuidador ALTER COLUMN genero SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT generoVal CHECK (genero IN ( 'F' , 'M' , 'O'));
ALTER TABLE Cuidador ALTER COLUMN diaTrabajo SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT diaTrabajoNN CHECK(diaTrabajo <> '');
ALTER TABLE Cuidador ALTER COLUMN horaInicio SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN horaFin SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN salario SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT salarioMin CHECK(salario > CAST(7000 as MONEY));
ALTER TABLE Cuidador ALTER COLUMN estado SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT estadoNN CHECK(estado <> '');
ALTER TABLE Cuidador ALTER COLUMN  colonia SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT  coloniaNN CHECK(colonia <> '');
ALTER TABLE Cuidador ALTER COLUMN  calle SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT  calleNN CHECK(calle <> '');
ALTER TABLE Cuidador ALTER COLUMN numExt SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT ValidnumExt CHECK(numExt >= 0);
ALTER TABLE Cuidador ALTER COLUMN numInt SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT ValidnumInt CHECK(numInt >= 0);
ALTER TABLE Cuidador ALTER COLUMN inicioContrato SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT INICIOCONTRATONT CHECK(INICIOCONTRATO <= CURRENT_DATE);
ALTER TABLE Cuidador ALTER COLUMN FINCONTRATO SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT FINCONTRATONT CHECK(FINCONTRATO > CURRENT_DATE + INTERVAL '1 MONTH');
ALTER TABLE Cuidador ALTER COLUMN NACIMIENTO SET NOT NULL;
ALTER TABLE Cuidador ADD CONSTRAINT BORNTODAY CHECK(NACIMIENTO < CURRENT_DATE - INTERVAL '18 YEARS');

-- Cuidador Restricciones Referenciales
ALTER TABLE Cuidador ADD CONSTRAINT pk1 PRIMARY KEY(RFC);

COMMENT ON TABLE Cuidador IS 'Tabla que contiene los datos personales de los cuidadores del zoologico';

COMMENT ON COLUMN Cuidador.RFC IS 'RCF del cuidador'; 
COMMENT ON COLUMN Cuidador.nombre IS 'Nombre del cuidador';
COMMENT ON COLUMN Cuidador.apellidoPat IS 'Apellido Paterno del Cuidador';
COMMENT ON COLUMN Cuidador.apellidoMat IS 'Apellido Materno del Cuidador';
COMMENT ON COLUMN Cuidador.genero IS 'Genero del Cuidador';
COMMENT ON COLUMN Cuidador.diaTrabajo IS 'Dias en los que trabaja el cuidador';
COMMENT ON COLUMN Cuidador.horaInicio IS 'Hora de entrada del cuidador';
COMMENT ON COLUMN Cuidador.horaFin IS 'Hora de salida del cuidador';
COMMENT ON COLUMN Cuidador.salario IS 'Salario del cuidador';
COMMENT ON COLUMN Cuidador.estado IS 'Estado en el que vive el cuidador';
COMMENT ON COLUMN Cuidador.colonia IS 'Colonia del cuidador';
COMMENT ON COLUMN Cuidador.calle IS 'Calle del cuidador';
COMMENT ON COLUMN Cuidador.numExt IS 'Numero exterior de la casa del cuidador';
COMMENT ON COLUMN Cuidador.numInt IS 'Numero interior de la casa del cuidador';
COMMENT ON COLUMN Cuidador.inicioContrato IS 'Fecha en la que inicio el contrato del cuidador';
COMMENT ON COLUMN Cuidador.finContrato IS 'Fecha en la que va a finalizar el contrato';
COMMENT ON COLUMN Cuidador.nacimiento IS 'Fecha en la que nacio el cuidador';

COMMENT ON CONSTRAINT RFC ON Cuidador IS 'Los primeros 4 digitos van de la A-Z, los siguientes 6 digitos van del 0-9, los últimos 3 dígitos son una combinación ';
COMMENT ON CONSTRAINT nombreNN ON Cuidador IS 'La cadena no debe de ser vacia';
COMMENT ON CONSTRAINT apellidoPNN ON Cuidador IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT apellidoMNN ON Cuidador IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT nombreNN ON Cuidador IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT generoVal ON Cuidador IS 'La entrada debe de ser el char F, M, O ';
COMMENT ON CONSTRAINT diaTrabajoNN ON Cuidador IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT salarioMin ON Cuidador IS 'Debe de ser mayor a 7000 ';
COMMENT ON CONSTRAINT estadoNN ON Cuidador IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT coloniaNN ON Cuidador IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT calleNN ON Cuidador IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT ValidnumExt ON Cuidador IS 'Numero exterior mayor o igual a 0';
COMMENT ON CONSTRAINT ValidnumInt ON Cuidador IS 'Numero exterior mayor o igual a 0';
COMMENT ON CONSTRAINT INICIOCONTRATONT ON Cuidador IS 'El inicio de contrato no puede ser después que la fecha actual';
COMMENT ON CONSTRAINT FINCONTRATONT ON Cuidador IS 'La fecha del fin de contrato debe de ser mayor a pasado un mes después de la fecha actual';
COMMENT ON CONSTRAINT BORNTODAY ON Cuidador IS 'El cuidador debe de ser mayor a 18 años';

COMMENT ON CONSTRAINT pk1 ON Cuidador IS 'Llave primaria de la tabla cuidador';




CREATE TABLE Veterinario(
	RFC VARCHAR(13),
	nombre VARCHAR(50),
	apellidoPat VARCHAR(50),
	apellidoMat VARCHAR(50),
	genero char(1),
	especialidad VARCHAR(50),
	diaTrabajo VARCHAR(20),
	salario money,
	estado VARCHAR(50),
	colonia VARCHAR(50),
	calle VARCHAR(50),
	numExt int,
	numInt int,
	inicioContrato date,
	finContrato date,
	nacimiento date
);

-- Veterinario Restricciones de dominio
ALTER TABLE Veterinario ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE veterinario ADD CONSTRAINT RFC CHECK (RFC ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');  
ALTER TABLE Veterinario ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT nombreNN CHECK(nombre <> '');
ALTER TABLE Veterinario ALTER COLUMN apellidoPat SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT apellidoPNN CHECK(apellidoPat <> '');
ALTER TABLE Veterinario ALTER COLUMN apellidoMat SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT apellidoMNN CHECK(apellidoMat <> '');
ALTER TABLE Veterinario ALTER COLUMN genero SET NOT NULL;
ALTER TABLE veterinario ADD CONSTRAINT generoVal CHECK (genero IN ( 'F' , 'M' , 'O'));
ALTER TABLE Veterinario ADD CONSTRAINT especialidadNN CHECK(especialidad <> '');
ALTER TABLE Veterinario ALTER COLUMN diaTrabajo SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT diaTrabajoNN CHECK(diaTrabajo <> '');
ALTER TABLE Veterinario ALTER COLUMN salario SET NOT NULL;
ALTER table veterinario ADD CONSTRAINT salarioMin CHECK(salario > CAST(7000 as MONEY));
ALTER TABLE Veterinario ALTER COLUMN estado SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT estadoNN CHECK(estado <> '');
ALTER TABLE Veterinario ALTER COLUMN  colonia SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT  coloniaNN CHECK(colonia <> '');
ALTER TABLE Veterinario ALTER COLUMN  calle SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT  calleNN CHECK(calle <> '');
ALTER TABLE Veterinario ALTER COLUMN numExt SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT ValidnumExt CHECK(numExt >= 0);
ALTER TABLE Veterinario ALTER COLUMN numInt SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT ValidnumInt CHECK(numInt >= 0);
ALTER TABLE Veterinario ALTER COLUMN inicioContrato SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT INICIOCONTRATONT CHECK(INICIOCONTRATO < CURRENT_DATE);
ALTER TABLE Veterinario ALTER COLUMN FINCONTRATO SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT FINCONTRATONT CHECK(FINCONTRATO > CURRENT_DATE + INTERVAL '1 MONTH');
ALTER TABLE Veterinario ALTER COLUMN NACIMIENTO SET NOT NULL;
ALTER TABLE Veterinario ADD CONSTRAINT BORNTODAY CHECK(NACIMIENTO < CURRENT_DATE - INTERVAL '18 YEARS');
alter table Veterinario drop column diaTrabajo;
-- Veterinario Restricciones Referenciales
ALTER TABLE Veterinario ADD CONSTRAINT pk2 PRIMARY key(RFC);

COMMENT ON TABLE Veterinario IS 'Tabla que contiene los datos de veterinario';

COMMENT ON COLUMN Veterinario.RFC IS 'RCF del Veterinario'; 
COMMENT ON COLUMN Veterinario.nombre IS 'Nombre del Veterinario';
COMMENT ON COLUMN Veterinario.apellidoPat IS 'Apellido Paterno del Veterinario';
COMMENT ON COLUMN Veterinario.apellidoMat IS 'Apellido Materno del Veterinario';
COMMENT ON COLUMN Veterinario.especialidad IS 'Especialidad del Veterinario';
COMMENT ON COLUMN Veterinario.genero IS 'Genero del Veterinario';
COMMENT ON COLUMN Veterinario.salario IS 'Salario del Veterinario';
COMMENT ON COLUMN Veterinario.estado IS 'Estado en el que vive el Veterinario';
COMMENT ON COLUMN Veterinario.colonia IS 'Colonia del Veterinario';
COMMENT ON COLUMN Veterinario.calle IS 'Calle del Veterinario';
COMMENT ON COLUMN Veterinario.numExt IS 'Numero exterior de la casa del Veterinario';
COMMENT ON COLUMN Veterinario.numInt IS 'Numero interior de la casa del Veterinario';
COMMENT ON COLUMN Veterinario.inicioContrato IS 'Fecha en la que inicio el contrato del Veterinario';
COMMENT ON COLUMN Veterinario.finContrato IS 'Fecha en la que va a finalizar el contrato';
COMMENT ON COLUMN Veterinario.nacimiento IS 'Fecha en la que nacio el Veterinario';

COMMENT ON CONSTRAINT RFC ON Veterinario IS 'Los primeros 4 digitos van de la A-Z, los siguientes 6 digitos van del 0-9, los últimos 3 dígitos son una combinación ';
COMMENT ON CONSTRAINT nombreNN ON Veterinario IS 'La cadena no debe de ser vacia';
COMMENT ON CONSTRAINT apellidoPNN ON Veterinario IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT apellidoMNN ON Veterinario IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT especialidadNN ON Veterinario IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT generoVal ON Veterinario IS 'La entrada debe de ser el char F, M, O ';
COMMENT ON CONSTRAINT salarioMin ON Veterinario IS 'Debe de ser mayor a 7000 ';
COMMENT ON CONSTRAINT estadoNN ON Veterinario IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT coloniaNN ON Veterinario IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT calleNN ON Veterinario IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT ValidnumExt ON Veterinario IS 'Numero exterior mayor o igual a 0';
COMMENT ON CONSTRAINT ValidnumInt ON Veterinario IS 'Numero exterior mayor o igual a 0';
COMMENT ON CONSTRAINT INICIOCONTRATONT ON Veterinario IS 'El inicio de contrato no puede ser después que la fecha actual';
COMMENT ON CONSTRAINT FINCONTRATONT ON Veterinario IS 'La fecha del fin de contrato debe de ser mayor a pasado un mes después de la fecha actual';
COMMENT ON CONSTRAINT BORNTODAY ON Veterinario IS 'El cuidador debe de ser mayor a 18 años';

COMMENT ON CONSTRAINT pk2 ON Veterinario IS 'Llave primaria de la tabla veteriario';







CREATE TABLE Cliente(
	idCliente serial,
	nombre VARCHAR(50), 
	apellidoPat VARCHAR(50),
	apellidoMat VARCHAR(50),
	genero char(1),
        nacimiento date
);

-- Cliente Restricciones de dominio
ALTER TABLE Cliente ALTER COLUMN idCliente SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT nombreNN CHECK(nombre <> '');
ALTER TABLE Cliente ALTER COLUMN apellidoPat SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT apellidoPNN CHECK(apellidoPat <> '');
ALTER TABLE Cliente ALTER COLUMN apellidoMat SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT apellidoMNN CHECK(apellidoMat <> '');
ALTER TABLE Cliente ALTER COLUMN genero SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT generoVal CHECK (genero IN ( 'F' , 'M' , 'O'));
ALTER TABLE Cliente ALTER COLUMN nacimiento SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT borntoday CHECK(nacimiento <= CURRENT_DATE - INTERVAL '16 YEARS');


-- Cliente Restricciones Referenciales
ALTER TABLE Cliente ADD CONSTRAINT pk3 PRIMARY KEY(idCliente);

COMMENT ON TABLE Cliente IS 'Tabla que contiene los datos personales de los clientes del zoologico';

COMMENT ON COLUMN Cliente.idCliente IS 'ID del cliente'; 
COMMENT ON COLUMN Cliente.nombre IS 'Nombre del Ciente';
COMMENT ON COLUMN Cliente.apellidoPat IS 'Apellido Paterno del Cliente';
COMMENT ON COLUMN Cliente.apellidoMat IS 'Apellido Materno del Cliente';
COMMENT ON COLUMN Cliente.nacimiento IS 'Fecha de nacimiento del Cliente';

COMMENT ON CONSTRAINT nombreNN ON Cliente IS 'Restriccion CHECK. La cadena no debe de ser vacia';
COMMENT ON CONSTRAINT apellidoPNN ON Cliente IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT apellidoMNN ON Cliente IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT nombreNN ON Cliente IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT generoVal ON Cliente IS 'La entrada debe de ser el char F, M, O ';
COMMENT ON CONSTRAINT borntoday ON Cliente IS 'El cliente debe tener al menos 16 anios de edad';

COMMENT ON CONSTRAINT pk3 ON Cliente IS 'Llave primaria de la tabla Cliente';





CREATE TABLE Bioma(
	tipoBioma VARCHAR(50)
);
-- Bioma Restricciones Dominio
ALTER TABLE Bioma ALTER COLUMN tipoBioma SET NOT NULL;
ALTER TABLE Bioma ADD CONSTRAINT tipoBiomaNN CHECK(tipoBioma <> '');

-- Bioma Restricciones Referenciales

ALTER TABLE Bioma ADD CONSTRAINT pk4 PRIMARY KEY(tipoBioma);

COMMENT ON TABLE Bioma IS 'Tabla que contiene los datos de los biomas';

COMMENT ON COLUMN Bioma.tipoBioma IS 'Biomas que hay en el zoologico';

COMMENT ON CONSTRAINT tipoBiomaNN ON Bioma IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT pk3 ON Cliente IS 'Llave primaria de la tabla Bioma';



CREATE TABLE Evento(
	idEvento serial,
	capacidad int,
	tipo VARCHAR(50),
	fecha date
);

-- Evento Restricciones Dominio
ALTER TABLE Evento ALTER COLUMN idEvento SET NOT NULL;
ALTER TABLE Evento ALTER COLUMN capacidad SET NOT NULL;
ALTER TABLE Evento ADD CONSTRAINT capacidadEmpty CHECK(capacidad > 0);
ALTER TABLE Evento ALTER COLUMN tipo SET NOT NULL;
ALTER TABLE Evento ADD CONSTRAINT tipoNN CHECK(tipo <> '');
ALTER TABLE Evento ALTER COLUMN fecha SET NOT NULL;

-- Evento Restricciones Referenciales
ALTER TABLE Evento ADD CONSTRAINT pk5 PRIMARY KEY(idEvento);

COMMENT ON TABLE Evento IS 'Tabla que contiene los datos del evento del zoo';

COMMENT ON COLUMN Evento.idEvento IS 'ID del evento';
COMMENT ON COLUMN Evento.capacidad IS 'Número de personas que caben en un evento';
COMMENT ON COLUMN Evento.tipo IS 'TIpos de eventos que se encuentran en el zoo';
COMMENT ON COLUMN Evento.fecha IS 'Fecha en la que se llevará acabo el evento';


COMMENT ON CONSTRAINT capacidadEmpty ON Evento IS 'La capacidad de personas que asistirán al evento debe de ser mayor que 0';
COMMENT ON CONSTRAINT tipoNN ON Evento IS 'Restriccion CHECK. fLa cadena no debe de ser vacía';

COMMENT ON CONSTRAINT pk3 ON Cliente IS 'Llave primaria de la tabla Evento';



CREATE TABLE Proveedor(
	RFC VARCHAR(13),
	nombre VARCHAR(50),
	apellidoPat VARCHAR(50),
	apellidoMat VARCHAR(50),
	genero char(1),
	frecuenciaS VARCHAR(50),
	costoS money,
	estado VARCHAR(50),
	colonia VARCHAR(50),
	calle VARCHAR(50),
	numInt int,
	numExt int,
	inicioContrato date,
	finContrato date,
	nacimiento date
);

-- Proveedor Restricciones de Dominio
ALTER TABLE Proveedor ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE proveedor ADD CONSTRAINT RFC CHECK (RFC ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$'); 
ALTER TABLE Proveedor ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT nombreNN CHECK(nombre <> '');
ALTER TABLE Proveedor ALTER COLUMN apellidoPat SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT apellidoPNN CHECK(apellidoPat <> '');
ALTER TABLE Proveedor ALTER COLUMN apellidoMat SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT apellidoMNN CHECK(apellidoMat <> '');
ALTER TABLE Proveedor ALTER COLUMN genero SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT generoVal CHECK (genero IN ( 'F' , 'M' , 'O'));
ALTER TABLE Proveedor ALTER COLUMN frecuenciaS SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT frecuenciaSNN CHECK(frecuenciaS <> '');
ALTER TABLE Proveedor ALTER COLUMN costoS SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN estado SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT estadoNN CHECK(estado <> '');
ALTER TABLE Proveedor ALTER COLUMN  colonia SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT  coloniaNN CHECK(colonia <> '');
ALTER TABLE Proveedor ALTER COLUMN  calle SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT  calleNN CHECK(calle <> '');
ALTER TABLE Proveedor ALTER COLUMN numExt SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT ValidnumExt CHECK(numExt >= 0);
ALTER TABLE Proveedor ALTER COLUMN numInt SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT ValidnumInt CHECK(numInt >= 0);
ALTER TABLE Proveedor ALTER COLUMN inicioContrato SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT INICIOCONTRATONT CHECK(INICIOCONTRATO < CURRENT_DATE);
ALTER TABLE Proveedor ALTER COLUMN FINCONTRATO SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT FINCONTRATONT CHECK(FINCONTRATO > CURRENT_DATE + INTERVAL '1 MONTH');
ALTER TABLE Proveedor ALTER COLUMN NACIMIENTO SET NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT BORNTODAY CHECK(NACIMIENTO < CURRENT_DATE - INTERVAL '18 YEARS');

-- Proveedor Restricciones Referenciales
ALTER TABLE Proveedor ADD CONSTRAINT pk6 PRIMARY KEY(RFC);

COMMENT ON TABLE Proveedor IS 'Tabla que contiene los datos de Proveedor';

COMMENT ON COLUMN Proveedor.RFC IS 'RCF del Proveedor'; 
COMMENT ON COLUMN Proveedor.nombre IS 'Nombre del Proveedor';
COMMENT ON COLUMN Proveedor.apellidoPat IS 'Apellido Paterno del Proveedor';
COMMENT ON COLUMN Proveedor.apellidoMat IS 'Apellido Materno del Proveedor';
COMMENT ON COLUMN Proveedor.genero IS 'Genero del Proveedor';
COMMENT ON COLUMN Proveedor.frecuenciaS IS 'Frecuencia con la que el proveedor provee de insumos';
COMMENT ON COLUMN Proveedor.costoS IS 'Costo en el que vende los insumos';
COMMENT ON COLUMN Proveedor.estado IS 'Estado en el que vive el Proveedor';
COMMENT ON COLUMN Proveedor.colonia IS 'Colonia del Proveedor';
COMMENT ON COLUMN Proveedor.calle IS 'Calle del Proveedor';
COMMENT ON COLUMN Proveedor.numExt IS 'Numero exterior de la casa del Proveedor';
COMMENT ON COLUMN Proveedor.numInt IS 'Numero interior de la casa del Proveedor';
COMMENT ON COLUMN Proveedor.inicioContrato IS 'Fecha en la que inicio el contrato del Proveedor';
COMMENT ON COLUMN Proveedor.finContrato IS 'Fecha en la que va a finalizar el contrato';
COMMENT ON COLUMN Proveedor.nacimiento IS 'Fecha en la que nacio el Proveedor';

COMMENT ON CONSTRAINT RFC ON Proveedor IS 'Los primeros 4 digitos van de la A-Z, los siguientes 6 digitos van del 0-9, los últimos 3 dígitos son una combinación ';
COMMENT ON CONSTRAINT nombreNN ON Proveedor IS 'La cadena no debe de ser vacia';
COMMENT ON CONSTRAINT apellidoPNN ON Proveedor IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT apellidoMNN ON Proveedor IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT generoVal ON Proveedor IS 'La entrada debe de ser el char F, M, O ';
COMMENT ON CONSTRAINT frecuenciaSNN ON Proveedor IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT estadoNN ON Proveedor IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT coloniaNN ON Proveedor IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT calleNN ON Proveedor IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT ValidnumExt ON Proveedor IS 'Numero exterior mayor o igual a 0';
COMMENT ON CONSTRAINT ValidnumInt ON Proveedor IS 'Numero exterior mayor o igual a 0';
COMMENT ON CONSTRAINT INICIOCONTRATONT ON Proveedor IS 'El inicio de contrato no puede ser después que la fecha actual';
COMMENT ON CONSTRAINT FINCONTRATONT ON Proveedor IS 'La fecha del fin de contrato debe de ser mayor a pasado un mes después de la fecha actual';
COMMENT ON CONSTRAINT BORNTODAY ON Proveedor IS 'El cuidador debe de ser mayor a 18 años';

COMMENT ON CONSTRAINT pk6 ON Proveedor IS 'Llave primaria de la tabla Proveedor';



CREATE TABLE Insumo(
	nombre VARCHAR(50),
	cantidad int,
	caducidad date,
	refrigeracion bool
);

-- Insumo Restricciones Dominio
ALTER TABLE Insumo ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Insumo ADD CONSTRAINT  nombreNN CHECK(nombre <> '');
ALTER TABLE Insumo ALTER COLUMN cantidad SET NOT NULL;
ALTER TABLE Insumo ADD CONSTRAINT NOcantidad CHECK(cantidad >= 0);
ALTER TABLE Insumo ALTER COLUMN caducidad SET NOT NULL;
ALTER TABLE Insumo ALTER COLUMN refrigeracion SET NOT NULL;

-- Insumo Restricciones Referenciales
ALTER TABLE Insumo ADD CONSTRAINT pk7 PRIMARY KEY(nombre);

COMMENT ON TABLE Insumo IS 'Tabla que contiene los datos de los insumos';

COMMENT ON COLUMN Insumo.nombre IS 'Nombre del insumo';
COMMENT ON COLUMN Insumo.cantidad IS 'Cantidad de insumo que tenemos';
COMMENT ON COLUMN Insumo.caducidad IS 'Caducidad del insumo';
COMMENT ON COLUMN Insumo.refrigeracion IS 'Info de si el insumo debe de ser refrigerado o no';

COMMENT ON CONSTRAINT nombreNN ON Insumo IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT NOcantidad ON Insumo IS 'La cantidad debe de ser mayor o igual a 0';

COMMENT ON CONSTRAINT pk7 ON Insumo IS 'Llave primaria de la tabla Insumo';


CREATE TABLE Medicina(
	nombre VARCHAR(50),
	lote int,
	laboratorio VARCHAR(50)
);

-- Medicina Restricciones Dominio 
ALTER TABLE Medicina ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Medicina ADD CONSTRAINT  nombreNN CHECK(nombre <> '');
ALTER TABLE Medicina ALTER COLUMN lote SET NOT NULL;
ALTER TABLE Medicina ALTER COLUMN laboratorio SET NOT NULL;
ALTER TABLE Medicina ADD CONSTRAINT  laboratorioNN CHECK(laboratorio <> '');

-- Medicina Restricciones Referenciales
ALTER TABLE Medicina ADD CONSTRAINT pk8 PRIMARY KEY(nombre);
ALTER TABLE Medicina ADD CONSTRAINT fkVIII FOREIGN KEY(nombre) REFERENCES Insumo(nombre) on update cascade ON DELETE CASCADE;

COMMENT ON TABLE Medicina IS 'Tabla que contiene los datos de la medicina';

COMMENT ON COLUMN Medicina.nombre IS 'Nombre de la Medicina';
COMMENT ON COLUMN Medicina.lote IS 'Lote de la medicina';
COMMENT ON COLUMN Medicina.laboratorio IS 'Laboratorio del que salió la medicina';

COMMENT ON CONSTRAINT nombreNN ON Medicina IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT laboratorioNN ON Medicina IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT pk8 ON Medicina IS 'Llave primaria de la tabla Medicina';
COMMENT ON CONSTRAINT fkVIII ON Medicina IS 'Llave foranea nombre que referencia Insumo';


CREATE TABLE Alimento(
	nombre VARCHAR(50),
	tipo VARCHAR(20)
);

-- Alimento Restricciones Dominio
ALTER TABLE Alimento ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Alimento ADD CONSTRAINT  nombreNN CHECK(nombre <> '');
ALTER TABLE Alimento ALTER COLUMN tipo SET NOT NULL;
ALTER TABLE Alimento ADD CONSTRAINT  tipoNN CHECK(tipo <> '');

-- Alimento Restricciones Referenciales
ALTER TABLE Alimento ADD CONSTRAINT pk9 PRIMARY KEY(nombre);
ALTER TABLE Alimento ADD CONSTRAINT fkVIII FOREIGN KEY(nombre) REFERENCES Insumo(nombre) on update CASCADE ON DELETE CASCADE;

--Comentarios
COMMENT ON TABLE Alimento IS 'Tabla que contiene los datos del alimento';

COMMENT ON COLUMN Alimento.nombre IS 'Nombre del Alimento';
COMMENT ON COLUMN Alimento.tipo IS 'Tipo de Alimento';

COMMENT ON CONSTRAINT nombreNN ON Alimento IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT tipoNN ON Alimento IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT pk9 ON Alimento IS 'Llave primaria de la tabla Alimento';
COMMENT ON CONSTRAINT fkVIII ON Alimento IS 'Llave foranea nombre que referencia Insumo';


CREATE TABLE Jaula(
	numJaula int,
	tipoBioma VARCHAR(50)
);

-- Jaula Restricciones Dominio
ALTER TABLE Jaula ALTER COLUMN numJaula SET NOT NULL;
ALTER TABLE Jaula ALTER COLUMN tipoBioma SET NOT NULL;
ALTER TABLE Jaula ADD CONSTRAINT numJaulaNN CHECK(numJaula > 0);
ALTER TABLE Jaula ADD CONSTRAINT tipoBiomaNN CHECK(tipoBioma <> '');

-- Jaula Restricciones Referenciales
ALTER TABLE Jaula ADD CONSTRAINT pk15 PRIMARY KEY(numJaula, tipoBioma);
ALTER TABLE Jaula ADD CONSTRAINT fkXV FOREIGN KEY(tipoBioma) REFERENCES Bioma(tipoBioma) on update cascade ON DELETE CASCADE;

--Comentarios
COMMENT ON TABLE Jaula IS 'Tabla que contiene los datos de las Jaulas';

COMMENT ON COLUMN Jaula.numJaula IS 'Numero de la Jaula';
COMMENT ON COLUMN Jaula.tipoBioma IS 'Bioma en el que se encuentra la Jaula';

COMMENT ON CONSTRAINT numJaulaNN ON Jaula IS 'Restriccion CHECK. El numero de la Jaula debe de ser mayor a 0';
COMMENT ON CONSTRAINT tipoBiomaNN ON Jaula IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT pk15 ON Jaula IS 'Llave primaria de la tabla Jaula';
COMMENT ON CONSTRAINT fkXV ON Jaula IS 'Llave foranea tipoBioma que referencia Bioma';


CREATE TABLE Animal(
	idAnimal int,
	numJaula int,
	tipoBioma VARCHAR(50),
	RFC VARCHAR(13),
	nombre VARCHAR(50),
	especie VARCHAR(50),
	peso float8,
	altura float8,
	sexo Char(1),
	alimentacion VARCHAR(20),
	esAve bool
);

-- Animal Restricciones Dominio
ALTER TABLE Animal ALTER COLUMN idAnimal SET NOT NULL;
ALTER TABLE Animal ALTER COLUMN numJaula SET NOT NULL;
ALTER TABLE Animal ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE Animal ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Animal ALTER COLUMN especie SET NOT NULL;
ALTER TABLE Animal ALTER COLUMN peso SET NOT NULL;
ALTER TABLE Animal ALTER COLUMN altura SET NOT NULL;
ALTER TABLE Animal ALTER COLUMN sexo SET NOT NULL;
ALTER TABLE Animal ALTER COLUMN tipoBioma SET NOT NULL;
ALTER TABLE Animal ALTER COLUMN alimentacion SET NOT NULL;
ALTER TABLE Animal ALTER COLUMN esAve SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT RFCNN CHECK(RFC <> '');
ALTER TABLE Animal ADD CONSTRAINT nombreNN CHECK(nombre <> '');
ALTER TABLE Animal ADD CONSTRAINT especieNN CHECK(especie <> '');
ALTER TABLE Animal ADD CONSTRAINT alimentacionNN CHECK(alimentacion <> '');
ALTER TABLE Animal ADD CONSTRAINT tipoBiomaNN CHECK(tipoBioma <> '');
ALTER TABLE Animal ADD CONSTRAINT idAnimalNN CHECK(idAnimal > 0);
ALTER TABLE Animal ADD CONSTRAINT numJaula CHECK(numJaula > 0);
ALTER TABLE Animal ADD CONSTRAINT peso CHECK(peso > 0);
ALTER TABLE Animal ADD CONSTRAINT altura CHECK(altura > 0);
ALTER TABLE Animal ADD CONSTRAINT alimentacionC CHECK (alimentacion IN ('carnivoro', 'herbivoro', 'omnivoro'));
ALTER TABLE Animal ADD CONSTRAINT RFCC CHECK (RFC ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$'); 
ALTER TABLE Animal ADD CONSTRAINT sexoC CHECK(sexo IN ('M', 'H'));

-- Animal Restricciones Referenciales
ALTER TABLE Animal ADD CONSTRAINT pkA1 PRIMARY KEY(idAnimal);
ALTER TABLE Animal ADD CONSTRAINT fkA1 FOREIGN KEY(numJaula, tipoBioma) REFERENCES Jaula(numJaula, tipoBioma) on update cascade ON DELETE CASCADE;
ALTER TABLE Animal ADD CONSTRAINT fkA2 FOREIGN KEY(RFC) REFERENCES Cuidador(RFC) on update cascade ON DELETE CASCADE;

--Comentarios
COMMENT ON TABLE Animal IS 'Tabla que contiene los datos de los Animales';

COMMENT ON COLUMN Animal.idAnimal IS 'El ID del Animal';
COMMENT ON COLUMN Animal.numJaula IS 'Numero de la Jaula en la que se encuentra Animal';
COMMENT ON COLUMN Animal.tipoBioma IS 'Tipo de Bioma en la que vive el animal';
COMMENT ON COLUMN Animal.RFC IS 'RFC del cuidador del animal';
COMMENT ON COLUMN Animal.nombre IS 'Nombre del animal';
COMMENT ON COLUMN Animal.especie IS 'Especie del animal';
COMMENT ON COLUMN Animal.peso IS 'Peso del animal';
COMMENT ON COLUMN Animal.altura IS 'Altura del animal';
COMMENT ON COLUMN Animal.sexo IS 'Sexo del animal';
COMMENT ON COLUMN Animal.alimentacion IS 'Alimentacion del animal';
COMMENT ON COLUMN Animal.esAve IS 'Saber si el animal es un ave';

COMMENT ON CONSTRAINT RFCC ON Animal IS 'Restriccion CHECK. Los primeros 4 digitos van de la A-Z, los siguientes 6 digitos van del 0-9, los últimos 3 dígitos son una combinación';
COMMENT ON CONSTRAINT RFCNN ON Animal IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT nombreNN ON Animal IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT especieNN ON Animal IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT alimentacionNN ON Animal IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT tipoBiomaNN ON Animal IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT idAnimalNN ON Animal IS 'Restriccion CHECK. idAnimal debe de ser mayor a 0';
COMMENT ON CONSTRAINT numJaula ON Animal IS 'Restriccion CHECK. numJaula debe de ser mayor a 0';
COMMENT ON CONSTRAINT peso ON Animal IS 'Restriccion CHECK. peso debe de ser mayor a 0';
COMMENT ON CONSTRAINT altura ON Animal IS 'Restriccion CHECK. altura debe de ser mayor a 0';
COMMENT ON CONSTRAINT alimentacionC ON Animal IS 'Restriccion CHECK. La entrada de alimentacion debe de ser Carnivoro, Herbivoro, Omnivoro';
COMMENT ON CONSTRAINT sexoC ON Animal IS 'Restriccion CHECK. La entrada de sexo debe de ser M o H';

COMMENT ON CONSTRAINT pkA1 ON Animal IS 'Llave primaria de la tabla Animal-idAnimal';
COMMENT ON CONSTRAINT fkA1 ON Animal IS 'Llave foranea numJaula y tipoBioma que referencia Jaula';
COMMENT ON CONSTRAINT fkA2 ON Animal IS 'Llave foranea RFC que referencia Cuidador';


CREATE TABLE TelefonoCuidador(
	RFC VARCHAR(13),
	telefono bigint
);

-- TelefonoCuidador Restricciones Dominio
ALTER TABLE TelefonoCuidador ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE TelefonoCuidador ALTER COLUMN telefono SET NOT NULL;
ALTER TABLE TelefonoCuidador ADD CONSTRAINT RFCNN CHECK(RFC <> '');

-- TelefonoCuidador Restricciones Referenciales
ALTER TABLE TelefonoCuidador ADD CONSTRAINT pkIX PRIMARY KEY(RFC, telefono);
ALTER TABLE TelefonoCuidador ADD CONSTRAINT fkIX FOREIGN KEY(RFC) REFERENCES Cuidador(RFC) on update cascade ON DELETE CASCADE;

--Comentarios
COMMENT ON TABLE TelefonoCuidador IS 'Tabla que contiene los telefonos de los cuidadores';

COMMENT ON COLUMN TelefonoCuidador.RFC IS 'RFC del cuidador';
COMMENT ON COLUMN TelefonoCuidador.telefono IS 'Telefono del cuidador';

COMMENT ON CONSTRAINT RFCNN ON TelefonoCuidador IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT pkIX ON TelefonoCuidador IS 'Llave primaria de la tabla TelefonoCuidador--RFC/Telefono';
COMMENT ON CONSTRAINT fkIX ON TelefonoCuidador IS 'Llave foranea RFC que referencia Cuidador';


CREATE TABLE CorreoCuidador(
	RFC VARCHAR(13),
	correo VARCHAR(50)
);

-- CorreoCuidador Restricciones Dominio
ALTER TABLE CorreoCuidador ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE CorreoCuidador ALTER COLUMN correo SET NOT NULL;
ALTER TABLE CorreoCuidador ADD CONSTRAINT correoNN CHECK(correo <> '');
ALTER TABLE CorreoCuidador ADD CONSTRAINT correoRegex CHECK (correo ~ '[a-zA-Z]{10}[0-9]{3}@(yahoo|gmail|hotmail).com');

-- CorreoCuidador Restricciones Referenciales
ALTER TABLE CorreoCuidador ADD CONSTRAINT pk10 PRIMARY KEY(RFC, correo);
ALTER TABLE CorreoCuidador ADD CONSTRAINT fkX FOREIGN KEY(RFC) REFERENCES Cuidador(RFC) on update cascade ON DELETE CASCADE;

--Comentarios
COMMENT ON TABLE CorreoCuidador IS 'Tabla que contiene los correos de los cuidadores';

COMMENT ON COLUMN CorreoCuidador.RFC IS 'RFC del cuidador';
COMMENT ON COLUMN CorreoCuidador.correo IS 'Correo del cuidador';

COMMENT ON CONSTRAINT correoNN ON CorreoCuidador IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT correoRegex ON CorreoCuidador IS 'Restriccion CHECK. El correo debe de tener un arroba y al menos un caracter antes del punto';

COMMENT ON CONSTRAINT pk10 ON CorreoCuidador IS 'Llave primaria de la tabla CorreoCuidador--RFC/correo';
COMMENT ON CONSTRAINT fkX ON CorreoCuidador IS 'Llave foranea RFC que referencia Cuidador';




CREATE TABLE TelefonoVeterinario(
	RFC VARCHAR(13),
	telefono bigint
);

-- TelefonoVeterinario Restricciones Dominio
ALTER TABLE TelefonoVeterinario ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE TelefonoVeterinario ALTER COLUMN telefono SET NOT NULL;
ALTER TABLE TelefonoVeterinario ADD CONSTRAINT RFCNN CHECK(RFC <> '');

-- TelefonoVeterinario Restricciones Referenciales
ALTER TABLE TelefonoVeterinario ADD CONSTRAINT pk11 PRIMARY KEY(RFC, telefono);
ALTER TABLE TelefonoVeterinario ADD CONSTRAINT fk11 FOREIGN KEY(RFC) REFERENCES Veterinario(RFC) on update cascade ON DELETE CASCADE;

--Comentarios
COMMENT ON TABLE TelefonoVeterinario IS 'Tabla que contiene los telefonos de los veterinarios';

COMMENT ON COLUMN TelefonoVeterinario.RFC IS 'RFC del veterinario';
COMMENT ON COLUMN TelefonoVeterinario.telefono IS 'Telefono del veterinario';

COMMENT ON CONSTRAINT RFCNN ON TelefonoVeterinario IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT pk11 ON TelefonoVeterinario IS 'Llave primaria de la tabla TelefonoVeterinario--RFC/Telefono';
COMMENT ON CONSTRAINT fk11 ON TelefonoVeterinario IS 'Llave foranea RFC que referencia Veterinario';

CREATE TABLE CorreoVeterinario(
	RFC VARCHAR(13),
	correo VARCHAR(50)
);

-- CorreoVeterinario Restricciones Dominio
ALTER TABLE CorreoVeterinario ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE CorreoVeterinario ALTER COLUMN correo SET NOT NULL;
ALTER TABLE CorreoVeterinario ADD CONSTRAINT correoNN CHECK(correo <> '');
ALTER TABLE CorreoVeterinario ADD CONSTRAINT correoRegex CHECK (correo ~ '[a-zA-Z]{10}[0-9]{3}@(yahoo|gmail|hotmail).com');

-- CorreoVeterinario Restricciones Referenciales
ALTER TABLE CorreoVeterinario ADD CONSTRAINT pk12 PRIMARY KEY(RFC, correo);
ALTER TABLE CorreoVeterinario ADD CONSTRAINT fkXII FOREIGN KEY(RFC) REFERENCES Veterinario(RFC) on update cascade ON DELETE CASCADE;

--Comentarios
COMMENT ON TABLE CorreoVeterinario IS 'Tabla que contiene los correos de los veterinarios';

COMMENT ON COLUMN CorreoVeterinario.RFC IS 'RFC del veterinario';
COMMENT ON COLUMN CorreoVeterinario.correo IS 'Correo del veterinario';

COMMENT ON CONSTRAINT correoNN ON CorreoVeterinario IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT correoRegex ON CorreoVeterinario IS 'Restriccion CHECK. El correo debe de tener un arroba y al menos un caracter antes del punto';

COMMENT ON CONSTRAINT pk12 ON CorreoVeterinario IS 'Llave primaria de la tabla CorreoVeterinario--RFC/correo';
COMMENT ON CONSTRAINT fkXII ON CorreoVeterinario IS 'Llave foranea RFC que referencia Veterinario';


CREATE TABLE TelefonoProveedor(
	RFC VARCHAR(13),
	telefono bigint
);

-- TelefonoProveedor Restricciones Dominio
ALTER TABLE TelefonoProveedor ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE TelefonoProveedor ALTER COLUMN telefono SET NOT NULL;
ALTER TABLE TelefonoProveedor ADD CONSTRAINT RFCNN CHECK(RFC <> '');

-- TelefonoProveedor Restricciones Referenciales
ALTER TABLE TelefonoProveedor ADD CONSTRAINT pkXI PRIMARY KEY(RFC, telefono);
ALTER TABLE TelefonoProveedor ADD CONSTRAINT fkXI FOREIGN KEY(RFC) REFERENCES Proveedor(RFC) on update cascade ON DELETE CASCADE;

--Comentarios
COMMENT ON TABLE TelefonoProveedor IS 'Tabla que contiene los telefonos de los proveedores';

COMMENT ON COLUMN TelefonoProveedor.RFC IS 'RFC del proveedor';
COMMENT ON COLUMN TelefonoProveedor.telefono IS 'Telefono del proveedor';

COMMENT ON CONSTRAINT RFCNN ON TelefonoProveedor IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT pkXI ON TelefonoProveedor IS 'Llave primaria de la tabla TelefonoProveedor--RFC/Telefono';
COMMENT ON CONSTRAINT fkXI ON TelefonoProveedor IS 'Llave foranea RFC que referencia Proveedor';



CREATE TABLE CorreoProveedor(
	RFC VARCHAR(13),
	correo VARCHAR(50)
);

-- CorreoProveedor Restricciones Dominio
ALTER TABLE CorreoProveedor ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE CorreoProveedor ALTER COLUMN correo SET NOT NULL;
ALTER TABLE CorreoProveedor ADD CONSTRAINT correoNN CHECK(correo <> '');
ALTER TABLE CorreoProveedor ADD CONSTRAINT correoRegex CHECK (correo ~ '[a-zA-Z]{10}[0-9]{3}@(yahoo|gmail|hotmail).com');

-- CorreoProveedor Restricciones Referenciales
ALTER TABLE CorreoProveedor ADD CONSTRAINT pkXII PRIMARY KEY(RFC, correo);
ALTER TABLE CorreoProveedor ADD CONSTRAINT fkXII FOREIGN KEY(RFC) REFERENCES Proveedor(RFC) on update cascade ON DELETE CASCADE;

COMMENT ON TABLE CorreoProveedor IS 'Tabla que contiene los correos de los proveedores';

COMMENT ON COLUMN CorreoProveedor.RFC IS 'RFC del proveedor';
COMMENT ON COLUMN CorreoProveedor.correo IS 'Correo del proveedor';

COMMENT ON CONSTRAINT correoNN ON CorreoProveedor IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT correoRegex ON CorreoProveedor IS 'Restriccion CHECK. El correo debe de tener un arroba y al menos un caracter antes del punto';

COMMENT ON CONSTRAINT pkXII ON CorreoProveedor IS 'Llave primaria de la tabla CorreoProveedor--RFC/correo';
COMMENT ON CONSTRAINT fkXII ON CorreoProveedor IS 'Llave foranea RFC que referencia Proveedor';



CREATE TABLE TelefonoCliente(
	idCliente int,
	telefono bigint
);

-- TelefonoCliente Restricciones Dominio
ALTER TABLE TelefonoCliente ALTER COLUMN idCliente SET NOT NULL;
ALTER TABLE TelefonoCliente ALTER COLUMN telefono SET NOT NULL;
ALTER TABLE TelefonoCliente ADD CONSTRAINT idClienteNN CHECK(idCliente > 0);

-- TelefonoCliente Restricciones Referenciales
ALTER TABLE TelefonoCliente ADD CONSTRAINT pk13 PRIMARY KEY(idCliente, telefono);
ALTER TABLE TelefonoCliente ADD CONSTRAINT fkXIII FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente) on update cascade ON DELETE CASCADE;

--Comentarios
COMMENT ON TABLE TelefonoCuidador IS 'Tabla que contiene los telefonos de los clientes';

COMMENT ON COLUMN TelefonoCliente.idCLiente IS 'ID del cliente';
COMMENT ON COLUMN TelefonoCliente.telefono IS 'Telefono del cliente';

COMMENT ON CONSTRAINT idClienteNN ON TelefonoCliente IS 'Restriccion CHECK. El ID debe de ser mayor a 0';

COMMENT ON CONSTRAINT pk13 ON TelefonoCliente IS 'Llave primaria de la tabla TelefonoCliente--idCliente/Telefono';
COMMENT ON CONSTRAINT fkXIII ON TelefonoCliente IS 'Llave foranea RFC que referencia Cliente';



CREATE TABLE CorreoCliente(
	idCliente int,
	correo VARCHAR(50)
);

-- CorreoCliente Restricciones Dominio
ALTER TABLE CorreoCliente ALTER COLUMN idCliente SET NOT NULL;
ALTER TABLE CorreoCliente ALTER COLUMN correo SET NOT NULL;
ALTER TABLE CorreoCliente ADD CONSTRAINT idClienteNN CHECK(idCliente > 0);
ALTER TABLE CorreoCliente ADD CONSTRAINT correoNN CHECK(correo <> '');
ALTER TABLE CorreoCliente ADD CONSTRAINT correoRegex CHECK (correo ~ '[a-zA-Z]{10}[0-9]{3}@(yahoo|gmail|hotmail).com');

-- CorreoCliente Restricciones Referenciales
ALTER TABLE CorreoCliente ADD CONSTRAINT pk14 PRIMARY KEY(idCliente, correo);
ALTER TABLE CorreoCliente ADD CONSTRAINT fkXIV FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente) on update cascade ON DELETE CASCADE;

--Comentarios
COMMENT ON TABLE CorreoCliente IS 'Tabla que contiene los correos de los clientes';

COMMENT ON COLUMN CorreoCliente.idCLiente IS 'ID del cliente';
COMMENT ON COLUMN CorreoCliente.correo IS 'Correo del cliente';

COMMENT ON CONSTRAINT idClienteNN ON CorreoCliente IS 'Restriccion CHECK. ID del cliente debe de ser mayor que 0';
COMMENT ON CONSTRAINT correoNN ON CorreoCliente IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT correoRegex ON CorreoCliente IS 'Restriccion CHECK. El correo debe de tener un arroba y al menos un caracter antes del punto';

COMMENT ON CONSTRAINT pk14 ON CorreoCliente IS 'Llave primaria de la tabla CorreoCliente--idCliente/correo';
COMMENT ON CONSTRAINT fkXIV ON CorreoCliente IS 'Llave foranea RFC que referencia Cliente';


CREATE TABLE Proveer(
	RFC VARCHAR(13),
	nombre VARCHAR(50)
);

-- Proveer Restricciones Dominio
ALTER TABLE Proveer ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE Proveer ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Proveer ADD CONSTRAINT RFCNN CHECK(RFC <> '');
ALTER TABLE Proveer ADD CONSTRAINT nombreNN CHECK(nombre <> '');

-- Proveer Restricciones Referenciales
ALTER TABLE Proveer ADD CONSTRAINT fk1 FOREIGN KEY(RFC) REFERENCES Proveedor(RFC) on update cascade ON DELETE CASCADE;
ALTER TABLE Proveer ADD CONSTRAINT fk2 FOREIGN KEY(nombre) REFERENCES Insumo(nombre) on update cascade ON DELETE CASCADE;

--Comentarios 
COMMENT ON TABLE Proveer IS 'Tabla que contiene la información del insumo que el proveedor provee';

COMMENT ON COLUMN Proveer.RFC IS 'RFC del proveedor';
COMMENT ON COLUMN Proveer.nombre IS 'Nombre del insumo';

COMMENT ON CONSTRAINT RFCNN ON Proveer IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT nombreNN ON Proveer IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT fk1 ON Proveer IS 'Llave foranea RFC que referencia Proveedor';
COMMENT ON CONSTRAINT fk2 ON Proveer IS 'Llave foranea nombre que referencia Insumo';


CREATE TABLE Distribuir(
	tipoBioma VARCHAR(50),
	nombre VARCHAR(50)
);

-- Distribuir Restricciones Dominio
ALTER TABLE Distribuir ALTER COLUMN tipoBioma SET NOT NULL;
ALTER TABLE Distribuir ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Distribuir ADD CONSTRAINT tipoBiomaNN CHECK(tipoBioma <> '');
ALTER TABLE Distribuir ADD CONSTRAINT nombreNN CHECK(nombre <> '');

-- Distribuir Restricciones Referenciales
ALTER TABLE Distribuir ADD CONSTRAINT fk3 FOREIGN KEY(tipoBioma) REFERENCES Bioma(tipoBioma) on update cascade ON DELETE CASCADE;
ALTER TABLE Distribuir ADD CONSTRAINT fk4 FOREIGN KEY(nombre) REFERENCES Insumo(nombre) on update CASCADE ON DELETE CASCADE;

--Comentarios 
COMMENT ON TABLE Distribuir IS 'Tabla que contiene la información del insumo que se provee al Bioma';

COMMENT ON COLUMN Distribuir.tipoBioma IS 'Bioma al que se le dará el insumo';
COMMENT ON COLUMN Distribuir.nombre IS 'Nombre del insumo';

COMMENT ON CONSTRAINT tipoBiomaNN ON Distribuir IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT nombreNN ON Distribuir IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT fk3 ON Distribuir IS 'Llave foranea tippBioma que referencia Bioma';
COMMENT ON CONSTRAINT fk4 ON Distribuir IS 'Llave foranea nombre que referencia Insumo';

CREATE TABLE Trabajar(
	RFC VARCHAR(13),
	tipoBioma VARCHAR(50)
);

-- Trabajar Restricciones Dominio
ALTER TABLE Trabajar ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE Trabajar ALTER COLUMN tipoBioma SET NOT NULL;
ALTER TABLE Trabajar ADD CONSTRAINT RFCNN CHECK(RFC <> '');
ALTER TABLE Trabajar ADD CONSTRAINT tipoBiomaNN CHECK(tipoBioma <> '');

-- Trabajar Restricciones Referenciales
ALTER TABLE Trabajar ADD CONSTRAINT fk5 FOREIGN KEY(tipoBioma) REFERENCES Bioma(tipoBioma) on update cascade ON DELETE CASCADE;
ALTER TABLE Trabajar ADD CONSTRAINT fk6 FOREIGN KEY(RFC) REFERENCES Veterinario(RFC) on update cascade ON DELETE CASCADE;

--Comentarios 
COMMENT ON TABLE Trabajar IS 'Tabla que contiene la información de en que Bioma trabaja cada veterinario';

COMMENT ON COLUMN Trabajar.RFC IS 'RFC del veterinario';
COMMENT ON COLUMN Trabajar.tipoBioma IS 'Nombre del Bioma';

COMMENT ON CONSTRAINT RFCNN ON Trabajar IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT tipoBiomaNN ON Trabajar IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT fk5 ON Trabajar IS 'Llave foranea tipoBioma que referencia Bioma';
COMMENT ON CONSTRAINT fk6 ON Trabajar IS 'Llave foranea RFC que referencia Veterinario';


CREATE TABLE Servicio(
	tipoServicio VARCHAR(50),
	tipoBioma VARCHAR(50)
);

-- Servicio Restricciones Dominio
ALTER TABLE Servicio ALTER COLUMN tipoServicio SET NOT NULL;
ALTER TABLE Servicio ALTER COLUMN tipoBioma SET NOT NULL;
ALTER TABLE Servicio ADD CONSTRAINT tipoServicioNN CHECK(tipoServicio <> '');
ALTER TABLE Servicio ADD CONSTRAINT tipoBiomaNN CHECK(tipoBioma <> '');

-- Servicio Restricciones Referenciales
ALTER TABLE Servicio ADD CONSTRAINT pk16 PRIMARY KEY(tipoServicio, tipoBioma);
ALTER TABLE Servicio ADD CONSTRAINT fkXVI FOREIGN KEY(tipoBioma) REFERENCES Bioma(tipoBioma) on update cascade ON DELETE CASCADE;

--Comentarios 
COMMENT ON TABLE Servicio IS 'Tabla que contiene la información del tipo de servicio que hay en un bioma';

COMMENT ON COLUMN Servicio.tipoServicio IS 'Tipo de servicio';
COMMENT ON COLUMN Servicio.tipoBioma IS 'Tipo de Bioma';

COMMENT ON CONSTRAINT tipoServicioNN  ON Servicio IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT tipoBiomaNN ON Servicio IS 'Restriccion CHECK. La cadena no debe ser vacia';

COMMENT ON CONSTRAINT pk16 ON Servicio IS 'Llave primaria tipoServicio/tipoBioma';
COMMENT ON CONSTRAINT fkXVI ON Servicio IS 'Llave foranea tipoBioma que referencia Bioma';



CREATE TABLE Ticket(
	tipoServicio VARCHAR(50),
	tipoBioma VARCHAR(50),
	folio int,
	idCliente int,
	fecha date,
	costoUnitario money,
	descuento money
);

-- Ticket Restricciones Dominio
ALTER TABLE Ticket ALTER COLUMN tipoServicio SET NOT NULL;
ALTER TABLE Ticket ALTER COLUMN tipoBioma SET NOT NULL;
ALTER TABLE Ticket ALTER COLUMN folio SET NOT NULL;
ALTER TABLE Ticket ALTER COLUMN idCliente SET NOT NULL;
ALTER TABLE Ticket ALTER COLUMN fecha SET NOT NULL;
ALTER TABLE Ticket ALTER COLUMN costoUnitario SET NOT NULL;
ALTER TABLE Ticket ALTER COLUMN descuento SET NOT NULL;

ALTER TABLE Ticket ADD CONSTRAINT tipoServicioNN CHECK(tipoServicio <> '');
ALTER TABLE Ticket ADD CONSTRAINT tipoBiomaNN CHECK(tipoBioma <> '');
ALTER TABLE Ticket ADD CONSTRAINT folioNN CHECK(folio > 0);
ALTER TABLE Ticket ADD CONSTRAINT idClienteNN CHECK(idCliente > 0);
alter table Ticket add constraint fechaCorrecta check(fecha <= current_date);

-- Ticket Restricciones Referenciales
ALTER TABLE Ticket ADD CONSTRAINT pkVII PRIMARY KEY(tipoServicio, tipoBioma, folio);
ALTER TABLE Ticket ADD CONSTRAINT fk8 FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente) on update cascade ON DELETE CASCADE;
ALTER TABLE Ticket ADD CONSTRAINT fkVIII FOREIGN KEY(tipoBioma, tipoServicio) REFERENCES Servicio(tipoBioma, tipoServicio) on update cascade ON DELETE CASCADE;

--Comentarios 
COMMENT ON TABLE Ticket IS 'Tabla que contiene la información de los tickets que da el zoo';

COMMENT ON COLUMN Ticket.tipoServicio IS 'tipo de servicio que se ofrece';
COMMENT ON COLUMN Ticket.tipoBioma IS 'Bioma en el que se encuentra el servicio';
COMMENT ON COLUMN Ticket.folio IS 'folio del ticket';
COMMENT ON COLUMN Ticket.idCliente IS 'ID delv cliente que compró el ticket';
COMMENT ON COLUMN Ticket.fecha IS 'fecha en la que se compró el ticket';
COMMENT ON COLUMN Ticket.costoUnitario IS 'costo del ticket';
COMMENT ON COLUMN Ticket.descuento IS 'descuento del ticket';

COMMENT ON CONSTRAINT tipoServicioNN ON Ticket IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT tipoBiomaNN ON Ticket IS 'Restriccion CHECK. La cadena no debe ser vacia';
COMMENT ON CONSTRAINT folioNN ON Ticket IS 'Restriccion CHECK. El folio debe de ser mayor que 0';
COMMENT ON CONSTRAINT idClienteNN ON Ticket IS 'Restriccion CHECK.el ID del cliente debe ser mayor que 0';
COMMENT ON CONSTRAINT fechaCorrecta ON Ticket IS 'Restriccion CHECK. La fecha debe ser de hoy o anterior';


COMMENT ON CONSTRAINT pkVII ON Ticket IS 'Llave primaria tipoServicio/tipoBioma/folio';
COMMENT ON CONSTRAINT fk8 ON Ticket IS 'Llave foranea idCliente que referencia Cliente';
COMMENT ON CONSTRAINT fkVIII ON Ticket IS 'Llave foranea tipoBioma,tipoServicio que referencia Servicio';


CREATE TABLE Asistir(
	idEvento int,
	idCliente int
);

-- Asistir Restricciones Dominio
ALTER TABLE Asistir ALTER COLUMN idEvento SET NOT NULL;
ALTER TABLE Asistir ALTER COLUMN idCliente SET NOT NULL;
ALTER TABLE Asistir ADD CONSTRAINT idEventoNN CHECK(idEvento > 0);
ALTER TABLE Asistir ADD CONSTRAINT idClienteNN CHECK(idCliente > 0);

-- Asistir Restricciones Referenciales
ALTER TABLE Asistir ADD CONSTRAINT fk9 FOREIGN KEY(idEvento) REFERENCES Evento(idEvento) on update cascade ON DELETE CASCADE;
ALTER TABLE Asistir ADD CONSTRAINT fk10 FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente) on update cascade ON DELETE CASCADE;

--Comentarios 
COMMENT ON TABLE Asistir IS 'Tabla que contiene la información de los clientes que asistieron a un evento';

COMMENT ON COLUMN Asistir.idEvento IS 'ID del evento al que asistieron los clientes';
COMMENT ON COLUMN Asistir.idCliente IS 'ID del cliente que asistió al evento';

COMMENT ON CONSTRAINT idEventoNN ON Asistir IS 'Restriccion CHECK. El ID evento debe de ser mayor a 0';
COMMENT ON CONSTRAINT idClienteNN ON Asistir IS 'Restriccion CHECK. El ID cliente debe de ser mayor a 0';

COMMENT ON CONSTRAINT fk9 ON Asistir IS 'Llave foranea idEvento que referencia Evento';
COMMENT ON CONSTRAINT fk10 ON Asistir IS 'Llave foranea idCliente que referencia CLiente';




CREATE TABLE Atender(
	RFC VARCHAR(50),
	idAnimal int,
	indMedicas VARCHAR(50)
);

-- Atender Restricciones Dominio
ALTER TABLE Atender ALTER COLUMN RFC SET NOT NULL;
ALTER TABLE Atender ALTER COLUMN idAnimal SET NOT NULL;
ALTER TABLE Atender ALTER COLUMN indMedicas SET NOT NULL;
ALTER TABLE Atender ADD CONSTRAINT RFC CHECK(RFC <> '');
ALTER TABLE Atender ADD CONSTRAINT idAnimal CHECK(idAnimal > 0);
ALTER TABLE Atender ADD CONSTRAINT indMedicas CHECK(indMedicas <> '');

-- Atender Restricciones Referenciales
ALTER TABLE Atender ADD CONSTRAINT fk11 FOREIGN KEY(RFC) REFERENCES Veterinario(RFC) on update cascade ON DELETE CASCADE;
ALTER TABLE Atender ADD CONSTRAINT fk12 FOREIGN KEY(idAnimal) REFERENCES Animal(idAnimal) on update cascade ON DELETE CASCADE;

--Comentarios 
COMMENT ON TABLE Atender IS 'Tabla que contiene la información de cuales veterinarios atendieron a los distintos animales';

COMMENT ON COLUMN Atender.RFC IS 'RFC del veterinario que atendió al animal';
COMMENT ON COLUMN Atender.idAnimal IS 'ID del animal que fue atendido';
COMMENT ON COLUMN Atender.indMedicas IS 'Inidicaciones medicas que dio el veterinario';

COMMENT ON CONSTRAINT RFC ON Atender IS 'Restriccion CHECK. La cadena no debe de ser vacía';
COMMENT ON CONSTRAINT idAnimal ON Atender IS 'Restriccion CHECK. El ID animal debe de ser mayor a 0';
COMMENT ON CONSTRAINT indMedicas ON Atender IS 'Restriccion CHECK. La cadena no debe de ser vacía';

COMMENT ON CONSTRAINT fk11 ON Atender IS 'Llave foranea RFC que referencia Veterinario';
COMMENT ON CONSTRAINT fk12 ON Atender IS 'Llave foranea idAnimal que referencia Animal';









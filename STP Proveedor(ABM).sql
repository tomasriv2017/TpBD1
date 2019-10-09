/*********PROCEDIMIENTOS ALMACENADOS PARA PROVEEDORES**********/

/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarProveedor ( in _cuitProvedor varchar(45), in _razonSocial varchar(45), out cMensaje varchar(100) , out nResultado int )
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from provedor where cuitProvedor = _cuitProvedor;
    
     if (cantidadRepetida > 0 ) then
		select "El Proveedor ya existe" into cMensaje;
        select -1 into nResultado;
	else
		insert into provedor values(_cuitProvedor,_razonSocial);
		select 0 into nResultado;
    end if;
END$$
DELIMITER ;


/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarProvedor( in _cuitProvedor varchar(45) , out cMensaje varchar(100) , out nResultado int )
BEGIN
	declare cantidadRepetida int default 0;
    declare cantidadInsumo int default 0;
    select count(*) into cantidadRepetida from provedor where cuitProvedor = _cuitProvedor;
    select count(*) into cantidadInsumo from insumo_provedor where Provedor_cuitProvedor = _cuitProvedor;
    
    if(cantidadRepetida > 0) then
		if(cantidadInsumo > 0) then
			select -1 into nResultado;
            select "No Se Puede eliminar el proveedor debido a que tiene uno o mas insumos" into cMensaje;
		else
			select 0 into nResultado;
            delete from provedor where cuitProvedor = _cuitProvedor;
		end if;
	else
		select -2 into nResultado;
        select "El Proveedor que quiere eliminar no existe" into cMensaje;
	end if;
END$$
DELIMITER ;


/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarProvedor( in _cuitProvedor varchar(45), in nueva_cuitProvedor varchar(45) ,in nueva_razonSocial varchar(45) , out cMensaje varchar(45) , out nResultado int)
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from provedor where cuitProvedor = _cuitProvedor;
    
    if(cantidadRepetida > 0) then
		if( nueva_cuitProvedor <> (select cuitProvedor from provedor where cuitProvedor = _cuitProvedor) 
			and nueva_razonSocial <> (select razonSocial from provedor where cuitProvedor = _cuitProvedor) ) then
            
			UPDATE provedor set cuitProvedor = nueva_cuitProvedor , razonSocial = nueva_razonSocial where cuitProvedor = _cuitProvedor;
            select 0 into nResultado;
		
        else 
			select -1 into nResultado;
            select "Error al Modificar debido a que esta ingresando uno o mas datos repetidos" into cMensaje;
		end if;
    else
		select -2 into nResultado;
		select "El Proveedor que quiere modificar no existe" into cMensaje;
	
    end if;
END$$
DELIMITER ;
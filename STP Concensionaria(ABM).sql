/*********PROCEDIMIENTOS ALMACENADOS PARA CONCENSIONARIA**********/

/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarConcensionaria ( in _cuitConcensionaria varchar(45), in _razonSocial varchar(45) , out cMensaje varchar(45) , out nResultado int )
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from concensionaria where cuitConcensionaria = _cuitConcensionaria;
    
    if (cantidadRepetida > 0 ) then
		select "La Concensionaria ya existe" into cMensaje;
        select -1 into nResultado;
	else
		insert into concensionaria values(_cuitConcensionaria,_razonSocial);
		select 0 into nResultado;
    end if;

END$$
DELIMITER ;


/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarConcensionaria( in _cuitConcensionaria varchar(45) ,out cMensaje varchar(100) , out nResultado int)
BEGIN
	declare cantidadRepetida int default 0;
    declare cantidadPedido int default 0;
    select count(*) into cantidadRepetida from concensionaria where cuitConcensionaria = _cuitConcensionaria;
    select count(*) into cantidadPedido from pedido where fk_cuitConcensionaria = _cuitConcensionaria;
    
    if(cantidadRepetida > 0) then
		if(cantidadPedido > 0) then
			select -1 into nResultado;
            select "No Se Puede eliminar la concensionaria debido a que tiene uno o mas pedidos" into cMensaje;
		else
			select 0 into nResultado;
            delete from concensionaria where cuitConcensionaria = _cuitConcensionaria;
		end if;
	else
		select -2 into nResultado;
        select "La Concensionaria que quiere eliminar no existe" into cMensaje;
	end if;
END$$
DELIMITER ;


/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarConcensionaria( in _cuitConcensionaria varchar(45) , in nueva_cuitConcensionaria varchar(45), in nueva_razonSocial varchar(45) , out cMensaje varchar(100),out nResultado int )
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from concensionaria where cuitConcensionaria = _cuitConcensionaria;
    
    if(cantidadRepetida > 0) then
		if( nueva_cuitConcensionaria <> (select cuitConcensionaria from concensionaria where cuitConcensionaria = _cuitConcensionaria) 
			and nueva_razonSocial <> (select razonSocial from concensionaria where cuitConcensionaria = _cuitConcensionaria) ) then
            
			UPDATE concensionaria set cuitConcensionaria = nueva_cuitConcensionaria , razonSocial = nueva_razonSocial where cuitConcensionaria = _cuitConcensionaria;
            select 0 into nResultado;
		
        else 
			select -1 into nResultado;
            select "Error al Modificar debido a que esta ingresando uno o mas datos repetidos" into cMensaje;
		end if;
    else
		select -2 into nResultado;
		select "La Concensionaria que quiere modificar no existe" into cMensaje;
	
    end if;
END$$
DELIMITER ;








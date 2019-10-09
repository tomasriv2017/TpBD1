/*********PROCEDIMIENTOS ALMACENADOS PARA INSUMO**********/

/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarInsumo ( in _descripcionInsumo varchar(45), in _precio double, out cMensaje varchar(100) , out nResultado int)
BEGIN
	declare _idInsumo int;
	declare cantidadRepetida int default 0;
	
    set _idInsumo = coalesce( (select max(idInsumo) from insumo)+1 , 1 ); -- INCREMENTA id INSUMO AUTOMATICAMENTE
    select count(*) into cantidadRepetida from insumo where descripcionInsumo = _descripcionInsumo;
    
    if (cantidadRepetida > 0 ) then
		select "El Insumo ya existe" into cMensaje;
        select -1 into nResultado;
	else
		insert into insumo values(_idInsumo,_descripcionInsumo,_precio);
		select 0 into nResultado;
    end if;
END$$
DELIMITER ;


/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarInsumo ( in _idInsumo int ,  out cMensaje varchar(100) , out nResultado int)
BEGIN
	declare cantidadRepetida int default 0;
    declare cantidadProveedor int default 0;
    select count(*) into cantidadRepetida from insumo where descripcionInsumo = _descripcionInsumo;
    select count(*) into cantidadProveedor from insumo_provedor where Insumo_idInsumo = _idInsumo;
    
    if(cantidadRepetida > 0) then
		if(cantidadProveedor > 0) then
			select -1 into nResultado;
            select "No Se Puede eliminar el insumo debido a que lo tiene un proveedor" into cMensaje;
		else
			select 0 into nResultado;
            delete from insumo where idInsumo = _idInsumo;
		end if;
	else
		select -2 into nResultado;
        select "El Insumo que quiere eliminar no existe" into cMensaje;
	end if;
END$$
DELIMITER ;


/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarInsumo( in _idInsumo int, in nueva_descripcionInsumo varchar(45), in nuevo_precio double , out cMensaje varchar(100) , out nResultado int )
BEGIN
	declare cantidadReeptida int default 0;
	select count(*) into cantidadRepetida from insumo where idInsumo = _idInsumo;
    
    if(cantidadRepetida > 0) then
		if( nueva_descripcionInsumo <> (select descripcionInsumo from insumo where idInsumo = _idInsumo) and
			nuevo_precio <> (select precio from insumo where idInsumo = _idInsumo) ) then
			
            update insumo set descripcionInsumo = nueva_descripcionInsumo , precio = nuevo_precio where idInsumo = _idInsumo;
            select 0 into nResultado;
		else
			select -1 into nResultado;
			select "No Se Puede Modificar debido a que se repiten uno o mas datos" into cMensaje;
		end if;
	
    else
		select -2 into nResultado;
        select "El Insumo que quiere modificar no Existe" into cMensaje;
	end if;
END$$
DELIMITER ;



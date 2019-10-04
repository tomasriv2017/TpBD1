/*********PROCEDIMIENTOS ALMACENADOS PARA INSUMO**********/

/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarInsumo (in _idInsumo int, in _descripcionInsumo varchar(45), in _precio double , out cMensaje varchar(45) , out nResultado int )
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from insumo where idInsumo = _idInsumo;
   set _idInsumo = coalesce( (select max(idInsumo) from insumo)+1 , 1 );  -- INCREMENTA INSUMO AUTOMATICAMENTE
      if (cantidadRepetida > 0 ) then
		select "El insumo ya existe" into iMensaje;
	  select -1 into nResultado;
	  else

		insert into insumo values(_idInsumo,_descripcionInsumo,_precio);
		select 0 into nResultado;
      end if;

END$$
DELIMITER ;

/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarInsumo( in _idInsumo int ,out cMensaje varchar(100) , out nResultado int)
BEGIN
	declare cantidadRepetida int default 0;
select count(*) into cantidadRepetida from insumo where idInsumo = _idInsumo;
   
    if(cantidadRepetida > 0) then
	delete from insumo where idInsumo = _idInsumo;
    	else
		select -1 into nResultado;
	select "El Insumo que quiere eliminar no existe" into cMensaje;
     	end if;
END$$
DELIMITER ;

/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarInsumo( in _idInsumo int, in _descripcionInsumo varchar(45), in _precio double ,out cMensaje varchar(100) , out nResultado int)
BEGIN
	declare cantidadRepetida int default 0;
select count(*) into cantidadRepetida from insumo where idInsumo = _idInsumo;
   
    if(cantidadRepetida > 0) then
	UPDATE insumo set descripcionInsumo = _descripcionInsumo , precio = _precio 
        where idInsumo = _idInsumo;
    	else
		select -1 into nResultado;
	select "El Insumo que quiere eliminar no existe" into cMensaje;
     	end if;
END$$
DELIMITER ;
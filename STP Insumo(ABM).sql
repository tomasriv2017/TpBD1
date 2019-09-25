/*********PROCEDIMIENTOS ALMACENADOS PARA INSUMO**********/

/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarInsumo ( in _descripcionInsumo varchar(45), in _precio double )
BEGIN
	declare _idInsumo int;
    set _idInsumo = coalesce( (select max(idInsumo) from insumo)+1 , 1 ); -- INCREMENTA INSUMO AUTOMATICAMENTE
	insert into insumo(idInsumo,descripcionInsumo,precio)
	values(_idInsumo,_descripcionInsumo,_precio);
END$$
DELIMITER ;


/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarInsumo ( in _idInsumo int )
BEGIN
	delete from insumo where idInsumo = _idInsumo;
END$$
DELIMITER ;


/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarInsumo( in _idInsumo int, in _descripcionInsumo varchar(45), in _precio double )
BEGIN
		UPDATE insumo set descripcionInsumo = _descripcionInsumo , precio = _precio 
        where idInsumo = _idInsumo;
END$$
DELIMITER ;



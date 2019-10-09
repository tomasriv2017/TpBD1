/*********PROCEDIMIENTOS ALMACENADOS PARA PROVEEDORES**********/

/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarProveedor ( in _cuitProvedor varchar(45), in _razonSocial varchar(45) )
BEGIN
	insert into provedor values(_cuitProvedor,_razonSocial);
END$$
DELIMITER ;


/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarProvedor( in _cuitProvedor varchar(45) )
BEGIN
	delete from provedor where cuitProvedor = _cuitProvedor;
END$$
DELIMITER ;


/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarProvedor( in _cuitProvedor varchar(45), in _razonSocial varchar(45) )
BEGIN
		UPDATE provedor set razonSocial = _razonSocial where cuitProvedor = _cuitProvedor;
END$$
DELIMITER ;
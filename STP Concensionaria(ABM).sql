/*********PROCEDIMIENTOS ALMACENADOS PARA CONCENSIONARIA**********/

/*ALTA*/
DELIMITER $$
CREATE PROCEDURE stp_agregarConcensionaria ( in _cuitConcensionaria varchar(45), in _razonSocial varchar(45) )
BEGIN
	insert into concensionaria values(_cuitConcensionaria,_razonSocial);
END$$
DELIMITER ;


/*BAJA*/
DELIMITER $$
CREATE PROCEDURE stp_eliminarConcensionaria( in _cuitConcensionaria varchar(45) )
BEGIN
	delete from concensionaria where cuitConcensionaria = _cuitConcensionaria;
END$$
DELIMITER ;


/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE stp_modificarConcensionaria( in _cuitConcensionaria varchar(45), in _razonSocial varchar(45) )
BEGIN
		UPDATE concensionaria set razonSocial = _razonSocial where cuitConcensionaria = _cuitConcensionaria;
END$$
DELIMITER ;



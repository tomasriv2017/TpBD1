/*********PROCEDIMIENTOS ALMACENADOS PARA PEDIDOS**********/
/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarPedido(in _idPedido int , in _idModeloVehiculo int, in cantidadPedido int , in fechaPedido datetime , in cuitConcensionaria varchar(45) , out cMensaje varchar(100) , out nResultado int)
BEGIN    
	-- CODIGO
END$$
DELIMITER ;


/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarPedido( in _idPedido int ,  in _idModeloVehiculo int )
BEGIN
	-- CODIGO
END$$
DELIMITER ;


/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarPedido( in _idPedido int, in _idModeloVehiculo int , in nueva_cantidadPedido int , in nueva_fechaPedido datetime )
BEGIN
	-- CODIGO
END$$
DELIMITER ;

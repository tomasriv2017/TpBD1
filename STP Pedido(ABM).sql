/*********PROCEDIMIENTOS ALMACENADOS PARA PEDIDOS**********/
/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarPedido( in _idModeloVehiculo int, in _fechaPedido datetime, in _descripcionPedido varchar(45) , in _cuitConcensionaria varchar(45) , in _cantPedido int )
BEGIN
	DECLARE _idPedido int default 0;
    
    set _idPedido = coalesce( (select max(idPedido) from pedido)+1 , 1 );
	insert into pedido values(_idPedido, _fechaPedido, _descripcionPedido, _cuitConcensionaria);
    
    insert into detalle_pedido values(_idModeloVehiculo , _idPedido, _cantPedido);
END$$
DELIMITER ;


/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarPedido( in _idPedido int ,  in _idModeloVehiculo int )
BEGIN
	delete from detalle_pedido where Pedido_idPedido = _idPedido and ModeloVehiculo_idModeloVehiculo = _idModeloVehiculo;
    delete from pedido where idPedido = _idPedido;
END$$
DELIMITER ;


/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarPedido( in _idPedido int, in _idModeloVehiculo int , in _fechaPedido datetime, in _descripcionPedido varchar(45) , in _cantPedido int )
BEGIN
		UPDATE pedido set fechaPedido = _fechaPedido , descripcionPedido = _descripcionPedido where idPedido = _idPedido;
        UPDATE detalle_pedido set cantPedido = _cantPedido where Pedido_idPedido = _idPedido and ModeloVehiculo_idModeloVehiculo = _idModeloVehiculo;
END$$
DELIMITER ;

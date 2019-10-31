/*********PROCEDIMIENTOS ALMACENADOS PARA PEDIDOS**********/
/*ALTA*/
DELIMITER $$
CREATE PROCEDURE agregarPedido(in _idPedido int , in _idLineaMontaje int, in _cantidadPedido int , in _fechaPedido datetime , in _cuitConcensionaria varchar(45) , out cMensaje varchar(100) , out nResultado int)
BEGIN    
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from pedido where idPedido = _idPedido;
	
	if( cantidadRepetida > 0) then
    	select 0 into nResultado;
		insert into detalle_pedido values(_idLineaMontaje,_idPedido,_cantidadPedido);
    
    else
		select 0 into nResultado;
        insert into pedido values(_idPedido , _fechaPedido , _cuitConcensionaria);
        insert into detalle_pedido values(_idLineaMontaje , _idPedido , _cantidadPedido);
        
    end if;
END$$
DELIMITER ;


/*BAJA*/
DELIMITER $$
CREATE PROCEDURE eliminarPedido( in _idPedido int , out cMensaje varchar(100) , out nResultado int )
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from detalle_pedido where  Pedido_idPedido = _idPedido;
															
    if(cantidadRepetida > 0) then
		select 0 into nResultado;
        delete from detalle_pedido where Pedido_idPedido = _idPedido;
        delete from pedido where idPedido = _idPedido;
	
    else
		select -1 into nResultado;
        select "El Pedido que quiere eliminar no existe" into cMensaje;
	end if;
END$$
DELIMITER ;


/*MODIFICACION*/
DELIMITER $$
CREATE PROCEDURE modificarPedido( in _idPedido int, in _idLineaMontaje int , in nueva_cantidadPedido int , in nueva_fechaPedido datetime , in nuevo_cuitConcensionaria varchar(45) , out cMensaje varchar(100) , out nResultado int )
BEGIN
	declare cantidadRepetida int default 0;
    select count(*) into cantidadRepetida from detalle_pedido where LineaMontaje_idLineaMontaje = _idLineaMontaje and
																		Pedido_idPedido = _idPedido;
    if(cantidadRepetida > 0) then
		if(nueva_cantidadPedido <> (select cantPedido from detalle_pedido where LineaMontaje_idLineaMontajeo = _idLineaMontaje and Pedido_idPedido = _idPedido) 
			and nueva_fechaPedido <> (select fechaPedido from pedido where idPedido = _idPedido ) and nuevo_cuitConcensionaria <> (select fk_cuitConcensionaria from pedido where idPedido = _idPedido) ) then
			
            select 0 into nResultado;
            update pedido set fechaPedido = nueva_fechaPedido, fk_cuitConcensionaria = nuevo_cuitConcensionaria where idPedido = _idPedido;
            update detalle_pedido set cantPedido = nueva_cantidadPedido where LineaMontaje_idLineaMontaje = _idLineaMontaje and Pedido_idPedido = _idPedido;
		
        else
			select -1 into nResultado;
            select "No Se Puede Modificar debido a que estan repitiendo uno o mas datos" into cMensaje;
		end if;
        
	else 
		select -2 into nResultado;
        select "El Pedido que quiere modificar no existe" into cMensaje;
	end if;
END$$
DELIMITER ;

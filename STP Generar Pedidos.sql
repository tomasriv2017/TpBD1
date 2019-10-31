CREATE DELIMITER $$
CREATE PROCEDURE generarPedido (in _idPedido int )
BEGIN
	DECLARE idChasis INT;
	DECLARE idLineaMontajeParametro INT;
        
    DECLARE finished int default 0;
	DECLARE nCantidadDetalle INT; 
	DECLARE nInsertados INT;

	-- DECLARO EL CURSOR CON LA TABLA detalle_pedido
	DECLARE curPedido
        CURSOR FOR
             SELECT LineaMontaje_idLineaMontaje , cantPedido FROM detalle_pedido WHERE Pedido_idPedido = _idPedido;

	-- ESTO HAY QUE PONERLO SIEMPRE
    DECLARE CONTINUE HANDLER
        FOR NOT FOUND SET finished = 1;
 
 
    OPEN curPedido; -- abro el cursor
	
    set idChasis = coalesce((select max(chasis) from automovil), 0);-- CON ESTO LO QUE CONSIGO ES TENER SIEMPRE EL ULTIMO NUMERO DE CHASIS PARA QUE NO SE REPITA
 
  
   -- comienzo el loop recorriendo el cursor.
    loop_pedido: LOOP
 
        FETCH curPedido INTO idLineaMontajeParametro , nCantidadDetalle;

        IF finished = 1 THEN
            LEAVE loop_pedido;
        END IF;
  
		SET nInsertados = 0;
		-- Aca loopeo para hacer N inserts.
		WHILE nInsertados < nCantidadDetalle DO
			
         -- genero la chasis 
			set idChasis = idChasis + 1;
			INSERT INTO automovil VALUES ( idChasis ,now(),NULL, idLineaMontajeParametro , _idPedido );
		 
			SET nInsertados = nInsertados  +1; 
	 
		END WHILE;
 
    END LOOP loop_pedido;
 
-- Elimino el cursor de memoria
	CLOSE curPedido;
END $$
DELIMITER ;

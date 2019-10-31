CREATE DELIMITER $$
create procedure continuarMontaje(in _chasis int , out chasisOcupado int ,out cMensaje varchar(100), out nResultado int)
 BEGIN
	DECLARE cantidadRepetida int default 0;
    
    DECLARE i int default 0;
    DECLARE limite int default 0;
    DECLARE finished int default 0 ;
    
    DECLARE idEstacionTrabajoActual int;
	DECLARE idEstacionTrabajoSiguente int;
    
    -- CON LOS CURSORES SACO LA SIGUENTE ESTACION DE LA LINEA DE MONTAJE DEL AUTOMOVIL
    DECLARE curEstacion CURSOR FOR SELECT idEstacionTrabajo from lineamontaje inner join estaciontrabajo on lineaMontaje = idLineaMontaje
									where idLineaMontaje in (select idLineaMontajeAsignada from automovil where chasis = _chasis);
	DECLARE CONTINUE HANDLER
        FOR NOT FOUND SET finished = 1;
        
    OPEN curEstacion;
    
    -- USO EL BUCLE WHILE PARA DETERMINAR LA SIGUENTE ESTACION DE TRABAJO CON LOS CURSORES
    select count(*) into limite from automovil_estaciontrabajo where Automovil_chasis = _chasis;
    WHILE i <= limite and finished != 1 DO
		FETCH curEstacion INTO idEstacionTrabajoSiguente;	
		set i = i + 1;
    end WHILE;
    
    CLOSE curEstacion; 
    
    -- ACA SACO LA ESTACION ACTUAL DEL CURSOR
    SELECT max(EstacionTrabajo_idEstacionTrabajo) into idEstacionTrabajoActual FROM automovil_estaciontrabajo  where Automovil_chasis = _chasis ;
    
    -- PRIMERO ME FIJO SI LA ESTACION ACTUAL NO ES LA ULTIMA DEL AUTOMOVIL
    IF(idEstacionTrabajoActual = (SELECT max(idEstacionTrabajo) FROM estaciontrabajo where 
									lineaMontaje = (select idLineaMontajeAsignada from automovil where chasis = _chasis)) )then
                                    
			-- AL SER LA ULTIMA ESTACION DEL AUTOMOVIL SE DA POR FINALIZADA Y SE REGISTRA EN EL AUTOMOVIL SU FECHA DE FINALIZACION
            UPDATE automovil_estaciontrabajo SET fechaHoraEgreso = now() WHERE EstacionTrabajo_idEstacionTrabajo = idEstacionTrabajoActual;
            UPDATE automovil SET fechaFinalizacion = now() WHERE chasis = _chasis;
    ELSE
    
    -- ACA ME FIJO SI LA SIG ESTACION DE TRABAJO DEL AUTOMOVIL ESTA VACIA
		SELECT count(*) into cantidadRepetida from automovil_estaciontrabajo 
											where EstacionTrabajo_idEstacionTrabajo = idEstacionTrabajoSiguente and fechaHoraEgreso is null;
                                            
		if(cantidadRepetida > 0) then
			select -1 into nResultado;
			select 'No Se Puede Agregar a la estacion debido a que esta siendo ocupada por otro automovil' into cMensaje;
			
			Select Automovil_chasis into chasisOcupado from automovil_estaciontrabajo
								where EstacionTrabajo_idEstacionTrabajo = idEstacionTrabajoSiguente and fechaHoraEgreso is null ;
		else        
			-- SE DA POR FINALIZADO LA ACTUAL ESTACION DE TRABAJO PONIENDOLE LA FECHA Y HORA DE EGRESO
			UPDATE automovil_estaciontrabajo SET fechaHoraEgreso = now() WHERE EstacionTrabajo_idEstacionTrabajo = idEstacionTrabajoActual;
			
			-- SE CREAR EL NUEVO REGISTRO EN LA PROXIMA ESTACION DE TRABAJO DEL AUTOMOVIL
			INSERT INTO automovil_estaciontrabajo values(_chasis,idEstacionTrabajoSiguente,now() ,NULL); 
		end if;
        
	END IF;
 END$$
 

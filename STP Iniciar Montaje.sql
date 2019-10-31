CREATE DELIMITER //
create procedure inicarMontaje(in _chasis int , out chasisOcupado int ,out cMensaje varchar(100), out nResultado INT )
BEGIN
	DECLARE cantidadRepetida int;
	DECLARE estacionTrabajoAsignada int;
    
	select count(*) into cantidadRepetida from automovil_estaciontrabajo 
					where EstacionTrabajo_idEstacionTrabajo = (select min(idEstacionTrabajo) from estaciontrabajo 
							where lineaMontaje = (select idLineaMontajeAsignada from automovil where chasis = _chasis)) and fechaHoraEgreso is null; 
			
	if(cantidadRepetida > 0) then
		select -1 into nResultado;
        select 'No Se Puede Agregar a la estacion debido a que esta siendo ocupada por otro automovil' into cMensaje;
		
        Select Automovil_chasis into chasisOcupado from automovil_estaciontrabajo where EstacionTrabajo_idEstacionTrabajo =(select min(idEstacionTrabajo) from estaciontrabajo  
						where lineamontaje = (select idLineaMontajeAsignada from automovil where chasis = _chasis)) and fechaHoraEgreso is null;
    
    else
		SET estacionTrabajoAsignada = (select min(idEstacionTrabajo) from estaciontrabajo 
											where lineaMontaje = (SELECT idLineaMontajeAsignada from automovil where chasis = _chasis ));
        select 0 into nResultado;
        insert into automovil_estaciontrabajo values (_chasis , estacionTrabajoAsignada , now(),NULL);
    end if;
END//


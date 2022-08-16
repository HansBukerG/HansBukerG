
/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, proceso_control_de_turnos,Totem_marcha_blanca, cb_ingresar(boton)
	
	
	@-Parametro_Entrada0: Rut

	@-Parametro_Salida0: SI
	@-Parametro_Salida1: NO
 
	@-Descripcion_Objeto0: sp para identificar el origen del rut ingresado
	@-Regla_Objeto0: se debe ingresar un rut previamente para poder ser utilizado
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_verificar_alumno 18389381;
	
FIN_DATOS_PROCEDIMIENTO**/	


create proc dbo.pb_verificar_alumno
(
   @Rut             integer
) 
as
if exists(select 	*	from  	academia..alumno m1 where  m1.alu_rut = @Rut)
select  'SI' as tipo
else
select 'NO' as tipo
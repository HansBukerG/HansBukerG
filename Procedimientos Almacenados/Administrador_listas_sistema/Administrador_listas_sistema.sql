/**INICIO_DATOS_TABLA	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 29-06-2018
	@-usado_por0: , , 
	
	@-Parametro_Entrada0: mae_rut
	@-Parametro_Entrada1: als_password

	@-Descripcion_Objeto0: Esta Tabla contiene el manejo de los administradores de la oficina de reparticion con respecto a la visualizacion de sus contenidos
	@-Regla_Objeto0: 
	@-String_Prueba0: select * from documentos_ubb.dbo.ADMINISTRADOR_LISTAS_SISTEMA
	
FIN_DATOS_PROCEDIMIENTO**/	
	
	
CREATE TABLE dbo.ADMINISTRADOR_LISTAS_SISTEMA(	
	mae_rut integer,	
	als_password varchar(250)
);

/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, Totem_marcha_blanca,proceso_control_de_turnos, cb_ingresar(boton)
	
	
	@-Parametro_Entrada0: FILA_YEAR
	@-Parametro_Entrada1: FILA_CODIGO
	@-Parametro_Entrada2: OFRE_CODIGO
	@-Parametro_Entrada3: REP_CODIGO
	@-Parametro_Entrada4: EDU_CODIGO
	@-Parametro_Entrada5: FILA_RUT
	@-Parametro_Entrada6: FILA_FECHA_REGISTRO
	@-Parametro_Entrada7: FILA_LOG_REGISTRO

	@-Descripcion_Objeto0: Ingresa registro de rut en la tabla filas_atencion
	@-Regla_Objeto0: Debe existir una oficina de reparticion para poder crear una fila
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_insertar_fila_atencion;
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_insertar_fila_atencion
	(
			@FILA_YEAR           		integer
		,	@FILA_CODIGO          		integer
		,	@OFRE_CODIGO          		integer
		,	@REP_CODIGO           		decimal
		,	@EDU_CODIGO           		integer
		,	@FILA_RUT             		integer
		,	@FILA_FECHA_REGISTRO  		datetime
		,	@FILA_LOG_REGISTRO    		varchar(250)          
   	) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

insert into DOCUMENTOS_UBB.dbo.filas_atencion with(updlock)
(
			FILA_YEAR
		,	FILA_CODIGO
		,	OFRE_CODIGO
		,	REP_CODIGO
		,	EDU_CODIGO
		,	FILA_RUT
		,	FILA_FECHA_REGISTRO
		,	FILA_LOG_REGISTRO    
)
values 
(
			@FILA_YEAR
		,	@FILA_CODIGO
		,	@OFRE_CODIGO
		,	@REP_CODIGO
		,	@EDU_CODIGO
		,	@FILA_RUT
		,	@FILA_FECHA_REGISTRO
		,	@FILA_LOG_REGISTRO
);

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
	
	@-Parametro_Entrada0: OFRE_CODIGO
	@-Parametro_Entrada1: cco_codigo
	@-Parametro_Entrada2: REP_CODIGO
	@-Parametro_Entrada3: EDU_CODIGO
	@-Parametro_Entrada4: mae_rut
	@-Parametro_Entrada5: USOF_CODIGO
	@-Parametro_Entrada6: USOF_FECHA_INICIO
	@-Parametro_Entrada7: USOF_FECHA_TERMINO
	@-Parametro_Entrada8: USOF_FECHA_REGISTRO
	@-Parametro_Entrada9: USOF_LOG_REGISTRO
	@-Descripcion_Objeto0: SP encargado de ingresar un funcionario a una oficina de reparticion
	@-Regla_Objeto0: Debe existir una oficina de reparticion para poder ingresar al funcionario
	@-String_Prueba0: EXEC Documentos_ubb.dbo.insertar_usuarios_oficina;

FIN_DATOS_PROCEDIMIENTO**/	

alter proc dbo.insertar_usuarios_oficina
(
	@OFRE_CODIGO int,
	@cco_codigo decimal,
	@REP_CODIGO decimal,
	@EDU_CODIGO int,
	@mae_rut decimal,
	@USOF_CODIGO int,
	@USOF_FECHA_INICIO datetime,
	@USOF_FECHA_TERMINO datetime,
	@USOF_FECHA_REGISTRO datetime,
	@USOF_LOG_REGISTRO varchar(250)
) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	insert into DOCUMENTOS_UBB.dbo.USUARIOS_OFICINA 
	with(updlock)
	(
		OFRE_CODIGO,
		cco_codigo,
		REP_CODIGO,
		EDU_CODIGO,
		mae_rut,
		USOF_CODIGO,
		USOF_FECHA_INICIO,
		USOF_FECHA_TERMINO,
		USOF_FECHA_REGISTRO,
		USOF_LOG_REGISTRO
	)
	values 
	(
		@OFRE_CODIGO,
		@cco_codigo,
		@REP_CODIGO,
		@EDU_CODIGO,
		@mae_rut,
		@USOF_CODIGO,
		@USOF_FECHA_INICIO,
		@USOF_FECHA_TERMINO,
		@USOF_FECHA_REGISTRO,
		@USOF_LOG_REGISTRO
	);

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
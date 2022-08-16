/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, dw_tipo_programa_consulta_modulo
	
	
	@-Parametro_Entrada0: TPR_CORRELATIVO
	@-Parametro_Entrada1: MOD_CODIGO
	@-Parametro_Entrada2: OFRE_CODIGO
	@-Parametro_Entrada3: REP_CODIGO
	@-Parametro_Entrada4: EDU_CODIGO
	@-Parametro_Entrada5: FECHA_REGISTRO
	@-Parametro_Entrada6: LOG_REGISTRO

	@-Descripcion_Objeto0: Agrega un tipo de programa a un mòdulo de atenciòn
	@-Regla_Objeto0: Debe existir un modulo creado para poder asigar un tipo de programa
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modulo_atiende_agregar;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_modulo_atiende_agregar
(
	@TPR_CORRELATIVO		int
	,@MOD_CODIGO		int
	,@OFRE_CODIGO		int
	,@REP_CODIGO		int
	,@EDU_CODIGO		int
	,@FECHA_REGISTRO	datetime
	,@LOG_REGISTRO		varchar(250)
)
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	insert into documentos_ubb.dbo.MODULO_ATIENDE
	(
		TPR_CORRELATIVO
		,MOD_CODIGO
		,OFRE_CODIGO
		,REP_CODIGO
		,EDU_CODIGO
		,FECHA_REGISTRO
		,LOG_REGISTRO
	)values
	(
		@TPR_CORRELATIVO
		,@MOD_CODIGO
		,@OFRE_CODIGO
		,@REP_CODIGO
		,@EDU_CODIGO
		,@FECHA_REGISTRO
		,@LOG_REGISTRO
	)

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
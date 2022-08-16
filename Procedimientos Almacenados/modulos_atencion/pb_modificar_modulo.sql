/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores 
	
	@-Parametro_Entrada0: MOD_CODIGO
	@-Parametro_Entrada1: OFRE_CODIGO
	@-Parametro_Entrada2: CCO_CODIGO
	@-Parametro_Entrada3: REP_CODIGO
	@-Parametro_Entrada4: EDU_CODIGO
	@-Parametro_Entrada5: MOD_NOMBRE
	@-Parametro_Entrada6: MOD_ABREVIACION
	@-Parametro_Entrada7: MOD_FECHA_INICIO
	@-Parametro_Entrada8: MOD_FECHA_TERMINO
	@-Parametro_Entrada9: MOD_FECHA_REGISTRO
	@-Parametro_Entrada10: MOD_LOG_REGISTRO

	@-Descripcion_Objeto0: Modifica los parametros de un módulo de atención
	@-Regla_Objeto0: Debe existir un módulo de atención para poder modificarlo
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modificar_modulo;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_modificar_modulo
(
	@MOD_CODIGO				integer,
	@OFRE_CODIGO			integer,
	@CCO_CODIGO				decimal,
	@REP_CODIGO				decimal,
	@EDU_CODIGO				integer,
	@MOD_NOMBRE				varchar(250),
	@MOD_ABREVIACION		varchar(250),
	@MOD_FECHA_INICIO		datetime,
	@MOD_FECHA_TERMINO		datetime,
	@MOD_FECHA_REGISTRO		datetime,
	@MOD_LOG_REGISTRO		varchar(250)               
) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	UPDATE DOCUMENTOS_UBB.dbo.modulos_atencion 
	with(updlock)
	SET   MOD_NOMBRE			= @MOD_NOMBRE
	,     MOD_ABREVIACION		= @MOD_ABREVIACION
	,     MOD_FECHA_INICIO		= @MOD_FECHA_INICIO
	,     MOD_FECHA_TERMINO 	= @MOD_FECHA_TERMINO
	,     MOD_FECHA_REGISTRO	= @MOD_FECHA_REGISTRO
	,     MOD_LOG_REGISTRO		= @MOD_LOG_REGISTRO
	WHERE    MOD_CODIGO   = @MOD_CODIGO
	and      OFRE_CODIGO    = @OFRE_CODIGO
	and      CCO_CODIGO   = @CCO_CODIGO
	and      REP_CODIGO    = @REP_CODIGO
	and      EDU_CODIGO    = @EDU_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
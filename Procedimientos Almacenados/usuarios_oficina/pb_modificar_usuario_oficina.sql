/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
	
	@-Parametro_Entrada0: OFRE_CODIGO
	@-Parametro_Entrada1: CCO_CODIGO
	@-Parametro_Entrada2: REP_CODIGO
	@-Parametro_Entrada3: EDU_CODIGO
	@-Parametro_Entrada4: USOF_CODIGO
	@-Parametro_Entrada5: USOF_FECHA_INICIO
	@-Parametro_Entrada6: USOF_FECHA_TERMINO
	@-Parametro_Entrada7: USOF_FECHA_REGISTRO
	@-Parametro_Entrada8: USOF_LOG_REGISTRO

	@-Descripcion_Objeto0: SP encargado de modificar el registro de fecha de un funcionario en una oficina
	@-Regla_Objeto0: Debe existir una oficina con funcionarios para poderlos modificar
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modificar_usuario_oficina;
FIN_DATOS_PROCEDIMIENTO**/	

alter proc dbo.pb_modificar_usuario_oficina
(
 @OFRE_CODIGO          integer,
 @CCO_CODIGO           decimal,
 @REP_CODIGO           decimal,
 @EDU_CODIGO           integer,
 @USOF_CODIGO          integer,
 @USOF_FECHA_INICIO    datetime,
 @USOF_FECHA_TERMINO   datetime,
 @USOF_FECHA_REGISTRO  datetime,
 @USOF_LOG_REGISTRO    varchar(250)
) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	UPDATE DOCUMENTOS_UBB.dbo.USUARIOS_OFICINA with(updlock)
	SET   	USOF_FECHA_TERMINO  = @USOF_FECHA_TERMINO
	,		USOF_FECHA_INICIO  = @USOF_FECHA_INICIO
	,     	USOF_FECHA_REGISTRO = @USOF_FECHA_REGISTRO
	,     	USOF_LOG_REGISTRO   = @USOF_LOG_REGISTRO

	WHERE    OFRE_CODIGO =  @OFRE_CODIGO
	and      CCO_CODIGO  =  @CCO_CODIGO
	and      REP_CODIGO  =  @REP_CODIGO
	and      EDU_CODIGO  =  @EDU_CODIGO
	and      USOF_CODIGO =  @USOF_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
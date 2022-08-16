/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
	
	@-Parametro_Entrada0: SEMA_CODIGO
	@-Parametro_Entrada1: SERV_CODIGO
	@-Parametro_Entrada2: CATE_CODIGO
	@-Parametro_Entrada3: OFRE_CODIGO
	@-Parametro_Entrada4: CCO_CODIGO
	@-Parametro_Entrada5: REP_CODIGO
	@-Parametro_Entrada6: EDU_CODIGO

	@-Descripcion_Objeto0: SP encargado de eliminar la asignacion de maeper a un servicio
	@-Regla_Objeto0: Debe existir una asignacion a un servicio primero para poderla eliminar
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_eliminar_servicio_maeper;


FIN_DATOS_PROCEDIMIENTO**/	

alter proc dbo.pb_eliminar_servicio_maeper
(
		@SEMA_CODIGO          integer
	,   @SERV_CODIGO          integer
	,   @CATE_CODIGO          integer
	,   @OFRE_CODIGO          integer
	,   @CCO_CODIGO           decimal
	,   @REP_CODIGO           decimal
	,   @EDU_CODIGO           integer
) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	delete from DOCUMENTOS_UBB.dbo.SERVICIO_MAEPER
	with(updlock)
	where	SEMA_CODIGO 	= @SEMA_CODIGO 
	and		SERV_CODIGO 	= @SERV_CODIGO 
	and		CATE_CODIGO 	= @CATE_CODIGO 
	and		OFRE_CODIGO 	= @OFRE_CODIGO 
	and		CCO_CODIGO 		= @CCO_CODIGO 
	and		REP_CODIGO 		= @REP_CODIGO 
	and		EDU_CODIGO 		= @EDU_CODIGO 

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
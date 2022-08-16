/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: Hans Buker Gutiérrez
	@-Fecha_Modificacion0: 12-07-2018
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, proceso_funcionario, pb_siguiente

	@-Parametro_Entrada0: USOF_CODIGO
	@-Parametro_Entrada1: MOD_CODIGO
	@-Parametro_Entrada2: MODU_CODIGO
	@-Parametro_Entrada3: MOAT_CODIGO
	@-Parametro_Entrada4: OFRE_CODIGO
	@-Parametro_Entrada5: REP_CODIGO
	@-Parametro_Entrada6: EDU_CODIGO
	@-Parametro_Entrada7: FILA_YEAR
	@-Parametro_Entrada8: FILA_CODIGO
	@-Parametro_Entrada9: ESTAD_CODIGO
	@-Parametro_Entrada10: SERV_CODIGO_nuevo
	@-Parametro_Entrada11: CATE_CODIGO_nuevo
	@-Parametro_Entrada12: atas_correlativo

	@-Descripcion_Objeto0: Modifica un numero de atenciòn ya ingresado
	@-Regla_Objeto0: Debe existir registro de un numero de atenciòn en el sistema
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modificar_atencion_asignada;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_modificar_atencion_asignada
(
		@atas_correlativo		integer  
	,	@USOF_CODIGO			integer
	,	@MOD_CODIGO				integer
	,	@MODU_CODIGO			integer
	,	@MOAT_CODIGO			integer
	,	@OFRE_CODIGO			integer
	,	@REP_CODIGO				decimal
	,	@EDU_CODIGO				integer
	,	@FILA_YEAR				integer
	,	@FILA_CODIGO			integer
	,	@ESTAD_CODIGO			integer
	,	@SERV_CODIGO_nuevo		integer
	,	@CATE_CODIGO_nuevo		integer

) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION; 

	UPDATE DOCUMENTOS_UBB.dbo.ATENCION_ASIGNADA with(updlock)

	SET 	SERV_CODIGO			= @SERV_CODIGO_nuevo
	,		CATE_CODIGO			= @CATE_CODIGO_nuevo
	WHERE   USOF_CODIGO			= @USOF_CODIGO
	and		MOD_CODIGO			= @MOD_CODIGO
	and		MODU_CODIGO			= @MODU_CODIGO
	and		MOAT_CODIGO			= @MOAT_CODIGO
	and		OFRE_CODIGO			= @OFRE_CODIGO
	and		REP_CODIGO			= @REP_CODIGO
	and		EDU_CODIGO			= @EDU_CODIGO
	and		FILA_YEAR			= @FILA_YEAR
	and		FILA_CODIGO			= @FILA_CODIGO
	and		ESTAD_CODIGO		= @ESTAD_CODIGO
	and		atas_correlativo	= @atas_correlativo

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;





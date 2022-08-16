/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, dw_tipo_programa
	
	
	@-Parametro_Entrada0: ENPR_CODIGO
	@-Parametro_Entrada1: TPR_CORRELATIVO
	@-Parametro_Entrada2: SERV_CODIGO
	@-Parametro_Entrada3: CATE_CODIGO
	@-Parametro_Entrada4: OFRE_CODIGO
	@-Parametro_Entrada5: CCO_CODIGO
	@-Parametro_Entrada6: REP_CODIGO
	@-Parametro_Entrada7: EDU_CODIGO

	@-Descripcion_Objeto0: Desvincula un tipo de programa del sistema
	@-Regla_Objeto0: Debe existir una vinculación previa al sistema para que pueda ser desvinculado
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_desvincular_programa;

FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_desvincular_programa
(
	@ENPR_CODIGO		integer
,	@TPR_CORRELATIVO	integer
,	@SERV_CODIGO		integer
,	@CATE_CODIGO		integer
,	@OFRE_CODIGO		integer
,	@CCO_CODIGO			decimal
,	@REP_CODIGO			decimal
,	@EDU_CODIGO			integer
) 

as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	delete from DOCUMENTOS_UBB.dbo.ENGLOBAN_PROGRAMAS
	with(updlock)
	where 		@ENPR_CODIGO		=	ENPR_CODIGO
	and			@TPR_CORRELATIVO	=	TPR_CORRELATIVO
	and			@SERV_CODIGO		=	SERV_CODIGO
	and			@CATE_CODIGO		=	CATE_CODIGO
	and			@OFRE_CODIGO		=	OFRE_CODIGO
	and			@CCO_CODIGO			=	CCO_CODIGO
	and			@REP_CODIGO			=	REP_CODIGO
	and			@EDU_CODIGO			=	EDU_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;

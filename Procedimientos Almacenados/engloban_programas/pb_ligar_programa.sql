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
	@-Parametro_Entrada8: ENPR_FECHA_REGISTRO
	@-Parametro_Entrada9: ENPR_LOG_REGISTRO
	 
	@-Descripcion_Objeto0: Vincula un tipo de programa del sistema
	@-Regla_Objeto0: Debe existir una oficina de reparticion junto a un servicio creado
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_ligar_programa;
	
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_ligar_programa
	(
		@ENPR_CODIGO          integer
	,	@TPR_CORRELATIVO      integer
	,	@SERV_CODIGO          integer
	,	@CATE_CODIGO          integer
	,	@OFRE_CODIGO          integer
	,	@CCO_CODIGO           decimal
	,	@REP_CODIGO           decimal
	,	@EDU_CODIGO           integer
	,	@ENPR_FECHA_REGISTRO  datetime
	,	@ENPR_LOG_REGISTRO    varchar(250)
) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

insert into DOCUMENTOS_UBB.dbo.ENGLOBAN_PROGRAMAS with(updlock)
	(
		ENPR_CODIGO          
	,	TPR_CORRELATIVO      
	,	SERV_CODIGO          
	,	CATE_CODIGO          
	,	OFRE_CODIGO          
	,	CCO_CODIGO           
	,	REP_CODIGO           
	,	EDU_CODIGO           
	,	ENPR_FECHA_REGISTRO  
	,	ENPR_LOG_REGISTRO
	)
values 
	(
		@ENPR_CODIGO          
	,	@TPR_CORRELATIVO      
	,	@SERV_CODIGO          
	,	@CATE_CODIGO          
	,	@OFRE_CODIGO          
	,	@CCO_CODIGO           
	,	@REP_CODIGO           
	,	@EDU_CODIGO           
	,	@ENPR_FECHA_REGISTRO  
	,	@ENPR_LOG_REGISTRO
	);

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;

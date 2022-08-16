/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
	
	
	@-Parametro_Entrada0: MOD_CODIGO
	@-Parametro_Entrada1: OFRE_CODIGO
	@-Parametro_Entrada2: CCO_CODIGO
	@-Parametro_Entrada3: REP_CODIGO
	@-Parametro_Entrada4: EDU_CODIGO

	@-Descripcion_Objeto0: Remueve un mòdulo de atenciòn del sistema
	@-Regla_Objeto0: Debe existir un módulo de atención para poder removerlo
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_quitar_Modulo_atencion;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_quitar_Modulo_atencion
(
	@MOD_CODIGO           integer,
	@OFRE_CODIGO          integer,
	@CCO_CODIGO           decimal,
	@REP_CODIGO           decimal,
	@EDU_CODIGO           integer
) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	delete from DOCUMENTOS_UBB.dbo.MODULOS_ATENCION
	with(updlock)
	where 	@MOD_CODIGO        =   MOD_CODIGO
	and 	@OFRE_CODIGO       =   OFRE_CODIGO
	and   	@CCO_CODIGO        =   CCO_CODIGO
	and   	@REP_CODIGO        =   REP_CODIGO
	and   	@EDU_CODIGO        =   EDU_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
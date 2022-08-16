/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: Hans Buker Gutiérrez
	@-Fecha_Modificacion0: 12-07-2018
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, modulos de atencion

	@-Parametro_Entrada0: atas_correlativo
	@-Parametro_Entrada1: USOF_CODIGO
	@-Parametro_Entrada2: MOD_CODIGO
	@-Parametro_Entrada3: MODU_CODIGO
	@-Parametro_Entrada4: MOAT_CODIGO
	@-Parametro_Entrada5: OFRE_CODIGO
	@-Parametro_Entrada6: REP_CODIGO
	@-Parametro_Entrada7: EDU_CODIGO
	@-Parametro_Entrada8: FILA_YEAR
	@-Parametro_Entrada9: FILA_CODIGO
	@-Parametro_Entrada10: ESTAD_CODIGO
	@-Parametro_Entrada11: SERV_CODIGO_nuevo
	@-Parametro_Entrada12: CATE_CODIGO_nuevo

	@-Descripcion_Objeto0: Elimina las atenciones realizadas por un funcionario asignado a un Módulo
	@-Regla_Objeto0: Deben atenciones asignadas al un mòdulo para poderlas eliminar
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modificar_atencion_asignada;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_eliminar_atencion_asignada
(
		@USOF_CODIGO			integer
	,	@MOD_CODIGO				integer
	,	@MODU_CODIGO			integer
	,	@OFRE_CODIGO			integer
	,	@REP_CODIGO				decimal
	,	@EDU_CODIGO				integer
) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION; 

  delete from DOCUMENTOS_UBB.dbo.atencion_asignada
  with(updlock)
  where USOF_CODIGO   = @USOF_CODIGO 
  and   MOD_CODIGO    = @MOD_CODIGO
  and 	MODU_CODIGO   = @MODU_CODIGO
  and   OFRE_CODIGO   = @OFRE_CODIGO
  and   REP_CODIGO    = @REP_CODIGO
  and   EDU_CODIGO    = @EDU_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
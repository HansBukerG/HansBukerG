/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores	
	
	@-Parametro_Entrada0: cco_codigo
	@-Parametro_Entrada1: REP_CODIGO
	@-Parametro_Entrada2: EDU_CODIGO
	@-Parametro_Entrada3: OFRE_CODIGO

	@-Descripcion_Objeto0: Elimina una oficina de reparticion del sistema
	@-Regla_Objeto0: Debe existir una oficina de reparticion previamente para poder ser removida
	@-String_Prueba0: EXEC Documentos_ubb.dbo.quitar_oficina_reparticion;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.quitar_oficina_reparticion
(
	@cco_codigo decimal,
	@REP_CODIGO decimal,
	@EDU_CODIGO int,
	@OFRE_CODIGO int
)
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	delete from DOCUMENTOS_UBB.dbo.oficina_reparticion
	with(updlock)
	where
		@cco_codigo 	= cco_codigo and
		@REP_CODIGO 	= rep_codigo and
		@EDU_CODIGO 	= EDU_CODIGO and
		@OFRE_CODIGO 	= OFRE_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
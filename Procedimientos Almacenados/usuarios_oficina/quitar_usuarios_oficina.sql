/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
	
	
	@-Parametro_Entrada0: OFRE_CODIGO
	@-Parametro_Entrada1: cco_codigo
	@-Parametro_Entrada2: REP_CODIGO
	@-Parametro_Entrada3: EDU_CODIGO
	@-Parametro_Entrada4: mae_rut
	@-Parametro_Entrada5: USOF_CODIGO

	@-Descripcion_Objeto0: SP encargado de quitar usuarios de uan oficina, en caso de que estos no tengan vinculo alguno con algun otro módulo del sistema
	@-Regla_Objeto0: Debe existir una oficina con funcionarios para poderlos quitar
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_quitar_usuarios_oficina;


FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_quitar_usuarios_oficina
(
		@OFRE_CODIGO 	int,
		@cco_codigo 	decimal,
		@REP_CODIGO 	decimal,
		@EDU_CODIGO 	int,
		@mae_rut 		decimal,
		@USOF_CODIGO 	int
)
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	delete from DOCUMENTOS_UBB.dbo.USUARIOS_OFICINA
	with(updlock)
	where	@OFRE_CODIGO 	= OFRE_CODIGO
	and		@cco_codigo 	= cco_codigo
	and		@REP_CODIGO 	= REP_CODIGO
	and		@EDU_CODIGO 	= EDU_CODIGO
	and		@mae_rut		= mae_rut
	and		@USOF_CODIGO	= USOF_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
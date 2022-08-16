/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores
	
	
	@-Parametro_Entrada0: FILA_YEAR
	@-Parametro_Entrada1: FILA_CODIGO
	@-Parametro_Entrada2: OFRE_CODIGO
	@-Parametro_Entrada3: REP_CODIGO
	@-Parametro_Entrada4: EDU_CODIGO

	@-Descripcion_Objeto0: sp con posible uso se deja para ampliaciones futuras
	@-Regla_Objeto0: Debe existir una oficina de reparticion para poder elimianr una fila
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_eliminar_fila_atencion;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_eliminar_fila_atencion
(
   @FILA_YEAR              integer,
   @FILA_CODIGO            integer,
   @OFRE_CODIGO            integer,
   @REP_CODIGO             decimal,
   @EDU_CODIGO             integer
) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	delete from DOCUMENTOS_UBB.dbo.FILAS_ATENCION
	with(updlock)
	where 	 FILA_YEAR = @FILA_YEAR  
	and		 FILA_CODIGO = @FILA_CODIGO 
	and		 OFRE_CODIGO = @OFRE_CODIGO 
	and		 REP_CODIGO = @REP_CODIGO  
	and		 EDU_CODIGO = @EDU_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
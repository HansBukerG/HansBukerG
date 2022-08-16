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
	@-Parametro_Entrada7: SEMA_DESCRIPCION
	@-Parametro_Entrada8: SEMA_FECHA_REGISTRO
	@-Parametro_Entrada9: SEMA_LOG_REGISTRO

	@-Descripcion_Objeto0: SP encargado de ingresar la asignacion de maeper a un servicio
	@-Regla_Objeto0: Debe existir una un servicio primero para poderlo asignar
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_insertar_servicio_maeper;


FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_insertar_servicio_maeper
(
		@SEMA_CODIGO          integer
	,   @SERV_CODIGO          integer
	,   @CATE_CODIGO          integer
	,   @OFRE_CODIGO          integer
	,   @CCO_CODIGO           decimal
	,   @REP_CODIGO           decimal
	,   @EDU_CODIGO           integer
	,	@SEMA_DESCRIPCION     varchar(50)
	,   @SEMA_FECHA_REGISTRO  datetime
	,   @SEMA_LOG_REGISTRO    varchar(250)
) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

insert into DOCUMENTOS_UBB.dbo.SERVICIO_MAEPER with(updlock)
(
		SEMA_CODIGO
	,   SERV_CODIGO
	,   CATE_CODIGO
	,   OFRE_CODIGO
	,   CCO_CODIGO
	,   REP_CODIGO
	,   EDU_CODIGO
	,	SEMA_DESCRIPCION
	,   SEMA_FECHA_REGISTRO
	,   SEMA_LOG_REGISTRO
)
values 
(
		@SEMA_CODIGO
	,   @SERV_CODIGO
	,   @CATE_CODIGO
	,   @OFRE_CODIGO
	,   @CCO_CODIGO
	,   @REP_CODIGO
	,   @EDU_CODIGO
	,	@SEMA_DESCRIPCION
	,   @SEMA_FECHA_REGISTRO
	,   @SEMA_LOG_REGISTRO
);

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
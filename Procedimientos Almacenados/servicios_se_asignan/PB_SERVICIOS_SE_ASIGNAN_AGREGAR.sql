/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
	
	@-Parametro_Entrada0: ASIG_CORRELATIVO
	@-Parametro_Entrada1: SERV_CODIGO
	@-Parametro_Entrada2: CATE_CODIGO
	@-Parametro_Entrada3: OFRE_CODIGO
	@-Parametro_Entrada4: CCO_CODIGO
	@-Parametro_Entrada5: REP_CODIGO
	@-Parametro_Entrada6: EDU_CODIGO
	@-Parametro_Entrada7: MOD_CODIGO
	@-Parametro_Entrada8: Fecha_inicio
	@-Parametro_Entrada9: fecha_termino
	@-Parametro_Entrada10: fecha_registro
	@-Parametro_Entrada11: log_registro

	@-Descripcion_Objeto0: SP encargado de asignar un servicio a un modulo
	@-Regla_Objeto0: Debe existir un servicio y un modulo para poderlos vincular
	@-String_Prueba0: EXEC Documentos_ubb.dbo.PB_SERVICIOS_SE_ASIGNAN_AGREGAR;

FIN_DATOS_PROCEDIMIENTO**/	

alter proc dbo.PB_SERVICIOS_SE_ASIGNAN_AGREGAR
(
   @ASIG_CORRELATIVO	integer,
   @SERV_CODIGO			integer,
   @CATE_CODIGO			integer,
   @OFRE_CODIGO			integer,
   @CCO_CODIGO			decimal,
   @REP_CODIGO			decimal,
   @EDU_CODIGO			integer,
   @MOD_CODIGO			integer,
   @Fecha_inicio		datetime,
   @fecha_termino		datetime,
   @fecha_registro		datetime,
   @log_registro		varchar(250)
) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

insert into DOCUMENTOS_UBB.dbo.SERVICIOS_SE_ASIGNAN with(updlock)
(
	ASIG_CORRELATIVO,
	SERV_CODIGO,
	CATE_CODIGO,
	OFRE_CODIGO,
	CCO_CODIGO,
	REP_CODIGO,
	EDU_CODIGO,
	MOD_CODIGO,
	Fecha_inicio,
	fecha_termino,
	fecha_registro,
	log_registro
	)
values 
(
	@ASIG_CORRELATIVO,
	@SERV_CODIGO,
	@CATE_CODIGO,
	@OFRE_CODIGO,
	@CCO_CODIGO,
	@REP_CODIGO,
	@EDU_CODIGO,
	@MOD_CODIGO,
	@Fecha_inicio,
	@fecha_termino,
	@fecha_registro,
	@log_registro
);

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
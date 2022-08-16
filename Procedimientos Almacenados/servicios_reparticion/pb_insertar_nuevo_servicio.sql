/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
	
	
	@-Parametro_Entrada0: SERV_CODIGO
	@-Parametro_Entrada1: CATE_CODIGO
	@-Parametro_Entrada2: OFRE_CODIGO
	@-Parametro_Entrada3: CCO_CODIGO
	@-Parametro_Entrada4: REP_CODIGO
	@-Parametro_Entrada5: EDU_CODIGO
	@-Parametro_Entrada6: SERV_NOMBRE
	@-Parametro_Entrada7: SERV_ABREVIACION
	@-Parametro_Entrada8: SERV_FECHA_INICIO
	@-Parametro_Entrada9: SERV_FECHA_TERMINO
	@-Parametro_Entrada10: SERV_FECHA_REGISTRO
	@-Parametro_Entrada11: SERV_LOG_REGISTRO

	@-Descripcion_Objeto0: SP encargado de crear un servicio en una oficina de reparticion
	@-Regla_Objeto0: Debe existir una categoria para crear un servicio
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_insertar_nuevo_servicio;
	
FIN_DATOS_PROCEDIMIENTO**/	
	
alter proc dbo.pb_insertar_nuevo_servicio
(
   @SERV_CODIGO          integer,
   @CATE_CODIGO          integer,
   @OFRE_CODIGO          integer,
   @CCO_CODIGO           decimal,
   @REP_CODIGO           decimal,
   @EDU_CODIGO           integer,
   @SERV_NOMBRE          varchar(250),
   @SERV_ABREVIACION	 varchar(2),
   @SERV_FECHA_INICIO    datetime,
   @SERV_FECHA_TERMINO   datetime,
   @SERV_FECHA_REGISTRO  datetime,
   @SERV_LOG_REGISTRO    varchar(250)
) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;


insert into DOCUMENTOS_UBB.dbo.SERVICIOS_REPARTICION with(updlock)
(
	SERV_CODIGO
,	CATE_CODIGO
,	OFRE_CODIGO
,	CCO_CODIGO
,	REP_CODIGO
,	EDU_CODIGO
,	SERV_NOMBRE
,	SERV_ABREVIACION
,	SERV_FECHA_INICIO
,	SERV_FECHA_TERMINO
,	SERV_FECHA_REGISTRO
,	SERV_LOG_REGISTRO
)
values 
(
	@SERV_CODIGO
,	@CATE_CODIGO
,	@OFRE_CODIGO
,	@CCO_CODIGO
,	@REP_CODIGO
,	@EDU_CODIGO
,	@SERV_NOMBRE
,	@SERV_ABREVIACION
,	@SERV_FECHA_INICIO
,	@SERV_FECHA_TERMINO
,	@SERV_FECHA_REGISTRO
,	@SERV_LOG_REGISTRO
);

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;

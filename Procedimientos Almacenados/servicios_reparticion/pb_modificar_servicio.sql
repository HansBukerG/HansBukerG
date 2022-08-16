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

   @-Descripcion_Objeto0: SP encargado de modificar un servicio en una oficina de reparticion
   @-Regla_Objeto0: Debe existir un servicio para modificarlo
   @-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modificar_servicio;

   
FIN_DATOS_PROCEDIMIENTO**/ 

alter proc dbo.pb_modificar_servicio
(
   @SERV_CODIGO          integer,
   @CATE_CODIGO          integer,
   @OFRE_CODIGO          integer,
   @CCO_CODIGO           decimal,
   @REP_CODIGO           decimal,
   @EDU_CODIGO           integer,
   @SERV_NOMBRE          varchar(250),
   @SERV_ABREVIACION     varchar(2),
   @SERV_FECHA_INICIO    datetime,
   @SERV_FECHA_TERMINO   datetime,
   @SERV_FECHA_REGISTRO  datetime,
   @SERV_LOG_REGISTRO    varchar(250)
) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

UPDATE DOCUMENTOS_UBB.dbo.SERVICIOS_REPARTICION with(updlock)
SET		SERV_NOMBRE  		= @SERV_NOMBRE
,     SERV_ABREVIACION     = @SERV_ABREVIACION
,		SERV_FECHA_INICIO    = @SERV_FECHA_INICIO
,		SERV_FECHA_TERMINO   = @SERV_FECHA_TERMINO
,		SERV_FECHA_REGISTRO  = @SERV_FECHA_REGISTRO
,		SERV_LOG_REGISTRO    = @SERV_LOG_REGISTRO

WHERE    SERV_CODIGO =  @SERV_CODIGO
and      CATE_CODIGO  =  @CATE_CODIGO
and      OFRE_CODIGO  =  @OFRE_CODIGO
and      CCO_CODIGO  =  @CCO_CODIGO
and      REP_CODIGO =  @REP_CODIGO
and      EDU_CODIGO =  @EDU_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
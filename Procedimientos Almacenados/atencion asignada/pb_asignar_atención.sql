/**INICIO_DATOS_PROCEDIMIENTO 
   
   @-autor0: Hans Buker Gutiérrez
   @-Fecha_Creacion0: 25-06-2018
   @-autor_modificacion0: Hans Buker Gutiérrez
   @-Fecha_Modificacion0: 12-07-2018
   @-usado_por0: Sistema de Gestión y Control de Listas de Espera, Totem_marcha_blanca, proceso_control_turnos , dw_servicios_desconocido,dw_servicios_maeper,dw_servicios_alumno
   @-Parametro_Entrada0:       USOF_CODIGO
   @-Parametro_Entrada1:    ,  MOD_CODIGO
   @-Parametro_Entrada2:    ,  MODU_CODIGO
   @-Parametro_Entrada3:    ,  MOAT_CODIGO
   @-Parametro_Entrada4:    ,  OFRE_CODIGO
   @-Parametro_Entrada5:    ,  REP_CODIGO
   @-Parametro_Entrada6:    ,  EDU_CODIGO
   @-Parametro_Entrada7:    ,  FILA_YEAR
   @-Parametro_Entrada8:    ,  FILA_CODIGO
   @-Parametro_Entrada9:    ,  ESTAD_CODIGO
   @-Parametro_Entrada10:    ,  CATE_CODIGO
   @-Parametro_Entrada11:    ,  SERV_CODIGO
   @-Parametro_Entrada12:    ,  ATAS_FECHA_REGISTRO
   @-Parametro_Entrada13:    ,  ATAS_LOG_REGISTRO
   @-Parametro_Entrada14:    ,  ATAS_FECHA_ATENCION
   @-Parametro_Entrada15:    ,  atas_correlativo

   @-Descripcion_Objeto0: Ingresa registro de número de atención junto al servicio solicitado
   @-Regla_Objeto0: Debe haber ingresado un rut la persona primero
   @-String_Prueba0: (el sistema hace el uso del sp para ingresar el dato po loq ue no se puede ofrecer un tipo de ingreso) EXEC Documentos_ubb.dbo.pb_asignar_atención;
   
   
FIN_DATOS_PROCEDIMIENTO**/ 



alter proc dbo.pb_asignar_atención
(
      @atas_correlativo     integer
   ,  @USOF_CODIGO          integer
   ,  @MOD_CODIGO           integer
   ,  @MODU_CODIGO          integer
   ,  @MOAT_CODIGO          integer
   ,  @OFRE_CODIGO          integer
   ,  @REP_CODIGO           decimal
   ,  @EDU_CODIGO           integer
   ,  @FILA_YEAR            integer
   ,  @FILA_CODIGO          integer
   ,  @ESTAD_CODIGO         integer
   ,  @CATE_CODIGO          integer
   ,  @SERV_CODIGO          integer
   ,  @ATAS_FECHA_REGISTRO  datetime
   ,  @ATAS_LOG_REGISTRO    varchar(250)
   ,  @ATAS_FECHA_ATENCION  datetime
   )
as


DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION

insert into DOCUMENTOS_UBB.dbo.ATENCION_ASIGNADA with(updlock)
(
      atas_correlativo
   ,  USOF_CODIGO
   ,  MOD_CODIGO
   ,  MODU_CODIGO
   ,  MOAT_CODIGO
   ,  OFRE_CODIGO
   ,  REP_CODIGO
   ,  EDU_CODIGO
   ,  FILA_YEAR
   ,  FILA_CODIGO
   ,  ESTAD_CODIGO
   ,  CATE_CODIGO
   ,  SERV_CODIGO
   ,  ATAS_FECHA_REGISTRO
   ,  ATAS_LOG_REGISTRO
   ,  ATAS_FECHA_ATENCION
)
values 
(
      @atas_correlativo
   ,  @USOF_CODIGO
   ,  @MOD_CODIGO
   ,  @MODU_CODIGO
   ,  @MOAT_CODIGO
   ,  @OFRE_CODIGO
   ,  @REP_CODIGO
   ,  @EDU_CODIGO
   ,  @FILA_YEAR
   ,  @FILA_CODIGO
   ,  @ESTAD_CODIGO
   ,  @CATE_CODIGO
   ,  @SERV_CODIGO
   ,  @ATAS_FECHA_REGISTRO
   ,  @ATAS_LOG_REGISTRO
   ,  @ATAS_FECHA_ATENCION
);

  COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION
END CATCH



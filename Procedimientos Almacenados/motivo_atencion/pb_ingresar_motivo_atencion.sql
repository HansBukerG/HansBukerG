/**INICIO_DATOS_PROCEDIMIENTO 
   
   @-autor0: Hans Buker Gutiérrez
   @-Fecha_Creacion0: 25-06-2018
   @-modificado_por0: 
   @-Fecha_Modificacion0: 
   @-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
   
   
   @-Parametro_Entrada0: MOAT_CODIGO
   @-Parametro_Entrada1: FILA_YEAR
   @-Parametro_Entrada2: FILA_CODIGO
   @-Parametro_Entrada3: OFRE_CODIGO
   @-Parametro_Entrada4: REP_CODIGO
   @-Parametro_Entrada5: EDU_CODIGO
   @-Parametro_Entrada6: CATE_CODIGO
   @-Parametro_Entrada7: SERV_CODIGO
   @-Parametro_Entrada8: TPR_REFERENCIA
   @-Parametro_Entrada9: MOAT_NUMERO
   @-Parametro_Entrada10: ESTAD_CODIGO
   @-Parametro_Entrada11: MOAT_FECHA_REGISTRO
   @-Parametro_Entrada12: MOAT_LOG_REGISTRO

   @-Descripcion_Objeto0: Ingresa el codigo de estado junto al servicio y categoria anteriormente señaladas por el usuario.
   @-Regla_Objeto0: El usuario debe haber ingresado el rut primero
   @-String_Prueba0: EXEC Documentos_ubb.dbo.pb_ingresar_motivo_atencion;
   
FIN_DATOS_PROCEDIMIENTO**/ 

alter proc dbo.pb_ingresar_motivo_atencion
(
      @MOAT_CODIGO            integer                         
   ,  @FILA_YEAR              integer                         
   ,  @FILA_CODIGO            integer                         
   ,  @OFRE_CODIGO            integer                         
   ,  @REP_CODIGO             decimal                         
   ,  @EDU_CODIGO             integer                         
   ,  @CATE_CODIGO            integer                         
   ,  @SERV_CODIGO            integer                       
   ,  @TPR_REFERENCIA         integer
   ,  @MOAT_NUMERO            varchar(10)
   ,  @ESTAD_CODIGO           integer
   ,  @MOAT_FECHA_REGISTRO    datetime
   ,  @MOAT_LOG_REGISTRO      varchar(250)
   ,  @pca_codigo             integer                      
   ,  @crr_codigo             integer                      
   ,  @alc_ano_ingreso        integer                      
   ,  @alc_periodo            integer                      
) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

   insert into DOCUMENTOS_UBB.dbo.MOTIVO_ATENCION 
   with(updlock)
   (
            MOAT_CODIGO
         ,  FILA_YEAR
         ,  FILA_CODIGO
         ,  OFRE_CODIGO
         ,  REP_CODIGO
         ,  EDU_CODIGO
         ,  CATE_CODIGO
         ,  SERV_CODIGO
         ,  TPR_REFERENCIA
         ,  MOAT_NUMERO
         ,  ESTAD_CODIGO
         ,  MOAT_FECHA_REGISTRO
         ,  MOAT_LOG_REGISTRO
         ,  pca_codigo     
         ,  crr_codigo     
         ,  alc_ano_ingreso
         ,  alc_periodo    
   )
   values 
   (
            @MOAT_CODIGO
         ,  @FILA_YEAR
         ,  @FILA_CODIGO
         ,  @OFRE_CODIGO
         ,  @REP_CODIGO
         ,  @EDU_CODIGO
         ,  @CATE_CODIGO
         ,  @SERV_CODIGO
         ,  @TPR_REFERENCIA
         ,  @MOAT_NUMERO
         ,  @ESTAD_CODIGO
         ,  @MOAT_FECHA_REGISTRO
         ,  @MOAT_LOG_REGISTRO
         ,  @pca_codigo     
         ,  @crr_codigo     
         ,  @alc_ano_ingreso
         ,  @alc_periodo    
   );

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
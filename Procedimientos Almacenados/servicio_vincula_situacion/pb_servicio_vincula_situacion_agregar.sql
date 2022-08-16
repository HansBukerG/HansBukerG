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
   @-Parametro_Entrada6: SAA_CODIGO
   @-Parametro_Entrada7: SVS_CODIGO
   @-Parametro_Entrada8: SVS_FECHA_REGISTRO
   @-Parametro_Entrada9: SVS_LOG_REGISTRO

   @-Descripcion_Objeto0: SP encargado de vincular una situacion academica a un servicio
   @-Regla_Objeto0: Debe existir una un servicio primero para poderlo  asignar
   @-String_Prueba0: EXEC Documentos_ubb.dbo.servicio_vincula_situacion;

FIN_DATOS_PROCEDIMIENTO**/ 
   
alter proc dbo.pb_servicio_vincula_situacion_agregar
   (
      @SERV_CODIGO         integer
   ,  @CATE_CODIGO         integer
   ,  @OFRE_CODIGO         integer
   ,  @CCO_CODIGO          decimal
   ,  @REP_CODIGO          decimal
   ,  @EDU_CODIGO          integer
   ,  @SAA_CODIGO          integer
   ,  @SVS_CODIGO          integer
   ,  @SVS_FECHA_REGISTRO  datetime
   ,  @SVS_LOG_REGISTRO    varchar(250)
   ) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

insert into DOCUMENTOS_UBB.dbo.servicio_vincula_situacion with(updlock)
   (
      SERV_CODIGO          
   ,  CATE_CODIGO      
   ,  OFRE_CODIGO          
   ,  CCO_CODIGO          
   ,  REP_CODIGO          
   ,  EDU_CODIGO           
   ,  SAA_CODIGO           
   ,  SVS_CODIGO           
   ,  SVS_FECHA_REGISTRO  
   ,  SVS_LOG_REGISTRO
   )
values 
   (
      @SERV_CODIGO          
   ,  @CATE_CODIGO      
   ,  @OFRE_CODIGO          
   ,  @CCO_CODIGO          
   ,  @REP_CODIGO          
   ,  @EDU_CODIGO           
   ,  @SAA_CODIGO           
   ,  @SVS_CODIGO           
   ,  @SVS_FECHA_REGISTRO  
   ,  @SVS_LOG_REGISTRO
   );

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH 
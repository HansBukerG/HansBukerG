/**INICIO_DATOS_PROCEDIMIENTO 
   
   @-autor0: Hans Buker Gutiérrez
   @-Fecha_Creacion0: 25-06-2018
   @-modificado_por0: 
   @-Fecha_Modificacion0: 
   @-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores
   
   @-Parametro_Entrada0: MODU_CODIGO
   @-Parametro_Entrada1: MOD_CODIGO
   @-Parametro_Entrada2: USOF_CODIGO
   @-Parametro_Entrada3: CCO_CODIGO
   @-Parametro_Entrada4: REP_CODIGO
   @-Parametro_Entrada5: EDU_CODIGO
   @-Parametro_Entrada6: OFRE_CODIGO
   @-Parametro_Entrada7: MODU_FECHA_INICIO
   @-Parametro_Entrada8: MODU_FECHA_TERMINO
   @-Parametro_Entrada9: MODU_FECHA_REGISTRO
   @-Parametro_Entrada10: MODU_LOG_REGISTRO

   @-Descripcion_Objeto0: Asigna un modulo de atencion a un usuario
   @-Regla_Objeto0: Debe existir un modulo en la oficina de reparticion para que este pueda ser asignado
   @-String_Prueba0: EXEC Documentos_ubb.dbo.pb_activar_modulo;
   
FIN_DATOS_PROCEDIMIENTO**/ 

alter proc dbo.pb_activar_modulo
   (
      @MODU_CODIGO          integer,
      @MOD_CODIGO           integer,
      @USOF_CODIGO          integer,
      @CCO_CODIGO           decimal,
      @REP_CODIGO           decimal,
      @EDU_CODIGO           integer,
      @OFRE_CODIGO          integer,
      @MODU_FECHA_INICIO    datetime,
      @MODU_FECHA_TERMINO   datetime,
      @MODU_FECHA_REGISTRO  datetime,
      @MODU_LOG_REGISTRO    varchar(250)                   
   ) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;


insert into DOCUMENTOS_UBB.dbo.MODULOS_ASIGNADOS with(updlock)
   (
      MODU_CODIGO          ,
      MOD_CODIGO           ,
      USOF_CODIGO          ,
      CCO_CODIGO           ,
      REP_CODIGO           ,
      EDU_CODIGO           ,
      OFRE_CODIGO          ,
      MODU_FECHA_INICIO    ,
      MODU_FECHA_TERMINO   ,
      MODU_FECHA_REGISTRO  ,
      MODU_LOG_REGISTRO      
   )
values 
   (
      @MODU_CODIGO          ,
      @MOD_CODIGO           ,
      @USOF_CODIGO          ,
      @CCO_CODIGO           ,
      @REP_CODIGO           ,
      @EDU_CODIGO           ,
      @OFRE_CODIGO          ,
      @MODU_FECHA_INICIO    ,
      @MODU_FECHA_TERMINO   ,
      @MODU_FECHA_REGISTRO  ,
      @MODU_LOG_REGISTRO      
   );

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;

/**INICIO_DATOS_PROCEDIMIENTO 
   
   @-autor0: Hans Buker Gutiérrez
   @-Fecha_Creacion0: 25-06-2018
   @-modificado_por0: 
   @-Fecha_Modificacion0: 
   @-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, dw_tipo_programa_consulta_modulo
   
   
   @-Parametro_Entrada0: MAC_CORRELATIVO
   @-Parametro_Entrada1: MOD_CODIGO
   @-Parametro_Entrada2: OFRE_CODIGO
   @-Parametro_Entrada3: REP_CODIGO
   @-Parametro_Entrada4: EDU_CODIGO
   @-Parametro_Entrada5: MAC_DESCRIPCION
   @-Parametro_Entrada6: FECHA_REGISTRO
   @-Parametro_Entrada7: LOG_REGISTRO

   @-Descripcion_Objeto0: Asigna el perfil civil al modulo para que este lo pueda atender
   @-Regla_Objeto0: Debe existir un modulo de atencion para agregar el perfil civil a su funcionalidad
   @-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modulo_atiende_civil_agregar;
   
FIN_DATOS_PROCEDIMIENTO**/ 

alter proc dbo.pb_modulo_atiende_civil_agregar
(
      @MAC_CORRELATIVO      integer,
      @MOD_CODIGO           integer,
      @OFRE_CODIGO          integer,
      @REP_CODIGO           decimal,
      @EDU_CODIGO           integer,
      @MAC_DESCRIPCION      varchar(20),
      @FECHA_REGISTRO       datetime,
      @LOG_REGISTRO         varchar(250)
)
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;  

insert into documentos_ubb.dbo.MODULO_ATIENDE_CIVIL
(
      MAC_CORRELATIVO      ,
      MOD_CODIGO           ,
      OFRE_CODIGO          ,
      REP_CODIGO           ,
      EDU_CODIGO           ,
      MAC_DESCRIPCION      ,
      FECHA_REGISTRO       ,
      LOG_REGISTRO         
)
values
(
      @MAC_CORRELATIVO      ,
      @MOD_CODIGO           ,
      @OFRE_CODIGO          ,
      @REP_CODIGO           ,
      @EDU_CODIGO           ,
      @MAC_DESCRIPCION      ,
      @FECHA_REGISTRO       ,
      @LOG_REGISTRO         
)

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
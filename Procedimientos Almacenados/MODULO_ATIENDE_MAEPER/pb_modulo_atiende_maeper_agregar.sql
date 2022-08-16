/**INICIO_DATOS_PROCEDIMIENTO 
  
  @-autor0: Hans Buker Gutiérrez
  @-Fecha_Creacion0: 25-06-2018
  @-modificado_por0: 
  @-Fecha_Modificacion0: 
  @-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, dw_tipo_programa_consulta_modulo
  
  
  @-Parametro_Entrada0: MAM_CORRELATIVO
  @-Parametro_Entrada1: MAM_DESCRIPCION
  @-Parametro_Entrada2: MOD_CODIGO
  @-Parametro_Entrada3: OFRE_CODIGO
  @-Parametro_Entrada4: REP_CODIGO
  @-Parametro_Entrada5: EDU_CODIGO
  @-Parametro_Entrada6: FECHA_REGISTRO
  @-Parametro_Entrada7: LOG_REGISTRO

  @-Descripcion_Objeto0: Asigna el perfil maeper al modulo para la atencion al público
  @-Regla_Objeto0: Debe existir un modulo de atencion para asignar el perfil
  @-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modulo_atiende_maeper_agregar;
  
FIN_DATOS_PROCEDIMIENTO**/  


alter proc dbo.pb_modulo_atiende_maeper_agregar
(
      @MAM_CORRELATIVO int
   ,  @MAM_DESCRIPCION varchar(100)
   ,  @MOD_CODIGO      int
   ,  @OFRE_CODIGO     int
   ,  @REP_CODIGO      int
   ,  @EDU_CODIGO      int
   ,  @FECHA_REGISTRO  datetime
   ,  @LOG_REGISTRO    varchar(250)
)
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

  insert into documentos_ubb.dbo.MODULO_ATIENDE_MAEPER
  (
        MAM_CORRELATIVO
     ,  MAM_DESCRIPCION
     ,  MOD_CODIGO
     ,  OFRE_CODIGO
     ,  REP_CODIGO
     ,  EDU_CODIGO
     ,  FECHA_REGISTRO
     ,  LOG_REGISTRO
  )values
  (
        @MAM_CORRELATIVO
     ,  @MAM_DESCRIPCION
     ,  @MOD_CODIGO
     ,  @OFRE_CODIGO
     ,  @REP_CODIGO
     ,  @EDU_CODIGO
     ,  @FECHA_REGISTRO
     ,  @LOG_REGISTRO
  )


COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;

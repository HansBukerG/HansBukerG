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

   @-Descripcion_Objeto0: Modifica la asignación de usuario de un modulo de atención
   @-Regla_Objeto0: Debe existir un modulo en la oficina de reparticion con un usuario asignado para que este pueda ser modificado
   @-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modificar_asignacion_usuario;
   
FIN_DATOS_PROCEDIMIENTO**/ 


alter proc dbo.pb_modificar_asignacion_usuario
(
      @MODU_CODIGO          integer
   ,  @MOD_CODIGO           integer
   ,  @USOF_CODIGO          integer
   ,  @CCO_CODIGO           decimal
   ,  @REP_CODIGO           decimal
   ,  @EDU_CODIGO           integer
   ,  @OFRE_CODIGO          integer
   ,  @MODU_FECHA_INICIO    datetime
   ,  @MODU_FECHA_TERMINO   datetime
   ,  @MODU_FECHA_REGISTRO  datetime
   ,  @MODU_LOG_REGISTRO    varchar(250)
) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

   UPDATE DOCUMENTOS_UBB.dbo.MODULOS_ASIGNADOS with(updlock)
   SET   MODU_FECHA_REGISTRO  = @MODU_FECHA_REGISTRO
   ,     MODU_LOG_REGISTRO    = @MODU_LOG_REGISTRO
   ,     MODU_FECHA_TERMINO   = @MODU_FECHA_TERMINO
   ,     MODU_FECHA_INICIO    = @MODU_FECHA_INICIO
   WHERE    MODU_CODIGO   = @MODU_CODIGO
   and      MOD_CODIGO    = @MOD_CODIGO
   and      USOF_CODIGO   = @USOF_CODIGO
   and      CCO_CODIGO    = @CCO_CODIGO
   and      REP_CODIGO    = @REP_CODIGO
   and      EDU_CODIGO    = @EDU_CODIGO
   and      OFRE_CODIGO   = @OFRE_CODIGO;

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
/**INICIO_DATOS_PROCEDIMIENTO 
  
  @-autor0: Hans Buker Gutiérrez
  @-Fecha_Creacion0: 13-07-2018
  @-modificado_por0: 
  @-Fecha_Modificacion0: 
  @-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, dw_tipo_programa_consulta_modulo
  
  
  @-Parametro_Entrada0: MAM_CORRELATIVO
  @-Parametro_Entrada1: MOD_CODIGO
  @-Parametro_Entrada2: OFRE_CODIGO
  @-Parametro_Entrada3: REP_CODIGO
  @-Parametro_Entrada4: EDU_CODIGO

  @-Descripcion_Objeto0: Remueve una asignación de usuario de un módulo de atención
  @-Regla_Objeto0: Debe existir un modulo de atencion con el perfil maeper asignado para remover
  @-String_Prueba0: EXEC Documentos_ubb.dbo.pb_eliminar_asignacion;
  
FIN_DATOS_PROCEDIMIENTO**/  


alter proc dbo.pb_eliminar_asignacion
(
      @MODU_CODIGO          integer
   ,  @MOD_CODIGO           integer
   ,  @USOF_CODIGO          integer
   ,  @CCO_CODIGO           decimal
   ,  @REP_CODIGO           decimal
   ,  @EDU_CODIGO           integer
   ,  @OFRE_CODIGO          integer
) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

  delete from DOCUMENTOS_UBB.dbo.MODULOS_ASIGNADOS
  with(updlock)
  where   MODU_CODIGO     = @MODU_CODIGO
  and   MOD_CODIGO    = @MOD_CODIGO
  and     USOF_CODIGO     = @USOF_CODIGO
  and     CCO_CODIGO      = @CCO_CODIGO
  and     REP_CODIGO      = @REP_CODIGO
  and     EDU_CODIGO    = @EDU_CODIGO
  and     OFRE_CODIGO   = @OFRE_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
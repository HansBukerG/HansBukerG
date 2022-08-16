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

  @-Descripcion_Objeto0: Remueve el perfil civil del modulo
  @-Regla_Objeto0: Debe existir un modulo de atencion con un perfil asignado para civil
  @-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modulo_atiende_civil_quitar;
  
FIN_DATOS_PROCEDIMIENTO**/  


alter proc dbo.pb_modulo_atiende_civil_quitar
(
      @MAC_CORRELATIVO        integer,
      @MOD_CODIGO             integer,
      @OFRE_CODIGO            decimal,
      @REP_CODIGO             decimal,
      @EDU_CODIGO             integer
) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

delete from DOCUMENTOS_UBB.dbo.MODULO_ATIENDE_CIVIL
with(updlock)
where    @MAC_CORRELATIVO = MAC_CORRELATIVO
and      @MOD_CODIGO      = MOD_CODIGO
and      @OFRE_CODIGO     = OFRE_CODIGO
and      @REP_CODIGO      = REP_CODIGO
and      @EDU_CODIGO      = EDU_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;

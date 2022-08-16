/**INICIO_DATOS_PROCEDIMIENTO 
   
   @-autor0: Hans Buker Gutiérrez
   @-Fecha_Creacion0: 25-06-2018
   @-modificado_por0: 
   @-Fecha_Modificacion0: 
   @-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, modulos de atención
   
   
   @-Parametro_Entrada0: ASIG_CORRELATIVO
   @-Parametro_Entrada1: SERV_CODIGO
   @-Parametro_Entrada2: CATE_CODIGO
   @-Parametro_Entrada3: OFRE_CODIGO
   @-Parametro_Entrada4: CCO_CODIGO
   @-Parametro_Entrada5: REP_CODIGO
   @-Parametro_Entrada6: EDU_CODIGO
   @-Parametro_Entrada7: MOD_CODIGO
   @-Parametro_Entrada8: fecha_termino
   @-Parametro_Entrada9: fecha_registro
   @-Parametro_Entrada10: Log_registro

   @-Descripcion_Objeto0: Elimina una atencion asignada a un módulo de atención
   @-Regla_Objeto0: Debe existir un servicio y un modulo para realizar esta acción
   @-String_Prueba0: EXEC Documentos_ubb.dbo.PB_SERVICIOS_ASIGNADOS_ELIMINAR;
   
FIN_DATOS_PROCEDIMIENTO**/ 
   
create proc dbo.PB_SERVICIOS_ASIGNADOS_ELIMINAR
   (
       @ASIG_CORRELATIVO      integer
      ,@SERV_CODIGO           integer
      ,@CATE_CODIGO           integer
      ,@OFRE_CODIGO           integer
      ,@CCO_CODIGO            integer
      ,@REP_CODIGO            decimal
      ,@EDU_CODIGO            decimal
      ,@MOD_CODIGO            integer
   ) 
   as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

      delete from DOCUMENTOS_UBB.dbo.SERVICIOS_SE_ASIGNAN
      with(updlock)
      where ASIG_CORRELATIVO  = @ASIG_CORRELATIVO
      and   SERV_CODIGO       = @SERV_CODIGO
      and   CATE_CODIGO       = @CATE_CODIGO
      and   OFRE_CODIGO       = @OFRE_CODIGO
      and   CCO_CODIGO        = @CCO_CODIGO
      and   REP_CODIGO        = @REP_CODIGO
      and   EDU_CODIGO        = @EDU_CODIGO
      and   MOD_CODIGO        = @MOD_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
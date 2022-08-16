   SELECT   ltrim(rtrim(maeper.mae_nombre)) as mae_nombre
   ,        ltrim(rtrim(maeper.mae_apellido_paterno)) as mae_apellido_paterno
   ,        ltrim(rtrim(maeper.mae_apellido_materno)) as mae_apellido_materno
   ,        administracion.AOR_CORRELATIVO as AOR_CORRELATIVO
   ,        administracion.MAE_RUT as MAE_RUT
   ,        administracion.REP_CODIGO as REP_CODIGO
   ,        administracion.AOR_FECHA_INICIO as AOR_FECHA_INICIO
   ,        administracion.AOR_FECHA_TERMINO as AOR_FECHA_TERMINO
   ,        administracion.AOR_FECHA_REGISTRO as AOR_FECHA_REGISTRO
   ,        administracion.AOR_LOG_REGISTRO as AOR_LOG_REGISTRO
   FROM DOCUMENTOS_UBB.dbo.ADMIN_OFICINA_REPARTICION as administracion
   join  CREDITOTEST.DBO.CONTRATO         as CONTRATO    with(nolock)   
      on administracion.mae_rut           =  CONTRATO.mae_rut
   join  CREDITOTEST.dbo.maeper           as maeper with(nolock)
      on CONTRATO.mae_rut                 =  maeper.mae_rut
   where (administracion.AOR_FECHA_TERMINO >= CONVERT(DATE,GETDATE()) OR administracion.AOR_FECHA_TERMINO IS NULL)
   and   administracion.mae_rut=:mae_rut
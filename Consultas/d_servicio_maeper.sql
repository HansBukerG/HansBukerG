select   ltrim(rtrim(serv_maeper.SEMA_DESCRIPCION))   as SEMA_DESCRIPCION
,     serv_maeper.SEMA_CODIGO                as SEMA_CODIGO
,     serv_maeper.SERV_CODIGO                as SERV_CODIGO
,     serv_maeper.CATE_CODIGO                as CATE_CODIGO
,     serv_maeper.SEMA_FECHA_REGISTRO        as SEMA_FECHA_REGISTRO
,     serv_maeper.SEMA_LOG_REGISTRO             as SEMA_LOG_REGISTRO
from documentos_ubb.dbo.SERVICIO_MAEPER as serv_maeper with(nolock)
where    serv_maeper.SERV_CODIGO = :SERV_CODIGO
and      serv_maeper.CATE_CODIGO = :CATE_CODIGO
and      serv_maeper.OFRE_CODIGO = :OFRE_CODIGO
and      serv_maeper.CCO_CODIGO = :CCO_CODIGO
and      serv_maeper.REP_CODIGO = :REP_CODIGO
and      serv_maeper.EDU_CODIGO = :EDU_CODIGO
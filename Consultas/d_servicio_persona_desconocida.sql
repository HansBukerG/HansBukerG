select	ltrim(rtrim(desconocido.DESC_DESCRIPCION)) 	as DESC_DESCRIPCION
,		desconocido.DESC_CODIGO 					as DESC_CODIGO
,		desconocido.SERV_CODIGO 					as SERV_CODIGO
,		desconocido.CATE_CODIGO 					as CATE_CODIGO
,		desconocido.DESC_FECHA_REGISTRO 			as DESC_FECHA_REGISTRO
,		desconocido.DESC_LOG_REGISTRO 				as DESC_LOG_REGISTRO
from documentos_ubb.dbo.SERVICIO_PERSONA_DESCONOCIDA as desconocido with(nolock)
where 	desconocido.SERV_CODIGO = :SERV_CODIGO
and		desconocido.CATE_CODIGO = :CATE_CODIGO
and		desconocido.OFRE_CODIGO = :OFRE_CODIGO
and		desconocido.CCO_CODIGO = :CCO_CODIGO
and		desconocido.REP_CODIGO = :REP_CODIGO
and		desconocido.EDU_CODIGO = :EDU_CODIGO
select 	ltrim(rtrim(servicios.SERV_NOMBRE)) 	as SERV_NOMBRE
,		ltrim(rtrim(situacion.saa_descripcion)) 	as saa_descripcion
,		situacion_vinculada.SVS_CODIGO 		as SVS_CODIGO
,		situacion_vinculada.SAA_CODIGO			as SAA_CODIGO
,		situacion_vinculada.SERV_CODIGO 		as SERV_CODIGO
, 		situacion_vinculada.CATE_CODIGO 		as CATE_CODIGO
, 		situacion_vinculada.OFRE_CODIGO 		as OFRE_CODIGO
, 		situacion_vinculada.CCO_CODIGO  		as CCO_CODIGO
, 		situacion_vinculada.REP_CODIGO  		as REP_CODIGO
, 		situacion_vinculada.EDU_CODIGO  		as EDU_CODIGO
from 	academia.dbo.situacion_academica as situacion with(nolock)
join 	Documentos_ubb.dbo.servicio_vincula_situacion as situacion_vinculada with(nolock)
on		situacion.saa_codigo = situacion_vinculada.saa_codigo
join 	Documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on 		situacion_vinculada.SERV_CODIGO	=	servicios.SERV_CODIGO
and 	situacion_vinculada.CATE_CODIGO = 	servicios.CATE_CODIGO
and 	situacion_vinculada.OFRE_CODIGO = 	servicios.OFRE_CODIGO
and 	situacion_vinculada.CCO_CODIGO 	= 	servicios.CCO_CODIGO
and 	situacion_vinculada.REP_CODIGO 	= 	servicios.REP_CODIGO
and 	situacion_vinculada.EDU_CODIGO 	= 	servicios.EDU_CODIGO
where 	situacion_vinculada.SERV_CODIGO	=:SERV_CODIGO
and 	situacion_vinculada.CATE_CODIGO 		=:CATE_CODIGO
and 	situacion_vinculada.OFRE_CODIGO 		=:OFRE_CODIGO
and 	situacion_vinculada.CCO_CODIGO 		=:CCO_CODIGO
and 	situacion_vinculada.REP_CODIGO 		=:REP_CODIGO
and 	situacion_vinculada.EDU_CODIGO 		=:EDU_CODIGO
select 	ltrim(rtrim(servicios.SERV_NOMBRE)) 	as SERV_NOMBRE
,		ltrim(rtrim(programa.tpr_descripcion)) 	as tpr_descripcion
,		engloban.ENPR_CODIGO 		as ENPR_CODIGO
,		engloban.TPR_CORRELATIVO 	as TPR_CORRELATIVO
,		engloban.SERV_CODIGO 		as SERV_CODIGO
, 		engloban.CATE_CODIGO 		as CATE_CODIGO
, 		engloban.OFRE_CODIGO 		as OFRE_CODIGO
, 		engloban.CCO_CODIGO  		as CCO_CODIGO
, 		engloban.REP_CODIGO  		as REP_CODIGO
, 		engloban.EDU_CODIGO  		as EDU_CODIGO
from Academia.dbo.tipo_programa as programa with(nolock)
join Documentos_ubb.dbo.ENGLOBAN_PROGRAMAS as engloban with(nolock)
on	programa.TPR_CORRELATIVO = engloban.TPR_CORRELATIVO
join Documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on engloban.SERV_CODIGO=servicios.SERV_CODIGO
and engloban.CATE_CODIGO = servicios.CATE_CODIGO
and engloban.OFRE_CODIGO = servicios.OFRE_CODIGO
and engloban.CCO_CODIGO = servicios.CCO_CODIGO
and engloban.REP_CODIGO = servicios.REP_CODIGO
and engloban.EDU_CODIGO = servicios.EDU_CODIGO
where 	engloban.SERV_CODIGO		=:SERV_CODIGO
and 		engloban.CATE_CODIGO 	=:CATE_CODIGO
and 		engloban.OFRE_CODIGO 	=:OFRE_CODIGO
and 		engloban.CCO_CODIGO 		=:CCO_CODIGO
and 		engloban.REP_CODIGO 		=:REP_CODIGO
and 		engloban.EDU_CODIGO 		=:EDU_CODIGO
select 	ltrim(rtrim(servicios.serv_nombre)) 		as serv_nombre
,		ltrim(rtrim(programa.tpr_descripcion)) 	as tpr_descripcion
,		engloban.tpr_correlativo 	as tpr_correlativo
,		engloban.serv_codigo 		as serv_codigo
,		engloban.CATE_CODIGO		as CATE_CODIGO
,		engloban.OFRE_CODIGO		as OFRE_CODIGO
,		engloban.CCO_CODIGO 		as cco_codigo
,		engloban.rep_codigo 		as rep_codigo
,		engloban.EDU_CODIGO 		as EDU_CODIGO
,		engloban.enpr_codigo 		as enpr_codigo
from	Academia.dbo.tipo_programa as programa with(nolock)
join 	DOCUMENTOS_UBB.dbo.ENGLOBAN_PROGRAMAS as engloban with(nolock)
on 		engloban.tpr_correlativo = programa.tpr_correlativo
join	DOCUMENTOS_UBB.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on      servicios.serv_codigo=engloban.serv_codigo
and		servicios.CATE_CODIGO=engloban.CATE_CODIGO
and		servicios.OFRE_CODIGO=engloban.OFRE_CODIGO
and		servicios.CCO_CODIGO=engloban.CCO_CODIGO
and		servicios.REP_CODIGO=engloban.REP_CODIGO
and		servicios.EDU_CODIGO=engloban.EDU_CODIGO
where	

order by tpr_descripcion
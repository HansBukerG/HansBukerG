select  ltrim(rtrim(servicios.SERV_NOMBRE))	as SERV_NOMBRE
,		 ltrim(rtrim(servicios.SERV_ABREVIACION))		as SERV_ABREVIACION
,       ltrim(rtrim(categoria.cate_nombre))		as cate_nombre
,       ltrim(rtrim(reparticion.rep_nombre))		as rep_nombre
,       ltrim(rtrim(edificios.nombre))		as edu_descripcion
,       servicios.CATE_CODIGO                      		as CATE_CODIGO
,       servicios.OFRE_CODIGO						as OFRE_CODIGO
,       servicios.CCO_CODIGO						as CCO_CODIGO
,       servicios.REP_CODIGO						as REP_CODIGO
,       servicios.EDU_CODIGO						as EDU_CODIGO
,		servicios.serv_codigo							as serv_codigo
,		servicios.SERV_FECHA_INICIO				as 	SERV_FECHA_INICIO
,		servicios.SERV_FECHA_TERMINO			as SERV_FECHA_TERMINO
from DOCUMENTOS_UBB.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
left join DOCUMENTOS_UBB.dbo.categoria_servicio as categoria with(nolock)
on       servicios.CATE_CODIGO=categoria.CATE_CODIGO
and      servicios.OFRE_CODIGO=categoria.OFRE_CODIGO
and      servicios.CCO_CODIGO=categoria.CCO_CODIGO
and      servicios.REP_CODIGO=categoria.REP_CODIGO
and      servicios.EDU_CODIGO=categoria.EDU_CODIGO
left join documentos_ubb.dbo.oficina_reparticion as oficina with(nolock)
on       categoria.OFRE_CODIGO   = oficina.OFRE_CODIGO
and      categoria.CCO_CODIGO    = oficina.CCO_CODIGO
and      categoria.REP_CODIGO    = oficina.REP_CODIGO
and      categoria.EDU_CODIGO    = oficina.EDU_CODIGO
left join Vrae.dbo.reparticion as reparticion with(nolock)
on       oficina.cco_codigo      = reparticion.cco_codigo
and      oficina.rep_codigo      = reparticion.rep_codigo
join  SALAS.[dbo].[edificios] as edificios with(nolock)
on       oficina.edu_codigo      = edificios.id
where	servicios.CATE_CODIGO		= 4
and		servicios.OFRE_CODIGO		= 1
and		servicios.CCO_CODIGO		= 113
and		servicios.REP_CODIGO		= 30302000
and		servicios.EDU_CODIGO		= 31
and 		(servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)
order by SERV_NOMBRE

//en powerbuilder

select  ltrim(rtrim(servicios.SERV_NOMBRE))	as SERV_NOMBRE
,		 ltrim(rtrim(servicios.SERV_ABREVIACION))		as SERV_ABREVIACION
,       ltrim(rtrim(categoria.cate_nombre))		as cate_nombre
,       ltrim(rtrim(reparticion.rep_nombre))		as rep_nombre
,       ltrim(rtrim(edificios.nombre))		as edu_descripcion
,       servicios.CATE_CODIGO                      		as CATE_CODIGO
,       servicios.OFRE_CODIGO						as OFRE_CODIGO
,       servicios.CCO_CODIGO						as CCO_CODIGO
,       servicios.REP_CODIGO						as REP_CODIGO
,       servicios.EDU_CODIGO						as EDU_CODIGO
,		servicios.serv_codigo							as serv_codigo
,		servicios.SERV_FECHA_INICIO				as 	SERV_FECHA_INICIO
,		servicios.SERV_FECHA_TERMINO			as SERV_FECHA_TERMINO
from DOCUMENTOS_UBB.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
left join DOCUMENTOS_UBB.dbo.categoria_servicio as categoria with(nolock)
on       servicios.CATE_CODIGO=categoria.CATE_CODIGO
and      servicios.OFRE_CODIGO=categoria.OFRE_CODIGO
and      servicios.CCO_CODIGO=categoria.CCO_CODIGO
and      servicios.REP_CODIGO=categoria.REP_CODIGO
and      servicios.EDU_CODIGO=categoria.EDU_CODIGO
left join documentos_ubb.dbo.oficina_reparticion as oficina with(nolock)
on       categoria.OFRE_CODIGO   = oficina.OFRE_CODIGO
and      categoria.CCO_CODIGO    = oficina.CCO_CODIGO
and      categoria.REP_CODIGO    = oficina.REP_CODIGO
and      categoria.EDU_CODIGO    = oficina.EDU_CODIGO
left join Vrae.dbo.reparticion as reparticion with(nolock)
on       oficina.cco_codigo      = reparticion.cco_codigo
and      oficina.rep_codigo      = reparticion.rep_codigo
join  SALAS.[dbo].[edificios] as edificios with(nolock)
on       oficina.edu_codigo      = edificios.id
where	servicios.CATE_CODIGO		= :CATE_CODIGO
and		servicios.OFRE_CODIGO		= :OFRE_CODIGO
and		servicios.CCO_CODIGO		= :CCO_CODIGO
and		servicios.REP_CODIGO		= :REP_CODIGO
and		servicios.EDU_CODIGO		= :EDU_CODIGO
and 		(servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)
order by SERV_NOMBRE
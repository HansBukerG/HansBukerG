select  ltrim(rtrim(servicios.SERV_NOMBRE))         as SERV_NOMBRE
,       ltrim(rtrim(categoria.cate_nombre))         as cate_nombre
,       ltrim(rtrim(reparticion.rep_nombre))        as rep_nombre
,       ltrim(rtrim(edificios.nombre))     as edu_descripcion
,       servicios.CATE_CODIGO                       as CATE_CODIGO
,       servicios.OFRE_CODIGO                       as OFRE_CODIGO
,       servicios.CCO_CODIGO						as CCO_CODIGO
,       servicios.REP_CODIGO						as REP_CODIGO
,       servicios.EDU_CODIGO						as EDU_CODIGO
,		servicios.serv_codigo						as serv_codigo
from DOCUMENTOS_UBB.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
join DOCUMENTOS_UBB.dbo.categoria_servicio as categoria with(nolock)
on       servicios.CATE_CODIGO=categoria.CATE_CODIGO
and      servicios.OFRE_CODIGO=categoria.OFRE_CODIGO
and      servicios.CCO_CODIGO=categoria.CCO_CODIGO
and      servicios.REP_CODIGO=categoria.REP_CODIGO
and      servicios.EDU_CODIGO=categoria.EDU_CODIGO
join documentos_ubb.dbo.oficina_reparticion as oficina with(nolock)
on       categoria.OFRE_CODIGO   = oficina.OFRE_CODIGO
and      categoria.CCO_CODIGO    = oficina.CCO_CODIGO
and      categoria.REP_CODIGO    = oficina.REP_CODIGO
and      categoria.EDU_CODIGO    = oficina.EDU_CODIGO
join Vrae.dbo.reparticion as reparticion with(nolock)
on       oficina.cco_codigo      = reparticion.cco_codigo
and      oficina.rep_codigo      = reparticion.rep_codigo
join  SALAS.[dbo].[edificios] as edificios with(nolock)
on       oficina.edu_codigo      = edificios.id
where    servicios.OFRE_CODIGO   = :OFRE_CODIGO
and      servicios.CCO_CODIGO    = :CCO_CODIGO
and      servicios.REP_CODIGO    = :REP_CODIGO
and      servicios.EDU_CODIGO    = :EDU_CODIGO
order by cate_nombre
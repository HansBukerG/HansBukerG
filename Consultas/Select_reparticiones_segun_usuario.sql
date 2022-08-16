Select cco_codigo,rep_codigo,rtrim(ltrim(rep_nombre)) as rep_nombre
from Vrae.dbo.reparticion with (nolock)
where cmp_codigo=:sede



Select reparticion.cco_codigo as cco_codigo,reparticion.rep_codigo as rep_codigo,rtrim(ltrim(reparticion.rep_nombre)) as rep_nombre
from Vrae.dbo.reparticion as reparticion with (nolock)
join Creditotest.dbo.contrato as contrato with (nolock)
	on reparticion.rep_codigo=contrato.rep_codigo
where reparticion.cmp_codigo=1
and	  contrato.mae_rut=18389381


SELECT	edificios.EDU_DESCRIPCION,
		reparticion.rep_nombre,
		oficina.CCO_CODIGO,
		oficina.REP_CODIGO,
		oficina.EDU_CODIGO,
		oficina.OFRE_CODIGO,
		oficina.OFRE_FECHA_REGISTRO,
		oficina.OFRE_LOG_REGISTRO
FROM	DOCUMENTOS_UBB.dbo.oficina_reparticion as oficina with(nolock)
join	Academia.dbo.EDIFICIOS_UBB as edificios   with(nolock)
on		oficina.EDU_CODIGO = edificios.EDU_CODIGO
join	creditotest.dbo.contrato as contrato with (nolock)
on		oficina.rep_codigo = contrato.rep_codigo
join	vrae.dbo.reparticion as reparticion	with(nolock)
on		reparticion.rep_codigo= oficina.rep_codigo
and		reparticion.cco_codigo= oficina.cco_codigo
where	edificios.cmp_codigo=1
and		contrato.mae_rut=18389381
.Select	rtrim(ltrim(reparticion.rep_nombre)) as rep_nombre
,		rtrim(ltrim(edificios.edu_descripcion)) as edu_descripcion
,		oficina_reparticion.ofre_codigo as ofre_codigo
,		reparticion.cco_codigo as cco_codigo
,		reparticion.rep_codigo as rep_codigo
from	DOCUMENTOS_UBB.dbo.oficina_reparticion 		as oficina_reparticion 	with(nolock)
join 	Vrae.dbo.reparticion 					as reparticion 	with(nolock)
on 		oficina_reparticion.cco_codigo = reparticion.cco_codigo
and 	oficina_reparticion.rep_codigo = reparticion.rep_codigo
join 	Creditotest.dbo.contrato as contrato with (nolock)
on 		reparticion.rep_codigo=contrato.rep_codigo
join Academia.dbo.Edificios_ubb as edificios with(nolock)
on 		oficina_reparticion.edu_codigo = edificios.edu_Codigo
where 	reparticion.cmp_codigo=:sede
and	  	contrato.mae_rut=:rut
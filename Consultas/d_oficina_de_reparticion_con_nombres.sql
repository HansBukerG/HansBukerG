select ltrim(rtrim(reparticion.rep_nombre)) as rep_nombre, 
		ltrim(rtrim(edificios.EDU_DESCRIPCION)) as EDU_DESCRIPCIPCION, 
		oficina.CCO_CODIGO,oficina.EDU_CODIGO,
		oficina.OFRE_CODIGO,
		oficina.rep_codigo,
		edificios.cmp_codigo
from Vrae.dbo.reparticion AS reparticion, Academia.dbo.EDIFICIOS_UBB as edificios, DOCUMENTOS_UBB.dbo.OFICINA_REPARTICION as oficina
where	
		oficina.CCO_CODIGO = reparticion.cco_codigo 
and	oficina.REP_CODIGO = reparticion.rep_codigo
and	oficina.EDU_CODIGO = edificios.EDU_CODIGO
and 	edificios.cmp_codigo=:sede
order by rep_nombre asc
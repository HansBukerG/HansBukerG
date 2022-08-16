Select reparticion.cco_codigo as cco_codigo,reparticion
.rep_codigo as rep_codigo
,rtrim(ltrim(reparticion.rep_nombre)) as rep_nombre,
ubica = 0
from Vrae.dbo.reparticion as reparticion with (nolock)
join Creditotest.dbo.contrato as contrato with (nolock)
	on reparticion.rep_codigo=contrato.rep_codigo
where	reparticion.cmp_codigo=:sede
and	  	contrato.mae_rut=:rut
and 	rep_ind_vigente is null
AND CAST(GETDATE() AS DATE) BETWEEN contrato.cnt_fecha_inicio AND ISNULL(contrato.cnt_fecha_termino, '9999-12-31')
ORDER BY 3
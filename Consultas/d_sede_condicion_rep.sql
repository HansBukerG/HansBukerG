select id as cmp_codigo
, rtrim(ltrim(nombre)) as cmp_nombre
, ubica = 0
from salas.dbo.campus CMP with (nolock)
WHERE EXISTS(

Select 1
from Vrae.dbo.reparticion as reparticion with (nolock)
join Creditotest.dbo.contrato as contrato with (nolock)
	on reparticion.rep_codigo=contrato.rep_codigo
where	reparticion.cmp_codigo=CMP.id
and	  	contrato.mae_rut=:rut
and 	rep_ind_vigente is null
AND CAST(GETDATE() AS DATE) BETWEEN contrato.cnt_fecha_inicio AND ISNULL(contrato.cnt_fecha_termino, '9999-12-31')
)
order by 2
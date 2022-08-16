create procedure dbo.pb_tipo_programa
(
	@ofre_codigo	int
	,@cco_codigo	int
	,@rep_codigo	int
	,@edu_codigo	int
	,@cate_codigo	int
	,@serv_codigo	int
)
as 

select	ltrim(rtrim(tipo_programa.tpr_descripcion)) as tpr_descripcion
,		ltrim(rtrim(tipo_programa.tpr_nemonico)) as tpr_nemonico
,		tipo_programa.tpr_correlativo
from Academia.dbo.tipo_programa as tipo_programa
where tipo_programa.tpr_correlativo not in 
(
	select engloban.tpr_correlativo
	from documentos_ubb.dbo.engloban_programas as engloban with(nolock)
		where 	engloban.ofre_codigo 		= @ofre_codigo
		and 	engloban.cco_codigo 		= @cco_codigo
		and 	engloban.rep_codigo 		= @rep_codigo
		and 	engloban.edu_codigo 		= @edu_codigo
		and 	engloban.cate_codigo 		= @cate_codigo
		and 	engloban.serv_codigo		= @serv_codigo
)
order by 1
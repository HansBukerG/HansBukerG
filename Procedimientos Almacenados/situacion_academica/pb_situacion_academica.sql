create procedure dbo.pb_situacion_academica
(
	@ofre_codigo	int
	,@cco_codigo	int
	,@rep_codigo	int
	,@edu_codigo	int
	,@cate_codigo	int
	,@serv_codigo	int
)
as 

select 	ltrim(rtrim(situacion.saa_descripcion)) as saa_descripcion
,		situacion.saa_codigo as saa_codigo
from academia.dbo.situacion_academica as situacion with(nolock)
where situacion.saa_codigo not in 
(
	select vinculo.saa_codigo
	from documentos_ubb.dbo.servicio_vincula_situacion as vinculo with(nolock)
	where vinculo.ofre_codigo 	= @ofre_codigo
	and vinculo.cco_codigo 		= @cco_codigo
	and vinculo.rep_codigo 		= @rep_codigo
	and vinculo.edu_codigo 		= @edu_codigo
	and vinculo.cate_codigo 	= @cate_codigo
	and vinculo.serv_codigo		= @serv_codigo
)
order by 1
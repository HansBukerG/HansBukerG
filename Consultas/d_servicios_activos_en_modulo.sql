//d_servicios_activos_en_modulo

select 	ltrim(rtrim(servicios.serv_nombre)) 		as serv_nombre
,		ltrim(rtrim(categoria.CATE_nombre)) 		as CATE_nombre
,		asignacion.ASIG_CORRELATIVO					as ASIG_CORRELATIVO
,		asignacion.SERV_CODIGO						as SERV_CODIGO
,		asignacion.CATE_CODIGO						as CATE_CODIGO
,		asignacion.OFRE_CODIGO						as OFRE_CODIGO
,		asignacion.CCO_CODIGO						as CCO_CODIGO
,		asignacion.REP_CODIGO						as REP_CODIGO
,		asignacion.EDU_CODIGO						as EDU_CODIGO
,		asignacion.MOD_CODIGO						as MOD_CODIGO
,		asignacion.Fecha_inicio						as Fecha_inicio	
,		asignacion.fecha_termino					as fecha_termino
,		asignacion.fecha_registro					as fecha_registro
,		ltrim(rtrim(asignacion.Log_registro)) 		as Log_registro
from documentos_ubb.dbo.SERVICIOS_SE_ASIGNAN as asignacion with(nolock)
join documentos_ubb.dbo.modulos_atencion as modulos with(nolock)
on 	modulos.MOD_CODIGO 		= 	asignacion.MOD_CODIGO
and modulos.OFRE_CODIGO 	= 	asignacion.OFRE_CODIGO
and modulos.CCO_CODIGO 		= 	asignacion.CCO_CODIGO
and modulos.REP_CODIGO 		= 	asignacion.REP_CODIGO
and modulos.EDU_CODIGO 		= 	asignacion.EDU_CODIGO
and (modulos.MOD_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR modulos.MOD_FECHA_TERMINO IS NULL)
join documentos_ubb.dbo.servicios_reparticion as servicios with(nolock)
on	servicios.SERV_CODIGO 	= asignacion.SERV_CODIGO
and servicios.CATE_CODIGO 	= asignacion.CATE_CODIGO
and servicios.OFRE_CODIGO 	= asignacion.OFRE_CODIGO
and servicios.CCO_CODIGO 	= asignacion.CCO_CODIGO
and servicios.REP_CODIGO 	= asignacion.REP_CODIGO
and servicios.EDU_CODIGO 	= asignacion.EDU_CODIGO
and (servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)
join documentos_ubb.dbo.categoria_servicio as categoria with(nolock)
on	categoria.CATE_CODIGO 	= servicios.CATE_CODIGO
and categoria.OFRE_CODIGO 	= servicios.OFRE_CODIGO
and categoria.CCO_CODIGO 	= servicios.CCO_CODIGO
and categoria.REP_CODIGO 	= servicios.REP_CODIGO
and categoria.EDU_CODIGO 	= servicios.EDU_CODIGO
and (categoria.CATE_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR categoria.CATE_FECHA_TERMINO IS NULL)
where 	asignacion.MOD_CODIGO 	= :MOD_CODIGO
and		asignacion.OFRE_CODIGO 	= :OFRE_CODIGO
and		asignacion.CCO_CODIGO 	= :CCO_CODIGO
and		asignacion.REP_CODIGO 	= :REP_CODIGO
and		asignacion.EDU_CODIGO 	= :EDU_CODIGO
and 	(asignacion.fecha_termino >= CONVERT(DATETIME,GETDATE()) OR asignacion.fecha_termino IS NULL)
order by CATE_nombre
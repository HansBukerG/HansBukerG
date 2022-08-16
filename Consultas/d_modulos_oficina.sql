 select	ltrim(rtrim(edificios.nombre)) as edu_descripcion
,		ltrim(rtrim(reparticion.rep_nombre)) as rep_nombre
,	ltrim(rtrim(modulos.MOD_NOMBRE)) as MOD_NOMBRE
,	ltrim(rtrim(modulos.mod_abreviacion)) as mod_abreviacion
,	modulos.mod_codigo as mod_codigo
,	modulos.ofre_codigo as ofre_codigo
,	modulos.cco_codigo as cco_codigo
,	modulos.REP_CODIGO as REP_CODIGO
,	modulos.EDU_CODIGO as edu_Codigo
,	modulos.MOD_FECHA_INICIO as MOD_FECHA_INICIO
,	modulos.MOD_FECHA_TERMINO as MOD_FECHA_TERMINO
,	modulos.mod_fecha_registro as mod_fecha_registro
,	modulos.mod_log_registro as mod_log_registro
from documentos_ubb.dbo.modulos_atencion as modulos with(nolock)
join documentos_ubb.dbo.OFICINA_REPARTICION as oficina with(nolock)
on oficina.OFRE_CODIGO	= modulos.ofre_codigo
and oficina.cco_codigo = modulos.CCO_CODIGO
and oficina.REP_CODIGO = modulos.REP_CODIGO
and oficina.EDU_CODIGO = modulos.edu_codigo
join Vrae.dbo.reparticion as reparticion with(nolock)
on oficina.cco_codigo = reparticion.cco_codigo
and oficina.rep_codigo = reparticion.rep_codigo
join  SALAS.[dbo].[edificios] as edificios with(nolock)
on       oficina.edu_codigo      = edificios.id
where	modulos.ofre_codigo 		= :ofre_codigo
and		modulos.cco_codigo 		= :cco_codigo
and		modulos.REP_CODIGO 	= :REP_CODIGO
and		modulos.EDU_CODIGO 	= :edu_Codigo
and 		(modulos.MOD_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR modulos.MOD_FECHA_TERMINO IS NULL)


//trasladado a powerbuilder
 select	ltrim(rtrim(edificios.nombre)) as edu_descripcion
,		ltrim(rtrim(reparticion.rep_nombre)) as rep_nombre
,	ltrim(rtrim(modulos.MOD_NOMBRE)) as MOD_NOMBRE
,	ltrim(rtrim(modulos.mod_abreviacion)) as mod_abreviacion
,	modulos.mod_codigo as mod_codigo
,	modulos.ofre_codigo as ofre_codigo
,	modulos.cco_codigo as cco_codigo
,	modulos.REP_CODIGO as REP_CODIGO
,	modulos.EDU_CODIGO as edu_Codigo
,	modulos.MOD_FECHA_INICIO as MOD_FECHA_INICIO
,	modulos.MOD_FECHA_TERMINO as MOD_FECHA_TERMINO
,	modulos.mod_fecha_registro as mod_fecha_registro
,	modulos.mod_log_registro as mod_log_registro
from documentos_ubb.dbo.modulos_atencion as modulos with(nolock)
join documentos_ubb.dbo.OFICINA_REPARTICION as oficina with(nolock)
on oficina.OFRE_CODIGO	= modulos.ofre_codigo
and oficina.cco_codigo = modulos.CCO_CODIGO
and oficina.REP_CODIGO = modulos.REP_CODIGO
and oficina.EDU_CODIGO = modulos.edu_codigo
join Vrae.dbo.reparticion as reparticion with(nolock)
on oficina.cco_codigo = reparticion.cco_codigo
and oficina.rep_codigo = reparticion.rep_codigo
join  SALAS.[dbo].[edificios] as edificios with(nolock)
on       oficina.edu_codigo      = edificios.id
where	modulos.ofre_codigo 		= :ofre_codigo
and		modulos.cco_codigo 		= :cco_codigo
and		modulos.REP_CODIGO 	= :REP_CODIGO
and		modulos.EDU_CODIGO 	= :edu_Codigo
and 		(modulos.MOD_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR modulos.MOD_FECHA_TERMINO IS NULL)
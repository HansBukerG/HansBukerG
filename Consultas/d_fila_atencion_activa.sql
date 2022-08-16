select motivo.moat_fecha_registro	
,		motivo.MOAT_FECHA
,		motivo.moat_numero
,		motivo.MOAT_CODIGO
,		fila.FILA_CODIGO
,		motivo.serv_codigo
,		motivo.cate_codigo
,		servicios.serv_nombre
,		servicios.serv_abreviacion
,		fila.FILA_NOMBRE
,		fila.FILA_APELLIDO_PATERNO
,		fila.FILA_APELLIDO_MATERNO
,		fila.fila_fecha
,		fila.fila_rut
from documentos_ubb.dbo.MOTIVO_ATENCION as motivo with(nolock)
join documentos_ubb.dbo.FILAS_ATENCION as fila with(nolock)
on 		motivo.FILA_FECHA = fila.FILA_FECHA
and 	motivo.FILA_CODIGO = fila.FILA_CODIGO
and 	motivo.OFRE_CODIGO = fila.OFRE_CODIGO
and 	motivo.CCO_CODIGO = fila.CCO_CODIGO
and 	motivo.REP_CODIGO = fila.REP_CODIGO
and 	motivo.EDU_CODIGO = fila.EDU_CODIGO
and     fila.FILA_FECHA = CONVERT(DATE,GETDATE())
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on		motivo.SERV_CODIGO = servicios.SERV_CODIGO
and		motivo.CATE_CODIGO = servicios.CATE_CODIGO
and		motivo.OFRE_CODIGO = servicios.OFRE_CODIGO
and		motivo.CCO_CODIGO = servicios.CCO_CODIGO
and		motivo.REP_CODIGO = servicios.REP_CODIGO
and		motivo.EDU_CODIGO = servicios.EDU_CODIGO
and		(servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)
join documentos_ubb.dbo.SERVICIOS_SE_ASIGNAN as asignan with(nolock)
on 		servicios.SERV_CODIGO = asignan.SERV_CODIGO
and		servicios.CATE_CODIGO = asignan.CATE_CODIGO
and		servicios.OFRE_CODIGO = asignan.OFRE_CODIGO
and		servicios.CCO_CODIGO = asignan.CCO_CODIGO
and		servicios.REP_CODIGO = asignan.REP_CODIGO
and		servicios.EDU_CODIGO = asignan.EDU_CODIGO
and		(asignan.fecha_termino >= CONVERT(DATETIME,GETDATE()) OR asignan.fecha_termino IS NULL)
join documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
on		asignan.MOD_CODIGO 	= modulos.MOD_CODIGO
and		asignan.OFRE_CODIGO = modulos.OFRE_CODIGO
and		asignan.CCO_CODIGO 	= modulos.CCO_CODIGO
and		asignan.REP_CODIGO 	= modulos.REP_CODIGO
and		asignan.EDU_CODIGO 	= modulos.EDU_CODIGO
and		(modulos.MOD_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR modulos.MOD_FECHA_TERMINO IS NULL)
join documentos_ubb.dbo.MODULOS_ASIGNADOS as asignados with(nolock)
on		asignados.MOD_CODIGO 	= modulos.MOD_CODIGO
and		asignados.OFRE_CODIGO 	= modulos.OFRE_CODIGO
and		asignados.CCO_CODIGO 	= modulos.CCO_CODIGO
and		asignados.REP_CODIGO 	= modulos.REP_CODIGO
and		asignados.EDU_CODIGO 	= modulos.EDU_CODIGO
and		(asignados.MODU_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR asignados.MODU_FECHA_TERMINO IS NULL)
join documentos_ubb.dbo.USUARIOS_OFICINA as usuarios with(nolock)
on 		usuarios.USOF_CODIGO 	= asignados.USOF_CODIGO
and		usuarios.OFRE_CODIGO 	= asignados.OFRE_CODIGO
and		usuarios.CCO_CODIGO 	= asignados.CCO_CODIGO
and		usuarios.REP_CODIGO 	= asignados.REP_CODIGO
and		usuarios.EDU_CODIGO 	= asignados.EDU_CODIGO
and		(usuarios.USOF_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR usuarios.USOF_FECHA_TERMINO IS NULL)
join documentos_ubb.dbo.atencion_asignada as atencion_asignada with(nolock)
on		motivo.MOAT_FECHA 	= atencion_asignada.MOAT_FECHA
and		motivo.OFRE_CODIGO 	= atencion_asignada.OFRE_CODIGO
and		motivo.CCO_CODIGO 	= atencion_asignada.CCO_CODIGO
and		motivo.REP_CODIGO 	= atencion_asignada.REP_CODIGO
and		motivo.EDU_CODIGO 	= atencion_asignada.EDU_CODIGO
where	atencion_asignada.MOAT_FECHA  = CONVERT(DATE,GETDATE())
and 	atencion_asignada.MODU_CODIGO =:MODU_CODIGO
and		atencion_asignada.OFRE_CODIGO =:OFRE_CODIGO
and		atencion_asignada.CCO_CODIGO  =:CCO_CODIGO
and		atencion_asignada.REP_CODIGO  =:REP_CODIGO
and		atencion_asignada.EDU_CODIGO  =:EDU_CODIGO
and		motivo.estad_codigo = 2

-- Consulta 2.0

select	fila.FILA_FECHA_REGISTRO
,		fila.FILA_RUT
,		fila.FILA_NOMBRE
,		fila.FILA_APELLIDO_PATERNO
,		fila.FILA_APELLIDO_MATERNO
,		servicios.serv_nombre
,		servicios.CATE_CODIGO
,		servicios.serv_codigo
,		fila.fila_codigo
,		fila.FILA_FECHA
,		estado.estad_codigo
from documentos_ubb.dbo.atencion_asignada as asignada with(nolock)
join documentos_ubb.dbo.servicios_reparticion as servicios with(nolock)
on asignada.serv_codigo = servicios.serv_codigo
and asignada.serv_codigo = servicios.serv_codigo
and asignada.CATE_CODIGO = servicios.CATE_CODIGO
and asignada.OFRE_CODIGO = servicios.OFRE_CODIGO
and asignada.CCO_CODIGO = servicios.CCO_CODIGO
and asignada.REP_CODIGO = servicios.REP_CODIGO
and asignada.EDU_CODIGO = servicios.EDU_CODIGO
and	(servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)
join documentos_ubb.dbo.filas_ATENCION as fila with(nolock)
on asignada.fila_fecha = fila.fila_fecha
and asignada.FILA_CODIGO = fila.FILA_CODIGO
and asignada.OFRE_CODIGO = fila.OFRE_CODIGO
and asignada.CCO_CODIGO = fila.CCO_CODIGO
and asignada.REP_CODIGO = fila.REP_CODIGO
and asignada.EDU_CODIGO = fila.EDU_CODIGO
and fila.FILA_FECHA = CONVERT(DATE,GETDATE())
join DOCUMENTOS_UBB.dbo.estado_atencion as estado with(nolock)
on asignada.ESTAD_CODIGO = estado.ESTAD_CODIGO
where	asignada.MOAT_FECHA   = CONVERT(DATE,GETDATE())
and 		asignada.MODU_CODIGO  =:MODU_CODIGO
and		asignada.OFRE_CODIGO  =:OFRE_CODIGO
and		asignada.CCO_CODIGO   =:CCO_CODIGO
and		asignada.REP_CODIGO   =:REP_CODIGO
and		asignada.EDU_CODIGO   =:EDU_CODIGO
and 		asignada.estad_codigo = :estad_codigo
order by 1 desc
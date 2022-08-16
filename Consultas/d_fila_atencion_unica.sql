select motivo.MOAT_FECHA
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
where	motivo.MOAT_FECHA 	= CONVERT(DATE,GETDATE())
and		fila.OFRE_CODIGO 	=:OFRE_CODIGO
and		fila.CCO_CODIGO 	=:CCO_CODIGO
and		fila.REP_CODIGO 	=:REP_CODIGO
and		fila.EDU_CODIGO 	=:EDU_CODIGO
order by motivo.MOAT_FECHA_REGISTRO
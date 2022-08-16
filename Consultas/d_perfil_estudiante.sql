select	top 1 	alumno.alu_rut		 as alu_rut
,				alumno.alu_nombres 	as alu_nombres
,				alumno.alu_apellido_paterno as alu_apellido_paterno
,				alumno.alu_apellido_materno as alu_apellido_materno
,				programa.tpr_descripcion as tpr_descripcion
,				situacion.saa_descripcion as saa_descripcion
,				programa.tpr_correlativo as tpr_correlativo
,				situacion.saa_codigo as saa_codigo
,				plan_carrera.pca_codigo as pca_codigo
,				carrera.alc_ano_ingreso as ano_ingreso
,				carrera.alc_periodo as periodo_ingreso
from academia.dbo.alumno as alumno with(nolock)
join academia.dbo.alumno_carrera as carrera with(nolock)
on alumno.alu_rut = carrera.alu_rut
join academia.dbo.PLAN_CARRERA as plan_carrera with(nolock)
on plan_carrera.crr_codigo = carrera.crr_codigo
and plan_carrera.pca_codigo = carrera.pca_codigo
join academia.dbo.TIPO_PROGRAMA as programa with(nolock)
on programa.tpr_correlativo = plan_carrera.tpr_correlativo
join academia..situacion_academica as situacion with(nolock)
on situacion.saa_codigo = carrera.saa_codigo
where alumno.alu_rut 	= :rut
order by alc_ano_ingreso desc
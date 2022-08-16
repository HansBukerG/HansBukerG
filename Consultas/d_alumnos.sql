select alumno.alu_rut
,		alumno.alu_nombres
,		alumno.alu_apellido_paterno
,		alumno.alu_apellido_materno
,		alumno.alu_email
,		alumno.alu_email_opcional
,		plan_carrera.PCA_CRR_NOMBRE
,		programa.tpr_descripcion
,		programa.tpr_nemonico
from academia.dbo.alumno as alumno with(nolock)
join Academia.dbo.ALUMNO_CARRERA as carrera with(nolock)
on alumno.alu_rut = carrera.alu_rut
join academia.dbo.plan_carrera as plan_carrera with(nolock)
on carrera.crr_codigo = plan_carrera.crr_codigo
and carrera.pca_codigo = plan_carrera.pca_codigo
join academia.dbo.tipo_programa as programa with(nolock)
on plan_carrera.tpr_correlativo = programa.tpr_correlativo
where alumno.alu_rut = 18389381
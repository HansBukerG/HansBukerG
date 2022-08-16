create table dbo.servicio_vincula_situacion 
(
   SERV_CODIGO          integer                        not null,
   CATE_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   SAA_CODIGO           integer                        not null,
   SVS_CODIGO           integer                        not null,
   SVS_FECHA_REGISTRO   datetime                       null,
   SVS_LOG_REGISTRO     varchar(250)                   null,
   constraint PK_RELATIONSHIP_40 primary key clustered (SERV_CODIGO, SAA_CODIGO,CATE_CODIGO,OFRE_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO,SVS_CODIGO)
);

create table dbo.ENGLOBAN_PROGRAMAS 
(
	ENPR_CODIGO          integer					not null,
	TPR_CORRELATIVO      integer					not null,
	SERV_CODIGO          integer                    not null,
	CATE_CODIGO          integer                    not null,
	OFRE_CODIGO          integer					not null,
	CCO_CODIGO           decimal					not null,
	REP_CODIGO           decimal					not null,
	EDU_CODIGO           integer					not null,
	ENPR_FECHA_REGISTRO  datetime						null,
	ENPR_LOG_REGISTRO    varchar(250)					null,
	primary key clustered (ENPR_CODIGO,TPR_CORRELATIVO, SERV_CODIGO,CATE_CODIGO,OFRE_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO)
);

select modulos.MOD_NOMBRE,count(filas.fila_codigo) as minimo
from documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
join documentos_ubb.dbo.SERVICIOS_SE_ASIGNAN as asignan with(nolock)
on    modulos.MOD_CODIGO  = asignan.MOD_CODIGO   
and   modulos.OFRE_CODIGO = asignan.OFRE_CODIGO
and   modulos.CCO_CODIGO  = asignan.CCO_CODIGO
and   modulos.REP_CODIGO  = asignan.REP_CODIGO
and   modulos.EDU_CODIGO  = asignan.EDU_CODIGO
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on    asignan.SERV_CODIGO = servicios.SERV_CODIGO
and   asignan.CATE_CODIGO = servicios.CATE_CODIGO
and   asignan.OFRE_CODIGO = servicios.OFRE_CODIGO
and   asignan.CCO_CODIGO  = servicios.CCO_CODIGO
and   asignan.REP_CODIGO  = servicios.REP_CODIGO
and   asignan.EDU_CODIGO  = servicios.EDU_CODIGO
join documentos_ubb.dbo.servicio_vincula_situacion as situacion with(nolock)
on    servicios.SERV_CODIGO = situacion.SERV_CODIGO
and   servicios.CATE_CODIGO = situacion.CATE_CODIGO
and   servicios.OFRE_CODIGO = situacion.OFRE_CODIGO
and   servicios.CCO_CODIGO  = situacion.CCO_CODIGO
and   servicios.REP_CODIGO  = situacion.REP_CODIGO
and   servicios.EDU_CODIGO  = situacion.EDU_CODIGO
left join documentos_ubb.dbo.filas_atencion as filas with(nolock)
on		filas.MOD_CODIGO  = modulos.MOD_CODIGO
and     filas.OFRE_CODIGO = modulos.OFRE_CODIGO
and     filas.CCO_CODIGO  = modulos.CCO_CODIGO
and     filas.REP_CODigo  = modulos.REP_CODIGO
and     filas.EDU_CODIGO  = modulos.EDU_CODIGO
where   servicios.CATE_CODIGO   = 1
and   servicios.SERV_CODIGO   = 2
group by modulos.MOD_NOMBRE


select *
from documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
join documentos_ubb.dbo.SERVICIOS_SE_ASIGNAN as asignan with(nolock)
on    modulos.MOD_CODIGO  = asignan.MOD_CODIGO   
and   modulos.OFRE_CODIGO = asignan.OFRE_CODIGO
and   modulos.CCO_CODIGO  = asignan.CCO_CODIGO
and   modulos.REP_CODIGO  = asignan.REP_CODIGO
and   modulos.EDU_CODIGO  = asignan.EDU_CODIGO
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on    asignan.SERV_CODIGO = servicios.SERV_CODIGO
and   asignan.CATE_CODIGO = servicios.CATE_CODIGO
and   asignan.OFRE_CODIGO = servicios.OFRE_CODIGO
and   asignan.CCO_CODIGO  = servicios.CCO_CODIGO
and   asignan.REP_CODIGO  = servicios.REP_CODIGO
and   asignan.EDU_CODIGO  = servicios.EDU_CODIGO
left join documentos_ubb.dbo.filas_atencion as filas with(nolock)
on		filas.MOD_CODIGO  = modulos.MOD_CODIGO
and     filas.OFRE_CODIGO = modulos.OFRE_CODIGO
and     filas.CCO_CODIGO  = modulos.CCO_CODIGO
and     filas.REP_CODigo  = modulos.REP_CODIGO
and     filas.EDU_CODIGO  = modulos.EDU_CODIGO
--join documentos_ubb.dbo.ENGLOBAN_PROGRAMAS as programa with(nolock)
--on    servicios.SERV_CODIGO = programa.SERV_CODIGO
--and   servicios.CATE_CODIGO = programa.CATE_CODIGO
--and   servicios.OFRE_CODIGO = programa.OFRE_CODIGO
--and   servicios.CCO_CODIGO  = programa.CCO_CODIGO
--and   servicios.REP_CODIGO  = programa.REP_CODIGO
--and   servicios.EDU_CODIGO  = programa.EDU_CODIGO
--join documentos_ubb.dbo.servicio_vincula_situacion as situacion with(nolock)
--on    servicios.SERV_CODIGO = situacion.SERV_CODIGO
--and   servicios.CATE_CODIGO = situacion.CATE_CODIGO
--and   servicios.OFRE_CODIGO = situacion.OFRE_CODIGO
--and   servicios.CCO_CODIGO  = situacion.CCO_CODIGO
--and   servicios.REP_CODIGO  = situacion.REP_CODIGO
--and   servicios.EDU_CODIGO  = situacion.EDU_CODIGO
where   servicios.CATE_CODIGO   = 1
and   servicios.SERV_CODIGO   = 2
group by modulos.MOD_NOMBRE


//este codigo si funciona

DECLARE @rut INT,
@trp_codigo INT,
@saa_codigo INT

SELECT @rut = 17221208

select	top 1 	/*alumno.alu_rut		 as alu_rut
,				alumno.alu_nombres 	as alu_nombres
,				programa.tpr_descripcion as tpr_descripcion
,				situacion.saa_descripcion as saa_descripcion
,				programa.tpr_correlativo as tpr_correlativo
,				situacion.saa_codigo as saa_codigo*/
@trp_codigo = programa.tpr_correlativo,
@saa_codigo = situacion.saa_codigo
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
where alumno.alu_rut 	= @rut
order by alc_ano_ingreso desc


--SELECT @trp_codigo, @saa_codigo

select distinct modulos.MOD_NOMBRE,
count(filas.fila_codigo) as minimo,
programa.TPR_CORRELATIVO,
situacion.SAA_CODIGO,
SAA.saa_descripcion
from documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
join documentos_ubb.dbo.SERVICIOS_SE_ASIGNAN as asignan with(nolock)
on    modulos.MOD_CODIGO  = asignan.MOD_CODIGO   
and   modulos.OFRE_CODIGO = asignan.OFRE_CODIGO
and   modulos.CCO_CODIGO  = asignan.CCO_CODIGO
and   modulos.REP_CODIGO  = asignan.REP_CODIGO
and   modulos.EDU_CODIGO  = asignan.EDU_CODIGO
AND CAST(GETDATE() AS DATE) BETWEEN asignan.Fecha_inicio AND ISNULL(asignan.fecha_termino, '9999-12-31')
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on    asignan.SERV_CODIGO = servicios.SERV_CODIGO
and   asignan.CATE_CODIGO = servicios.CATE_CODIGO
and   asignan.OFRE_CODIGO = servicios.OFRE_CODIGO
and   asignan.CCO_CODIGO  = servicios.CCO_CODIGO
and   asignan.REP_CODIGO  = servicios.REP_CODIGO
and   asignan.EDU_CODIGO  = servicios.EDU_CODIGO
AND CAST(GETDATE() AS DATE) BETWEEN servicios.SERV_FECHA_INICIO AND ISNULL(servicios.SERV_FECHA_TERMINO, '9999-12-31')
left join documentos_ubb.dbo.filas_atencion as filas with(nolock)
on		filas.MOD_CODIGO  = modulos.MOD_CODIGO
and     filas.OFRE_CODIGO = modulos.OFRE_CODIGO
and     filas.CCO_CODIGO  = modulos.CCO_CODIGO
and     filas.REP_CODigo  = modulos.REP_CODIGO
and     filas.EDU_CODIGO  = modulos.EDU_CODIGO
join documentos_ubb.dbo.ENGLOBAN_PROGRAMAS as programa with(nolock)
on    servicios.SERV_CODIGO = programa.SERV_CODIGO
and   servicios.CATE_CODIGO = programa.CATE_CODIGO
and   servicios.OFRE_CODIGO = programa.OFRE_CODIGO
and   servicios.CCO_CODIGO  = programa.CCO_CODIGO
and   servicios.REP_CODIGO  = programa.REP_CODIGO
and   servicios.EDU_CODIGO  = programa.EDU_CODIGO


join documentos_ubb.dbo.servicio_vincula_situacion as situacion with(nolock)
on    servicios.SERV_CODIGO = situacion.SERV_CODIGO
and   servicios.CATE_CODIGO = situacion.CATE_CODIGO
and   servicios.OFRE_CODIGO = situacion.OFRE_CODIGO
and   servicios.CCO_CODIGO  = situacion.CCO_CODIGO
and   servicios.REP_CODIGO  = situacion.REP_CODIGO
and   servicios.EDU_CODIGO  = situacion.EDU_CODIGO
JOIN ACADEMIA.DBO.SITUACION_ACADEMICA SAA with(nolock) ON SAA.saa_codigo = situacion.SAA_CODIGO
where   servicios.CATE_CODIGO   = 1
and   servicios.SERV_CODIGO   = 2
AND CAST(GETDATE() AS DATE) BETWEEN modulos.mod_fecha_inicio AND ISNULL(modulos.mod_fecha_termino, '9999-12-31')
AND programa.TPR_CORRELATIVO = @trp_codigo
AND situacion.saa_codigo = @saa_codigo
group by modulos.MOD_NOMBRE, programa.TPR_CORRELATIVO, programa.TPR_CORRELATIVO, situacion.SAA_CODIGO, SAA.saa_descripcion
order by minimo

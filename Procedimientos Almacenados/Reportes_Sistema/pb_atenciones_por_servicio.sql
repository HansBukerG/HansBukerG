
/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: Hans Buker gutiérrez
	@-Fecha_Modificacion0: 25-07-2018
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, informes_del_sistema, 
	
	@-Parametro_Entrada0: ofre_codigo
	@-Parametro_Entrada1: cco_codigo
	@-Parametro_Entrada2: rep_codigo
	@-Parametro_Entrada3: edu_codigo
	@-Parametro_Entrada4: mae_rut
	@-Parametro_Entrada5: rut_cliente
	@-Parametro_Entrada6: fecha_hasta
	@-Parametro_Entrada7: Fecha_desde
	@-Parametro_Entrada8: serv_codigo
	@-Parametro_Entrada9: cate_codigo
	@-Parametro_Entrada10: saa_codigo
	@-Parametro_Entrada11: tpr_correlativo
	@-Parametro_Entrada12: estad_codigo
	@-Parametro_Entrada13: hora_desde
	@-Parametro_Entrada14: hora_hasta

	@-Parametro_Salida0: cate_nombre
	@-Parametro_Salida1: serv_nombre
	@-Parametro_Salida2: count(*) as atenciones_por_servicio

	@-Descripcion_Objeto0: SP de reporte con atenciones por servicio del Sistema de Gestión de Filas
	@-Regla_Objeto0: Debe existir una oficina de reparticion con actividad para poder generar reporte
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_atenciones_por_servicio;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_atenciones_por_servicio
(
	 	@ofre_codigo		integer
	, 	@cco_codigo			decimal
	, 	@rep_codigo			decimal
	, 	@edu_codigo			integer
	, 	@mae_rut			integer
	, 	@rut_cliente		integer
	, 	@fecha_hasta		datetime
	, 	@Fecha_desde		datetime
	, 	@serv_codigo		integer
	, 	@cate_codigo		integer
	, 	@saa_codigo			integer
	, 	@tpr_correlativo	integer
	, 	@estad_codigo		integer
	, 	@hora_desde			varchar(8)
	, 	@hora_hasta			varchar(8)
)

as

DECLARE @temp TABLE
(
	rut INT,
	dv CHAR(1),
	nombre VARCHAR(60),
	estad_codigo INT,
	tpr_descripcion VARCHAR(50),
	tpr_correlativo INT,
	saa_descripcion VARCHAR(100),
	saa_codigo INT,
	pca_crr_nombre VARCHAR(60),
	crr_codigo INT,
	pca_codigo INT,
	ano_ingreso INT,
	periodo_ingreso INT,
	cmp_codigo INT,
	cmp_nombre VARCHAR(20),
	fecha_registro datetime,
	hora_fecha_registro datetime,
	inicio_atencion		datetime,
	fin_atencion		datetime,
	tiempo_espera		datetime,
	duracion_atencion	datetime,
	serv_codigo			integer,
	serv_nombre			varchar(250),
	cate_codigo			integer,
	cate_nombre			varchar(250),
	nombre_funcionario varchar(250),
	rut_funcionario		integer,
	dv_funcionario		char(1),
	tipo_usuario		varchar(20),
	moat_numero VARCHAR(11),
	origen INT
)
--Alumno
INSERT INTO @temp
(
rut,
dv,
nombre,
moat_numero,
estad_codigo,
tpr_descripcion,
tpr_correlativo,
saa_descripcion,
saa_codigo,
pca_crr_nombre,
crr_codigo,
pca_codigo,
ano_ingreso,
periodo_ingreso,
cmp_codigo,
cmp_nombre,

fecha_registro,
hora_fecha_registro ,
inicio_atencion		,
fin_atencion		,
tiempo_espera		,
duracion_atencion	,

serv_codigo			,
serv_nombre			,
cate_codigo			,
cate_nombre			,

nombre_funcionario	,

rut_funcionario		,
dv_funcionario		,

tipo_usuario		,
origen
)
SELECT filas.FILA_RUT,
ALU.alu_dv,
RTRIM(LTRIM(ALU.alu_apellido_paterno)) + ' ' + RTRIM(LTRIM(ALU.alu_apellido_materno)) + ' ' + RTRIM(LTRIM(ALU.alu_nombres)),
motivo.MOAT_NUMERO,
atencion.ESTAD_CODIGO,
programa.tpr_descripcion
,				programa.tpr_correlativo

--Datos situacion académica
,				situacion.saa_descripcion
,				situacion.saa_codigo 

--Datos PLAN_CARRERA
,				plan_carrera.pca_crr_nombre
,				plan_carrera.crr_codigo
,				plan_carrera.pca_codigo 

-- Datos alumno_carrera
,				carrera.alc_ano_ingreso
,				carrera.alc_periodo

-- Datos campus
,				cmp.id 
,				cmp.nombre
--Registro de fecha
,	motivo.MOAT_FECHA_REGISTRO
, 	CONVERT(VARCHAR(10),motivo.MOAT_FECHA_REGISTRO,108)											as hora_fecha_registro
, 	CONVERT(VARCHAR(10),atencion.atas_fecha_atencion,108)										as inicio_atencion
,  	CONVERT(VARCHAR(10),atencion.atas_fecha_registro,108)										as fin_atencion
,  	CONVERT(VARCHAR(10),atencion.atas_fecha_atencion-motivo.MOAT_FECHA_REGISTRO,108)			AS Tiempo_espera
,  	CONVERT(VARCHAR(10),atencion.atas_fecha_registro-atencion.atas_fecha_atencion,108)			AS Duracion_atencion

--Datos Servicio y Categoria
,	servicios.SERV_CODIGO
,	servicios.SERV_NOMBRE
,	categoria.CATE_CODIGO
,	categoria.CATE_NOMBRE

,	rtrim(ltrim(MAEPER.mae_nombre))+' '+rtrim(ltrim(MAEPER.mae_apellido_paterno)) +' '+ rtrim(ltrim(MAEPER.mae_apellido_materno))
,	maeper.mae_rut
,	maeper.mae_dv

--Origen
,	'Estudiante'
,	1
FROM documentos_ubb.dbo.FILAS_ATENCION filas
JOIN ACADEMIA.DBO.ALUMNO ALU with(nolock) ON ALU.alu_rut = filas.FILA_RUT
join documentos_ubb.dbo.motivo_atencion as motivo with(nolock) 
on 		motivo.fila_year 			= filas.FILA_year
and 	motivo.FILA_CODIGO 			= filas.FILA_CODIGO
and 	motivo.OFRE_CODIGO 			= filas.OFRE_CODIGO
and 	motivo.REP_CODIGO 			= filas.REP_CODIGO
and 	motivo.EDU_CODIGO 			= filas.EDU_CODIGO

join DOCUMENTOS_UBB.dbo.ATENCION_ASIGNADA as atencion with(nolock)
on 		atencion.FILA_YEAR 		= motivo.FILA_YEAR
and		atencion.FILA_CODIGO 	= motivo.FILA_CODIGO
and		atencion.MOAT_CODIGO 	= motivo.MOAT_CODIGO
and		atencion.OFRE_CODIGO 	= motivo.OFRE_CODIGO
and		atencion.REP_CODIGO 	= motivo.REP_CODIGO
and		atencion.EDU_CODIGO 	= motivo.EDU_CODIGO

join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on   atencion.SERV_CODIGO    = servicios.SERV_CODIGO
and atencion.CATE_CODIGO    = servicios.CATE_CODIGO
and atencion.OFRE_CODIGO    = servicios.OFRE_CODIGO
and atencion.REP_CODIGO     = servicios.REP_CODIGO
and atencion.EDU_CODIGO     = servicios.EDU_CODIGO

join documentos_ubb.dbo.CATEGORIA_SERVICIO as categoria with(nolock)
on   servicios.CATE_CODIGO      = categoria.CATE_CODIGO
and servicios.OFRE_CODIGO     = categoria.OFRE_CODIGO
and servicios.CCO_CODIGO      = categoria.CCO_CODIGO
and servicios.REP_CODIGO      = categoria.REP_CODIGO
and servicios.EDU_CODIGO      = categoria.EDU_CODIGO

join academia.dbo.alumno_carrera as carrera with(nolock)
on 	alu.alu_rut			= carrera.alu_rut
and carrera.alc_ano_ingreso	= motivo.alc_ano_ingreso
and carrera.alc_periodo		= motivo.alc_periodo
join academia.dbo.PLAN_CARRERA as plan_carrera with(nolock)
on plan_carrera.crr_codigo = carrera.crr_codigo
and plan_carrera.crr_codigo = motivo.crr_codigo
and plan_carrera.pca_codigo = motivo.pca_codigo

join academia.dbo.TIPO_PROGRAMA as programa with(nolock)
on programa.tpr_correlativo = plan_carrera.tpr_correlativo
join academia..situacion_academica as situacion with(nolock)
on situacion.saa_codigo = carrera.saa_codigo
join salas.dbo.campus as cmp with(nolock)
on plan_carrera.cmp_codigo = cmp.id
and plan_carrera.pca_codigo = carrera.pca_codigo

join documentos_ubb.dbo.MODULOS_ASIGNADOS as asignacion with(nolock)
On   atencion.MODU_CODIGO  = asignacion.MODU_CODIGO
AND atencion.mod_codigo	= asignacion.mod_codigo
and  atencion.usof_codigo	= asignacion.usof_codigo
and  atencion.OFRE_CODIGO  = asignacion.OFRE_CODIGO
and  atencion.REP_CODIGO   = asignacion.REP_CODIGO
and  atencion.EDU_CODIGO   = asignacion.EDU_CODIGO

join documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
on    asignacion.MOD_CODIGO   = modulos.MOD_CODIGO
and  asignacion.OFRE_CODIGO  = modulos.OFRE_CODIGO
and  asignacion.CCO_CODIGO   = modulos.CCO_CODIGO
and  asignacion.REP_CODIGO   = modulos.REP_CODIGO
and  asignacion.EDU_CODIGO   = modulos.EDU_CODIGO

join documentos_ubb.dbo.USUARIOS_OFICINA as usuarios with(nolock)
on    asignacion.USOF_CODIGO  = usuarios.USOF_CODIGO
and  asignacion.OFRE_CODIGO  = usuarios.OFRE_CODIGO
and  asignacion.CCO_CODIGO   = usuarios.CCO_CODIGO
and  asignacion.REP_CODIGO   = usuarios.REP_CODIGO
and  asignacion.EDU_CODIGO   = usuarios.EDU_CODIGO

join CREDITOTEST.dbo.maeper as MAEPER with(nolock)    
on   usuarios.MAE_RUT  =  MAEPER.mae_rut

--WHERE motivo.ESTAD_CODIGO IN ((SELECT est_finalizada FROM parametros_atencion_publico), (SELECT est_saltada FROM parametros_atencion_publico))
--where atencion.estad_codigo = @estad_codigo

where filas.OFRE_CODIGO	= @ofre_codigo
and filas.REP_CODIGO	= @rep_codigo
and filas.EDU_CODIGO	= @edu_codigo

--Maeper
INSERT @temp
(
rut,
dv,
nombre,
moat_numero,
estad_codigo,
fecha_registro,
hora_fecha_registro ,
inicio_atencion		,
fin_atencion		,
tiempo_espera		,
duracion_atencion	,
serv_codigo			,
serv_nombre			,
cate_codigo			,
cate_nombre			,
nombre_funcionario	,
rut_funcionario		,
dv_funcionario		,

tipo_usuario		,
origen
)

SELECT filas.FILA_RUT
,	MAE.mae_dv
,	RTRIM(LTRIM(MAE.mae_apellido_paterno)) + ' ' + RTRIM(LTRIM(MAE.mae_apellido_materno)) + ' ' + RTRIM(LTRIM(MAE.mae_nombre))
,	motivo.MOAT_NUMERO
,	atencion.ESTAD_CODIGO

,	motivo.MOAT_FECHA_REGISTRO
, 	CONVERT(VARCHAR(10),motivo.MOAT_FECHA_REGISTRO,108)											as hora_fecha_registro
, 	CONVERT(VARCHAR(10),atencion.atas_fecha_atencion,108)										as inicio_atencion
,  	CONVERT(VARCHAR(10),atencion.atas_fecha_registro,108)										as fin_atencion
,  	CONVERT(VARCHAR(10),atencion.atas_fecha_atencion-motivo.MOAT_FECHA_REGISTRO,108)			AS Tiempo_espera
,  	CONVERT(VARCHAR(10),atencion.atas_fecha_registro-atencion.atas_fecha_atencion,108)			AS Duracion_atencion

--Datos Servicio y Categoria
,	servicios.SERV_CODIGO
,	servicios.SERV_NOMBRE
,	categoria.CATE_CODIGO
,	categoria.CATE_NOMBRE

--Datos Funcionario

,	rtrim(ltrim(MAEPER.mae_nombre))+' '+rtrim(ltrim(MAEPER.mae_apellido_paterno)) +' '+ rtrim(ltrim(MAEPER.mae_apellido_materno))
,	maeper.mae_rut
,	maeper.mae_dv

--Origen
,	'Maeper'
,	2
FROM FILAS_ATENCION filas
JOIN CREDITOTEST.DBO.MAEPER MAE with(nolock) ON MAE.mae_rut = filas.FILA_RUT
join documentos_ubb.dbo.motivo_atencion as motivo with(nolock) 
on 		motivo.fila_year 			= filas.FILA_year
and 	motivo.FILA_CODIGO 			= filas.FILA_CODIGO
and 	motivo.OFRE_CODIGO 			= filas.OFRE_CODIGO
and 	motivo.REP_CODIGO 			= filas.REP_CODIGO
and 	motivo.EDU_CODIGO 			= filas.EDU_CODIGO

join DOCUMENTOS_UBB.dbo.ATENCION_ASIGNADA as atencion with(nolock)
on 		atencion.FILA_YEAR 		= motivo.FILA_YEAR
and		atencion.FILA_CODIGO 	= motivo.FILA_CODIGO
and		atencion.MOAT_CODIGO 	= motivo.MOAT_CODIGO
and		atencion.OFRE_CODIGO 	= motivo.OFRE_CODIGO
and		atencion.REP_CODIGO 	= motivo.REP_CODIGO
and		atencion.EDU_CODIGO 	= motivo.EDU_CODIGO

join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on   atencion.SERV_CODIGO    = servicios.SERV_CODIGO
and atencion.CATE_CODIGO    = servicios.CATE_CODIGO
and atencion.OFRE_CODIGO    = servicios.OFRE_CODIGO
and atencion.REP_CODIGO     = servicios.REP_CODIGO
and atencion.EDU_CODIGO     = servicios.EDU_CODIGO

join documentos_ubb.dbo.CATEGORIA_SERVICIO as categoria with(nolock)
on   servicios.CATE_CODIGO      = categoria.CATE_CODIGO
and servicios.OFRE_CODIGO     = categoria.OFRE_CODIGO
and servicios.CCO_CODIGO      = categoria.CCO_CODIGO
and servicios.REP_CODIGO      = categoria.REP_CODIGO
and servicios.EDU_CODIGO      = categoria.EDU_CODIGO

join documentos_ubb.dbo.MODULOS_ASIGNADOS as asignacion with(nolock)
On   atencion.MODU_CODIGO  = asignacion.MODU_CODIGO
AND atencion.mod_codigo	= asignacion.mod_codigo
and  atencion.usof_codigo	= asignacion.usof_codigo
and  atencion.OFRE_CODIGO  = asignacion.OFRE_CODIGO
and  atencion.REP_CODIGO   = asignacion.REP_CODIGO
and  atencion.EDU_CODIGO   = asignacion.EDU_CODIGO

join documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
on    asignacion.MOD_CODIGO   = modulos.MOD_CODIGO
and  asignacion.OFRE_CODIGO  = modulos.OFRE_CODIGO
and  asignacion.CCO_CODIGO   = modulos.CCO_CODIGO
and  asignacion.REP_CODIGO   = modulos.REP_CODIGO
and  asignacion.EDU_CODIGO   = modulos.EDU_CODIGO

join documentos_ubb.dbo.USUARIOS_OFICINA as usuarios with(nolock)
on    asignacion.USOF_CODIGO  = usuarios.USOF_CODIGO
and  asignacion.OFRE_CODIGO  = usuarios.OFRE_CODIGO
and  asignacion.CCO_CODIGO   = usuarios.CCO_CODIGO
and  asignacion.REP_CODIGO   = usuarios.REP_CODIGO
and  asignacion.EDU_CODIGO   = usuarios.EDU_CODIGO

join CREDITOTEST.dbo.maeper as MAEPER with(nolock)    
on   usuarios.MAE_RUT  =  MAEPER.mae_rut

--WHERE motivo.ESTAD_CODIGO IN ((SELECT est_finalizada FROM parametros_atencion_publico), (SELECT est_saltada FROM parametros_atencion_publico))
--where atencion.estad_codigo = @estad_codigo

where not exists (select 1
				from @temp
				where origen = 1)

and filas.OFRE_CODIGO	= @ofre_codigo
and filas.REP_CODIGO	= @rep_codigo
and filas.EDU_CODIGO	= @edu_codigo

--Desconocido
INSERT INTO @temp
(
	rut,
	nombre,
	fecha_registro,
	hora_fecha_registro ,
	inicio_atencion		,
	fin_atencion		,
	tiempo_espera		,
	duracion_atencion	,
	serv_codigo			,
	serv_nombre			,
	cate_codigo			,
	cate_nombre			,
	nombre_funcionario	,
	rut_funcionario		,
	dv_funcionario		,
	

	moat_numero			,
	tipo_usuario		,
	estad_codigo		,
	origen
)
SELECT filas.FILA_RUT
,'Civil'

,	motivo.MOAT_FECHA_REGISTRO
, 	CONVERT(VARCHAR(10),motivo.MOAT_FECHA_REGISTRO,108)											as hora_fecha_registro
, 	CONVERT(VARCHAR(10),atencion.atas_fecha_atencion,108)										as inicio_atencion
,  	CONVERT(VARCHAR(10),atencion.atas_fecha_registro,108)										as fin_atencion
,  	CONVERT(VARCHAR(10),atencion.atas_fecha_atencion-motivo.MOAT_FECHA_REGISTRO,108)			AS Tiempo_espera
,  	CONVERT(VARCHAR(10),atencion.atas_fecha_registro-atencion.atas_fecha_atencion,108)			AS Duracion_atencion
,	servicios.SERV_CODIGO
,	servicios.SERV_NOMBRE
,	categoria.CATE_CODIGO
,	categoria.CATE_NOMBRE
, rtrim(ltrim(MAEPER.mae_nombre))+' '+rtrim(ltrim(MAEPER.mae_apellido_paterno)) +' '+ rtrim(ltrim(MAEPER.mae_apellido_materno))
,	maeper.mae_rut
,	maeper.mae_dv

,	motivo.MOAT_NUMERO
, 'Desconocido'
,	atencion.ESTAD_CODIGO
, 3
FROM FILAS_ATENCION filas

join documentos_ubb.dbo.motivo_atencion as motivo with(nolock) 
on 		motivo.fila_year 			= filas.FILA_year
and 	motivo.FILA_CODIGO 			= filas.FILA_CODIGO
and 	motivo.OFRE_CODIGO 			= filas.OFRE_CODIGO
and 	motivo.REP_CODIGO 			= filas.REP_CODIGO
and 	motivo.EDU_CODIGO 			= filas.EDU_CODIGO

join DOCUMENTOS_UBB.dbo.ATENCION_ASIGNADA as atencion with(nolock)
on 		atencion.FILA_YEAR 	= motivo.FILA_YEAR
and		atencion.FILA_CODIGO 	= motivo.FILA_CODIGO
and		atencion.MOAT_CODIGO 	= motivo.MOAT_CODIGO
and		atencion.OFRE_CODIGO 	= motivo.OFRE_CODIGO
and		atencion.REP_CODIGO 	= motivo.REP_CODIGO
and		atencion.EDU_CODIGO 	= motivo.EDU_CODIGO


join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on   atencion.SERV_CODIGO    = servicios.SERV_CODIGO
and atencion.CATE_CODIGO    = servicios.CATE_CODIGO
and atencion.OFRE_CODIGO    = servicios.OFRE_CODIGO
and atencion.REP_CODIGO     = servicios.REP_CODIGO
and atencion.EDU_CODIGO     = servicios.EDU_CODIGO

join documentos_ubb.dbo.CATEGORIA_SERVICIO as categoria with(nolock)
on   servicios.CATE_CODIGO      = categoria.CATE_CODIGO
and servicios.OFRE_CODIGO     = categoria.OFRE_CODIGO
and servicios.CCO_CODIGO      = categoria.CCO_CODIGO
and servicios.REP_CODIGO      = categoria.REP_CODIGO
and servicios.EDU_CODIGO      = categoria.EDU_CODIGO

join documentos_ubb.dbo.MODULOS_ASIGNADOS as asignacion with(nolock)
On   atencion.MODU_CODIGO  = asignacion.MODU_CODIGO
AND atencion.mod_codigo	= asignacion.mod_codigo
and  atencion.usof_codigo	= asignacion.usof_codigo
and  atencion.OFRE_CODIGO  = asignacion.OFRE_CODIGO
and  atencion.REP_CODIGO   = asignacion.REP_CODIGO
and  atencion.EDU_CODIGO   = asignacion.EDU_CODIGO

join documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
on    asignacion.MOD_CODIGO   = modulos.MOD_CODIGO
and  asignacion.OFRE_CODIGO  = modulos.OFRE_CODIGO
and  asignacion.CCO_CODIGO   = modulos.CCO_CODIGO
and  asignacion.REP_CODIGO   = modulos.REP_CODIGO
and  asignacion.EDU_CODIGO   = modulos.EDU_CODIGO

join documentos_ubb.dbo.USUARIOS_OFICINA as usuarios with(nolock)
on    asignacion.USOF_CODIGO  = usuarios.USOF_CODIGO
and  asignacion.OFRE_CODIGO  = usuarios.OFRE_CODIGO
and  asignacion.CCO_CODIGO   = usuarios.CCO_CODIGO
and  asignacion.REP_CODIGO   = usuarios.REP_CODIGO
and  asignacion.EDU_CODIGO   = usuarios.EDU_CODIGO

join CREDITOTEST.dbo.maeper as MAEPER with(nolock)    
on   usuarios.MAE_RUT  =  MAEPER.mae_rut

WHERE NOT EXISTS (SELECT 1
				  from CREDITOTEST.DBO.MAEPER M1
				  WHERE M1.mae_rut = filas.FILA_RUT)
AND NOT EXISTS (SELECT 1
				  from Academia.DBO.ALUMNO M1
				  WHERE M1.alu_rut = filas.FILA_RUT)
--and atencion.estad_codigo = @estad_codigo

and filas.OFRE_CODIGO	= @ofre_codigo
and filas.REP_CODIGO	= @rep_codigo
and filas.EDU_CODIGO	= @edu_codigo



SELECT
	cate_nombre,
	serv_nombre,
	count(*)	as atenciones_por_servicio
FROM @temp
where	(	rut_funcionario					= @mae_rut			or @mae_rut 		is null)
and 	(	rut 							= @rut_cliente		or @rut_cliente 	is null)
and 	(	fecha_registro 					<= @fecha_hasta		or @fecha_hasta 	is null)
and 	(	fecha_registro 					>= @Fecha_desde		or @Fecha_desde 	is null)
and 	(	serv_codigo 					= @serv_codigo		or @serv_codigo 	is null)
and 	(	cate_codigo 					= @cate_codigo		or @cate_codigo 	is null)
and 	(	saa_codigo 						= @saa_codigo		or @saa_codigo 		is null)
and 	(	tpr_correlativo 				= @tpr_correlativo	or @tpr_correlativo is null)
and 	(	estad_codigo 					= @estad_codigo		or @estad_codigo 	is null)
and 	(	convert(time,fecha_registro) 	>= @hora_desde		or @hora_desde 		is null)
and 	(	convert(time,fecha_registro) 	<= @hora_hasta		or @hora_hasta 		is null)

group by cate_nombre,serv_nombre
order by 3 desc

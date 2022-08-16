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

	@-Parametro_Salida0: rut ,
	@-Parametro_Salida1: dv ,
	@-Parametro_Salida2: nombre ,
	@-Parametro_Salida3: estad_codigo ,
	@-Parametro_Salida4: tpr_descripcion ,
	@-Parametro_Salida5: tpr_correlativo ,
	@-Parametro_Salida6: saa_descripcion ,
	@-Parametro_Salida7: saa_codigo ,
	@-Parametro_Salida8: pca_crr_nombre ,
	@-Parametro_Salida9: crr_codigo ,
	@-Parametro_Salida10: pca_codigo ,
	@-Parametro_Salida11: ano_ingreso ,
	@-Parametro_Salida12: periodo_ingreso ,
	@-Parametro_Salida13: cmp_codigo ,
	@-Parametro_Salida14: cmp_nombre ,
	@-Parametro_Salida15: fecha_registro AS fecha_registro,
	@-Parametro_Salida16: CAST(hora_fecha_registro AS TIME) as hora_registro,
	@-Parametro_Salida17: CAST(inicio_atencion AS TIME)
	@-Parametro_Salida18: CAST(fin_atencion AS TIME) as fin_atencion,
	@-Parametro_Salida19: CAST(tiempo_espera
	@-Parametro_Salida20: CAST(duracion_atencion AS TIME) as duracion_atencion,
	@-Parametro_Salida21: serv_codigo,
	@-Parametro_Salida22: serv_nombre,
	@-Parametro_Salida23: cate_codigo,
	@-Parametro_Salida24: cate_nombre,
	@-Parametro_Salida25: nombre_funcionario as nombre_funcionario,
	@-Parametro_Salida26: rut_funcionario,
	@-Parametro_Salida27: dv_funcionario,
	@-Parametro_Salida28: moat_numero
	@-Parametro_Salida29: tipo_usuario
	@-Parametro_Salida30: origen

	@-Descripcion_Objeto0: SP de reporte detallado del Sistema de Gestión de Filas
	@-Regla_Objeto0: Debe existir una oficina de reparticion con actividad para poder generar reporte
	
FIN_DATOS_PROCEDIMIENTO**/	

alter proc dbo.PB_Registro_detallado
(
	 	@ofre_codigo		integer
	, 	@rep_codigo			decimal
	, 	@edu_codigo			integer
	, 	@mae_rut			integer
	, 	@rut_cliente		integer
	, 	@fecha_hasta		datetime
	, 	@Fecha_desde		datetime
	, 	@hora_desde			varchar(8)
	, 	@hora_hasta			varchar(8)
	,	@spid				integer
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

join documentos_ubb.dbo.TMP_TIPO_PROGRAMA as temp_tipo_programa with(nolock)
on		programa.tpr_correlativo	= temp_tipo_programa.tpr_codigo
and		@spid						= temp_tipo_programa.spid

join documentos_ubb.dbo.TMP_SITUACION_ACADEMICA as temp_situacion_academica with(nolock)
on		situacion.saa_codigo	= temp_situacion_academica.saa_codigo
and		@spid					= temp_situacion_academica.spid

--WHERE motivo.ESTAD_CODIGO IN ((SELECT est_finalizada FROM parametros_atencion_publico), (SELECT est_saltada FROM parametros_atencion_publico))
--where atencion.estad_codigo = @estad_codigo

where filas.OFRE_CODIGO	= @ofre_codigo
and filas.REP_CODIGO	= @rep_codigo
and filas.EDU_CODIGO	= @edu_codigo

----Maeper
--INSERT @temp
--(
--rut,
--dv,
--nombre,
--moat_numero,
--estad_codigo,
--fecha_registro,
--hora_fecha_registro ,
--inicio_atencion		,
--fin_atencion		,
--tiempo_espera		,
--duracion_atencion	,
--serv_codigo			,
--serv_nombre			,
--cate_codigo			,
--cate_nombre			,
--nombre_funcionario	,
--rut_funcionario		,
--dv_funcionario		,

--tipo_usuario		,
--origen
--)

--SELECT filas.FILA_RUT
--,	MAE.mae_dv
--,	RTRIM(LTRIM(MAE.mae_apellido_paterno)) + ' ' + RTRIM(LTRIM(MAE.mae_apellido_materno)) + ' ' + RTRIM(LTRIM(MAE.mae_nombre))
--,	motivo.MOAT_NUMERO
--,	atencion.ESTAD_CODIGO

--,	motivo.MOAT_FECHA_REGISTRO
--, 	CONVERT(VARCHAR(10),motivo.MOAT_FECHA_REGISTRO,108)											as hora_fecha_registro
--, 	CONVERT(VARCHAR(10),atencion.atas_fecha_atencion,108)										as inicio_atencion
--,  	CONVERT(VARCHAR(10),atencion.atas_fecha_registro,108)										as fin_atencion
--,  	CONVERT(VARCHAR(10),atencion.atas_fecha_atencion-motivo.MOAT_FECHA_REGISTRO,108)			AS Tiempo_espera
--,  	CONVERT(VARCHAR(10),atencion.atas_fecha_registro-atencion.atas_fecha_atencion,108)			AS Duracion_atencion

----Datos Servicio y Categoria
--,	servicios.SERV_CODIGO
--,	servicios.SERV_NOMBRE
--,	categoria.CATE_CODIGO
--,	categoria.CATE_NOMBRE

----Datos Funcionario

--,	rtrim(ltrim(MAEPER.mae_nombre))+' '+rtrim(ltrim(MAEPER.mae_apellido_paterno)) +' '+ rtrim(ltrim(MAEPER.mae_apellido_materno))
--,	maeper.mae_rut
--,	maeper.mae_dv

----Origen
--,	'Maeper'
--,	2
--FROM FILAS_ATENCION filas
--JOIN CREDITOTEST.DBO.MAEPER MAE with(nolock) ON MAE.mae_rut = filas.FILA_RUT
--join documentos_ubb.dbo.motivo_atencion as motivo with(nolock) 
--on 		motivo.fila_year 			= filas.FILA_year
--and 	motivo.FILA_CODIGO 			= filas.FILA_CODIGO
--and 	motivo.OFRE_CODIGO 			= filas.OFRE_CODIGO
--and 	motivo.REP_CODIGO 			= filas.REP_CODIGO
--and 	motivo.EDU_CODIGO 			= filas.EDU_CODIGO

--join DOCUMENTOS_UBB.dbo.ATENCION_ASIGNADA as atencion with(nolock)
--on 		atencion.FILA_YEAR 		= motivo.FILA_YEAR
--and		atencion.FILA_CODIGO 	= motivo.FILA_CODIGO
--and		atencion.MOAT_CODIGO 	= motivo.MOAT_CODIGO
--and		atencion.OFRE_CODIGO 	= motivo.OFRE_CODIGO
--and		atencion.REP_CODIGO 	= motivo.REP_CODIGO
--and		atencion.EDU_CODIGO 	= motivo.EDU_CODIGO

--join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
--on   atencion.SERV_CODIGO    = servicios.SERV_CODIGO
--and atencion.CATE_CODIGO    = servicios.CATE_CODIGO
--and atencion.OFRE_CODIGO    = servicios.OFRE_CODIGO
--and atencion.REP_CODIGO     = servicios.REP_CODIGO
--and atencion.EDU_CODIGO     = servicios.EDU_CODIGO

--join documentos_ubb.dbo.CATEGORIA_SERVICIO as categoria with(nolock)
--on   servicios.CATE_CODIGO      = categoria.CATE_CODIGO
--and servicios.OFRE_CODIGO     = categoria.OFRE_CODIGO
--and servicios.CCO_CODIGO      = categoria.CCO_CODIGO
--and servicios.REP_CODIGO      = categoria.REP_CODIGO
--and servicios.EDU_CODIGO      = categoria.EDU_CODIGO

--join documentos_ubb.dbo.MODULOS_ASIGNADOS as asignacion with(nolock)
--On   atencion.MODU_CODIGO  = asignacion.MODU_CODIGO
--AND atencion.mod_codigo	= asignacion.mod_codigo
--and  atencion.usof_codigo	= asignacion.usof_codigo
--and  atencion.OFRE_CODIGO  = asignacion.OFRE_CODIGO
--and  atencion.REP_CODIGO   = asignacion.REP_CODIGO
--and  atencion.EDU_CODIGO   = asignacion.EDU_CODIGO

--join documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
--on    asignacion.MOD_CODIGO   = modulos.MOD_CODIGO
--and  asignacion.OFRE_CODIGO  = modulos.OFRE_CODIGO
--and  asignacion.CCO_CODIGO   = modulos.CCO_CODIGO
--and  asignacion.REP_CODIGO   = modulos.REP_CODIGO
--and  asignacion.EDU_CODIGO   = modulos.EDU_CODIGO

--join documentos_ubb.dbo.USUARIOS_OFICINA as usuarios with(nolock)
--on    asignacion.USOF_CODIGO  = usuarios.USOF_CODIGO
--and  asignacion.OFRE_CODIGO  = usuarios.OFRE_CODIGO
--and  asignacion.CCO_CODIGO   = usuarios.CCO_CODIGO
--and  asignacion.REP_CODIGO   = usuarios.REP_CODIGO
--and  asignacion.EDU_CODIGO   = usuarios.EDU_CODIGO

--join CREDITOTEST.dbo.maeper as MAEPER with(nolock)    
--on   usuarios.MAE_RUT  =  MAEPER.mae_rut

----WHERE motivo.ESTAD_CODIGO IN ((SELECT est_finalizada FROM parametros_atencion_publico), (SELECT est_saltada FROM parametros_atencion_publico))
----where atencion.estad_codigo = @estad_codigo

--where not exists (select 1
--				from @temp
--				where origen = 1)

--and filas.OFRE_CODIGO	= @ofre_codigo
--and filas.REP_CODIGO	= @rep_codigo
--and filas.EDU_CODIGO	= @edu_codigo

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
	temporal.rut									as rut,
	temporal.dv										as dv,
	temporal.nombre									as nombre ,
	temporal.estad_codigo							as estad_codigo ,
	temporal.tpr_descripcion						as tpr_descripcion ,
	temporal.tpr_correlativo						as tpr_correlativo,
	temporal.saa_descripcion						as saa_descripcion  ,
	temporal.saa_codigo								as saa_codigo,
	temporal.pca_crr_nombre							as pca_crr_nombre,
	temporal.crr_codigo								as crr_codigo,
	temporal.pca_codigo								as pca_codigo,
	temporal.ano_ingreso							as ano_ingreso,
	temporal.periodo_ingreso						as periodo_ingreso,
	temporal.cmp_codigo								as cmp_codigo,
	temporal.cmp_nombre								as cmp_nombre,
	temporal.fecha_registro							AS fecha_registro,
	CAST(temporal.hora_fecha_registro AS TIME)		as hora_registro,
	CAST(temporal.inicio_atencion AS TIME)			as inicio_atencion,
	CAST(temporal.fin_atencion AS TIME)				as fin_atencion,
	CAST(temporal.tiempo_espera	 AS TIME)			as tiempo_espera,
	CAST(temporal.duracion_atencion AS TIME)		as duracion_atencion,
	temporal.serv_codigo							as serv_codigo,
	temporal.serv_nombre							as serv_nombre,
	temporal.cate_codigo							as cate_codigo,
	temporal.cate_nombre							as cate_nombre,
	temporal.nombre_funcionario						as nombre_funcionario,
	temporal.rut_funcionario						as rut_funcionario,
	temporal.dv_funcionario							as dv_funcionario,
	temporal.moat_numero							as moat_numero,
	temporal.tipo_usuario							as tipo_usuario,
	temporal.origen									as origen

FROM @temp as temporal

join documentos_ubb.dbo.TMP_CATEGORIA as tmp_cat with(nolock)
on		temporal.cate_codigo	= tmp_cat.CATE_CODIGO
and		@spid					= tmp_cat.spid

join documentos_ubb.dbo.TMP_SERVICIO as tmp_ser with(nolock)
on		temporal.SERV_CODIGO = tmp_ser.SERV_CODIGO
and		@spid				= tmp_ser.spid

join documentos_ubb.dbo.TMP_ESTADO_ATENCION as tmp_est with(nolock)
on		temporal.ESTAD_CODIGO = tmp_est.ESTAD_CODIGO
and		@spid				= tmp_est.spid

where	(	rut_funcionario					=  @mae_rut			or @mae_rut 		is null)
and 	(	rut 							=  @rut_cliente		or @rut_cliente 	is null)
and 	(	fecha_registro 					<= @Fecha_hasta		or @Fecha_hasta 	is null)
and 	(	fecha_registro 					>= @Fecha_desde		or @Fecha_desde 	is null)
and 	(	convert(time,fecha_registro) 	>= @hora_desde		or @hora_desde 		is null)
and 	(	convert(time,fecha_registro) 	<= @hora_hasta		or @hora_hasta 		is null)

order by 16 desc

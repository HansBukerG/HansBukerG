
/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, proceso_funcionario, dw_fila_unica
	
	@-Parametro_Entrada0: MOD_CODIGO
	@-Parametro_Entrada1: OFRE_CODIGO
	@-Parametro_Entrada2: CCO_CODIGO
	@-Parametro_Entrada3: REP_CODIGO
	@-Parametro_Entrada4: EDU_CODIGO

	@-Parametro_Salida0: fecha_registro
	@-Parametro_Salida1: numero_fila
	@-Parametro_Salida2: moat_codigo
	@-Parametro_Salida3: fila_codigo
	@-Parametro_Salida4: fila_rut
	@-Parametro_Salida5: fila_dv
	@-Parametro_Salida6: serv_codigo
	@-Parametro_Salida7: cate_codigo
	@-Parametro_Salida8: serv_nombre
	@-Parametro_Salida9: nombre
	@-Parametro_Salida10: tipo_cliente
	@-Parametro_Salida11: origen

	@-Descripcion_Objeto0: Muestra la cantidad de personas que se encuentran en una fila de atención
	@-Regla_Objeto0: Debe existir una persona en la fila de atención en estado de espera
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_fila_unica_2 ;
	
FIN_DATOS_PROCEDIMIENTO**/	


create proc dbo.pb_fila_unica_2
(
	 @OFRE_CODIGO integer
	, @CCO_CODIGO decimal
	, @REP_CODIGO decimal
	, @EDU_CODIGO integer
)
as

declare @temp table
(
		fecha_registro		datetime
	,	numero_fila			varchar(10)
	,	moat_codigo			integer
	,	fila_codigo			integer
	,	fila_rut			integer
	,	fila_dv				char(1)
	,	serv_codigo			integer
	,	cate_codigo			integer
	,	serv_nombre			varchar(60)
	,	nombre				varchar(250)
	,	tipo_cliente		varchar(15)
	,	origen				int
)
--Aqui va el codigo faltante

----Consulta para Alumno

insert into @temp
(
		fecha_registro
	,	numero_fila
	,	fila_rut
	,	fila_dv
	,	nombre
	,	serv_nombre
	,	moat_codigo
	,	fila_codigo
	,	serv_codigo
	,	cate_codigo
	,	tipo_cliente
	,	origen
)

--Alumno

select  motivo.moat_fecha_registro	
,		motivo.moat_numero
,		fila.fila_rut
,		alumno.alu_dv
,		ltrim(rtrim(alumno.alu_nombres))+' '+ltrim(rtrim(alumno.alu_apellido_paterno))+' '+ltrim(rtrim(alumno.alu_apellido_materno)) as Nombre
,		servicios.serv_nombre
,		motivo.MOAT_CODIGO
,		fila.FILA_CODIGO
,		motivo.serv_codigo
,		motivo.cate_codigo
,		'Estudiante'
,		1
from documentos_ubb.dbo.MOTIVO_ATENCION as motivo with(nolock)
join documentos_ubb.dbo.FILAS_ATENCION as fila with(nolock)
on 		motivo.fila_year 			= fila.FILA_year
and 	motivo.FILA_CODIGO 			= fila.FILA_CODIGO
and 	motivo.OFRE_CODIGO 			= fila.OFRE_CODIGO
and 	motivo.REP_CODIGO 			= fila.REP_CODIGO
and 	motivo.EDU_CODIGO 			= fila.EDU_CODIGO
and     convert(date,fila.FILA_FECHA_REGISTRO) 	= CONVERT(DATE,GETDATE())
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on		motivo.SERV_CODIGO = servicios.SERV_CODIGO
and		motivo.CATE_CODIGO = servicios.CATE_CODIGO
and		motivo.OFRE_CODIGO = servicios.OFRE_CODIGO
and		motivo.REP_CODIGO = servicios.REP_CODIGO
and		motivo.EDU_CODIGO = servicios.EDU_CODIGO
and		(servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)

-- Tabla alumno

join academia.dbo.alumno as alumno with(nolock)
on fila.fila_rut = alumno.alu_rut

where	CONVERT(DATE,motivo.MOAT_FECHA_REGISTRO)	= CONVERT(DATE,GETDATE())
and		fila.OFRE_CODIGO =@OFRE_CODIGO
and		fila.REP_CODIGO 	=@REP_CODIGO
and		fila.EDU_CODIGO 	=@EDU_CODIGO
and		motivo.estad_codigo = 1

order by motivo.MOAT_FECHA_REGISTRO



-- maeper


----Consulta para Maeper

insert into @temp
(
		fecha_registro
	,	numero_fila
	,	fila_rut
	,	fila_dv
	,	nombre
	,	serv_nombre
	,	moat_codigo
	,	fila_codigo
	,	serv_codigo
	,	cate_codigo
	,	tipo_cliente
	,	origen
)

--Maeper

select  motivo.moat_fecha_registro	
,		motivo.moat_numero
,		fila.fila_rut
,		MAEPER.mae_dv
,		ltrim(rtrim(MAEPER.mae_nombre))+' '+ltrim(rtrim(MAEPER.mae_apellido_paterno))+' '+ltrim(rtrim(MAEPER.mae_apellido_materno)) as Nombre
,		servicios.serv_nombre
,		motivo.MOAT_CODIGO
,		fila.FILA_CODIGO
,		motivo.serv_codigo
,		motivo.cate_codigo
,		'Maeper'
,		2
from documentos_ubb.dbo.MOTIVO_ATENCION as motivo with(nolock)
join documentos_ubb.dbo.FILAS_ATENCION as fila with(nolock)
on 		motivo.fila_year 			= fila.FILA_year
and 	motivo.FILA_CODIGO 			= fila.FILA_CODIGO
and 	motivo.OFRE_CODIGO 			= fila.OFRE_CODIGO
and 	motivo.REP_CODIGO 			= fila.REP_CODIGO
and 	motivo.EDU_CODIGO 			= fila.EDU_CODIGO
and     convert(date,fila.FILA_FECHA_REGISTRO) 	= CONVERT(DATE,GETDATE())
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on		motivo.SERV_CODIGO = servicios.SERV_CODIGO
and		motivo.CATE_CODIGO = servicios.CATE_CODIGO
and		motivo.OFRE_CODIGO = servicios.OFRE_CODIGO
and		motivo.REP_CODIGO = servicios.REP_CODIGO
and		motivo.EDU_CODIGO = servicios.EDU_CODIGO
and		(servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)

-- Tabla Maeper

join CREDITOTEST.dbo.maeper as MAEPER with(nolock)    
on fila.fila_rut  =  MAEPER.mae_rut

where	CONVERT(DATE,motivo.MOAT_FECHA_REGISTRO)	= CONVERT(DATE,GETDATE())
and not exists (select 1 from @temp where origen = 1)
and		fila.OFRE_CODIGO	=@OFRE_CODIGO
and		fila.REP_CODIGO 	=@REP_CODIGO
and		fila.EDU_CODIGO 	=@EDU_CODIGO
and		motivo.estad_codigo = 1

order by motivo.MOAT_FECHA_REGISTRO

----Consulta para Desconocido

insert into @temp
(
		fecha_registro
	,	numero_fila
	,	fila_rut
	,	fila_dv
	,	nombre
	,	serv_nombre
	,	moat_codigo
	,	fila_codigo
	,	serv_codigo
	,	cate_codigo
	,	tipo_cliente
	,	origen
)

--Desconocido

select  motivo.moat_fecha_registro	
,		motivo.moat_numero
,		fila.fila_rut
,		''
,		'Desconocido'
,		servicios.serv_nombre
,		motivo.MOAT_CODIGO
,		fila.FILA_CODIGO
,		motivo.serv_codigo
,		motivo.cate_codigo
,		'Desconocido'
,		3
from documentos_ubb.dbo.MOTIVO_ATENCION as motivo with(nolock)
join documentos_ubb.dbo.FILAS_ATENCION as fila with(nolock)
on 		motivo.fila_year 			= fila.FILA_year
and 	motivo.FILA_CODIGO 			= fila.FILA_CODIGO
and 	motivo.OFRE_CODIGO 			= fila.OFRE_CODIGO
and 	motivo.REP_CODIGO 			= fila.REP_CODIGO
and 	motivo.EDU_CODIGO 			= fila.EDU_CODIGO
and     convert(date,fila.FILA_FECHA_REGISTRO) 	= CONVERT(DATE,GETDATE())
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on		motivo.SERV_CODIGO = servicios.SERV_CODIGO
and		motivo.CATE_CODIGO = servicios.CATE_CODIGO
and		motivo.OFRE_CODIGO = servicios.OFRE_CODIGO
and		motivo.REP_CODIGO = servicios.REP_CODIGO
and		motivo.EDU_CODIGO = servicios.EDU_CODIGO
and		(servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)

where	CONVERT(DATE,motivo.MOAT_FECHA_REGISTRO)	= CONVERT(DATE,GETDATE())
and		fila.OFRE_CODIGO	=@OFRE_CODIGO
and		fila.REP_CODIGO 	=@REP_CODIGO
and		fila.EDU_CODIGO 	=@EDU_CODIGO
and		motivo.estad_codigo = 1

and NOT EXISTS (SELECT 1
				  from CREDITOTEST.DBO.MAEPER M1
				  WHERE M1.mae_rut = fila.FILA_RUT)
AND NOT EXISTS (SELECT 1
				  from Academia.DBO.ALUMNO M2
				  WHERE M2.alu_rut = fila.FILA_RUT)

order by motivo.MOAT_FECHA_REGISTRO

--

select *
from @temp
order by 1 asc
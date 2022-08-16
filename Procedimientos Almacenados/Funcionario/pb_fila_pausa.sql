/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: Hans buker Gutiérrez
	@-Fecha_Modificacion0: 12-07-2018
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, proceso_funcionario, dw_fila_pausada
	
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

	@-Descripcion_Objeto0: Muestra la cantidad de personas que se encuentran pausadas en una fila de atención
	@-Regla_Objeto0: Debe haber existido una persona en atención para poder haber sido pausada
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_fila_pausa;
	
FIN_DATOS_PROCEDIMIENTO**/	



alter proc dbo.pb_fila_pausa
(
	 @MOD_CODIGO integer
	, @OFRE_CODIGO integer
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

--Alumno

Insert into @temp
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

select distinct motivo.moat_fecha_registro	
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

--Tabla MOTIVO_ATENCION
from documentos_ubb.dbo.MOTIVO_ATENCION as motivo with(nolock)

-- Tabla FILAS_ATENCION
join documentos_ubb.dbo.FILAS_ATENCION as fila with(nolock)
on 		motivo.fila_year 			= fila.FILA_year
and 	motivo.FILA_CODIGO 			= fila.FILA_CODIGO
and 	motivo.OFRE_CODIGO 			= fila.OFRE_CODIGO
and 	motivo.REP_CODIGO 			= fila.REP_CODIGO
and 	motivo.EDU_CODIGO 			= fila.EDU_CODIGO
and     convert(date,fila.FILA_FECHA_REGISTRO) 	= CONVERT(DATE,GETDATE())

-- Tabla SERVICIOS_REPARTICION
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on		motivo.SERV_CODIGO = servicios.SERV_CODIGO
and		motivo.CATE_CODIGO = servicios.CATE_CODIGO
and		motivo.OFRE_CODIGO = servicios.OFRE_CODIGO
and		motivo.REP_CODIGO = servicios.REP_CODIGO
and		motivo.EDU_CODIGO = servicios.EDU_CODIGO
and		(servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)

-- Tabla atencion_asignada
join documentos_ubb.dbo.atencion_asignada as atencion_asignada with(nolock)
on 		atencion_asignada.FILA_YEAR 	= motivo.FILA_YEAR
and		atencion_asignada.FILA_CODIGO 	= motivo.FILA_CODIGO
and		atencion_asignada.MOAT_CODIGO 	= motivo.MOAT_CODIGO
and		atencion_asignada.OFRE_CODIGO 	= motivo.OFRE_CODIGO
and		atencion_asignada.REP_CODIGO 	= motivo.REP_CODIGO
and		atencion_asignada.EDU_CODIGO 	= motivo.EDU_CODIGO

-- Tabla MODULOS_ASIGNADOS

join documentos_ubb.dbo.MODULOS_ASIGNADOS as asignados with(nolock)
on		asignados.MODU_CODIGO 	= atencion_asignada.MODU_CODIGO
and		asignados.MOD_CODIGO 	= atencion_asignada.MOD_CODIGO
and		asignados.USOF_CODIGO 	= atencion_asignada.USOF_CODIGO
and		asignados.OFRE_CODIGO 	= atencion_asignada.OFRE_CODIGO
and		asignados.REP_CODIGO 	= atencion_asignada.REP_CODIGO
and		asignados.EDU_CODIGO 	= atencion_asignada.EDU_CODIGO
and		(asignados.MODU_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR asignados.MODU_FECHA_TERMINO IS NULL)

-- Tabla MODULOS_ATENCION

join documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
on		modulos.MOD_CODIGO 	= asignados.MOD_CODIGO
and		modulos.OFRE_CODIGO = asignados.OFRE_CODIGO
and		modulos.CCO_CODIGO 	= asignados.CCO_CODIGO
and		modulos.REP_CODIGO 	= asignados.REP_CODIGO
and		modulos.EDU_CODIGO 	= asignados.EDU_CODIGO
and		(modulos.MOD_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR modulos.MOD_FECHA_TERMINO IS NULL)

--Tabla USUARIOS_OFICINA

join documentos_ubb.dbo.USUARIOS_OFICINA as usuarios with(nolock)
on 		usuarios.USOF_CODIGO 	= asignados.USOF_CODIGO
and		usuarios.OFRE_CODIGO 	= asignados.OFRE_CODIGO
and		usuarios.CCO_CODIGO 	= asignados.CCO_CODIGO
and		usuarios.REP_CODIGO 	= asignados.REP_CODIGO
and		usuarios.EDU_CODIGO 	= asignados.EDU_CODIGO
and		(usuarios.USOF_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR usuarios.USOF_FECHA_TERMINO IS NULL)

-- Tabla alumno

join academia.dbo.alumno as alumno with(nolock)
on fila.fila_rut = alumno.alu_rut


where	CONVERT(DATE,motivo.MOAT_FECHA_REGISTRO)	= CONVERT(DATE,GETDATE())
and 	(modulos.MOD_CODIGO  =@MOD_CODIGO or @MOD_CODIGO is null)
and		modulos.OFRE_CODIGO =@OFRE_CODIGO
and		modulos.CCO_CODIGO 	=@CCO_CODIGO
and		modulos.REP_CODIGO 	=@REP_CODIGO
and		modulos.EDU_CODIGO 	=@EDU_CODIGO
and		motivo.estad_codigo = 5
and 	atencion_asignada.estad_codigo = 5

order by motivo.MOAT_FECHA_REGISTRO

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

select  distinct motivo.moat_fecha_registro	
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

--Tabla MOTIVO_ATENCION
from documentos_ubb.dbo.MOTIVO_ATENCION as motivo with(nolock)

-- Tabla FILAS_ATENCION
join documentos_ubb.dbo.FILAS_ATENCION as fila with(nolock)
on 		motivo.fila_year 			= fila.FILA_year
and 	motivo.FILA_CODIGO 			= fila.FILA_CODIGO
and 	motivo.OFRE_CODIGO 			= fila.OFRE_CODIGO
and 	motivo.REP_CODIGO 			= fila.REP_CODIGO
and 	motivo.EDU_CODIGO 			= fila.EDU_CODIGO
and     convert(date,fila.FILA_FECHA_REGISTRO) 	= CONVERT(DATE,GETDATE())

-- Tabla SERVICIOS_REPARTICION
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on		motivo.SERV_CODIGO = servicios.SERV_CODIGO
and		motivo.CATE_CODIGO = servicios.CATE_CODIGO
and		motivo.OFRE_CODIGO = servicios.OFRE_CODIGO
and		motivo.REP_CODIGO = servicios.REP_CODIGO
and		motivo.EDU_CODIGO = servicios.EDU_CODIGO
and		(servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)

-- Tabla atencion_asignada
join documentos_ubb.dbo.atencion_asignada as atencion_asignada with(nolock)
on 		atencion_asignada.FILA_YEAR 	= motivo.FILA_YEAR
and		atencion_asignada.FILA_CODIGO 	= motivo.FILA_CODIGO
and		atencion_asignada.MOAT_CODIGO 	= motivo.MOAT_CODIGO
and		atencion_asignada.OFRE_CODIGO 	= motivo.OFRE_CODIGO
and		atencion_asignada.REP_CODIGO 	= motivo.REP_CODIGO
and		atencion_asignada.EDU_CODIGO 	= motivo.EDU_CODIGO


-- Tabla MODULOS_ASIGNADOS

join documentos_ubb.dbo.MODULOS_ASIGNADOS as asignados with(nolock)
on		asignados.MODU_CODIGO 	= atencion_asignada.MODU_CODIGO
and		asignados.MOD_CODIGO 	= atencion_asignada.MOD_CODIGO
and		asignados.USOF_CODIGO 	= atencion_asignada.USOF_CODIGO
and		asignados.OFRE_CODIGO 	= atencion_asignada.OFRE_CODIGO
and		asignados.REP_CODIGO 	= atencion_asignada.REP_CODIGO
and		asignados.EDU_CODIGO 	= atencion_asignada.EDU_CODIGO
and		(asignados.MODU_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR asignados.MODU_FECHA_TERMINO IS NULL)

-- Tabla MODULOS_ATENCION

join documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
on		modulos.MOD_CODIGO 	= asignados.MOD_CODIGO
and		modulos.OFRE_CODIGO = asignados.OFRE_CODIGO
and		modulos.CCO_CODIGO 	= asignados.CCO_CODIGO
and		modulos.REP_CODIGO 	= asignados.REP_CODIGO
and		modulos.EDU_CODIGO 	= asignados.EDU_CODIGO
and		(modulos.MOD_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR modulos.MOD_FECHA_TERMINO IS NULL)

--Tabla USUARIOS_OFICINA

join documentos_ubb.dbo.USUARIOS_OFICINA as usuarios with(nolock)
on 		usuarios.USOF_CODIGO 	= asignados.USOF_CODIGO
and		usuarios.OFRE_CODIGO 	= asignados.OFRE_CODIGO
and		usuarios.CCO_CODIGO 	= asignados.CCO_CODIGO
and		usuarios.REP_CODIGO 	= asignados.REP_CODIGO
and		usuarios.EDU_CODIGO 	= asignados.EDU_CODIGO
and		(usuarios.USOF_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR usuarios.USOF_FECHA_TERMINO IS NULL)

-- Tabla Maeper

join CREDITOTEST.dbo.maeper as MAEPER with(nolock)    
on fila.fila_rut  =  MAEPER.mae_rut


where	CONVERT(DATE,motivo.MOAT_FECHA_REGISTRO)	= CONVERT(DATE,GETDATE())
and 	(modulos.MOD_CODIGO  =@MOD_CODIGO or @MOD_CODIGO is null)
and		modulos.OFRE_CODIGO =@OFRE_CODIGO
and		modulos.CCO_CODIGO 	=@CCO_CODIGO
and		modulos.REP_CODIGO 	=@REP_CODIGO
and		modulos.EDU_CODIGO 	=@EDU_CODIGO
and		motivo.estad_codigo = 5
and 	atencion_asignada.estad_codigo = 5
and 	not exists (select 1 from @temp where origen = 1)

order by motivo.MOAT_FECHA_REGISTRO


--Desconocido

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

select distinct motivo.moat_fecha_registro	
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

--Tabla MOTIVO_ATENCION
from documentos_ubb.dbo.MOTIVO_ATENCION as motivo with(nolock)

-- Tabla FILAS_ATENCION
join documentos_ubb.dbo.FILAS_ATENCION as fila with(nolock)
on 		motivo.fila_year 			= fila.FILA_year
and 	motivo.FILA_CODIGO 			= fila.FILA_CODIGO
and 	motivo.OFRE_CODIGO 			= fila.OFRE_CODIGO
and 	motivo.REP_CODIGO 			= fila.REP_CODIGO
and 	motivo.EDU_CODIGO 			= fila.EDU_CODIGO
and     convert(date,fila.FILA_FECHA_REGISTRO) 	= CONVERT(DATE,GETDATE())

-- Tabla SERVICIOS_REPARTICION
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on		motivo.SERV_CODIGO = servicios.SERV_CODIGO
and		motivo.CATE_CODIGO = servicios.CATE_CODIGO
and		motivo.OFRE_CODIGO = servicios.OFRE_CODIGO
and		motivo.REP_CODIGO = servicios.REP_CODIGO
and		motivo.EDU_CODIGO = servicios.EDU_CODIGO
and		(servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)

-- Tabla atencion_asignada
join documentos_ubb.dbo.atencion_asignada as atencion_asignada with(nolock)
on 		atencion_asignada.FILA_YEAR 	= motivo.FILA_YEAR
and		atencion_asignada.FILA_CODIGO 	= motivo.FILA_CODIGO
and		atencion_asignada.MOAT_CODIGO 	= motivo.MOAT_CODIGO
and		atencion_asignada.OFRE_CODIGO 	= motivo.OFRE_CODIGO
and		atencion_asignada.REP_CODIGO 	= motivo.REP_CODIGO
and		atencion_asignada.EDU_CODIGO 	= motivo.EDU_CODIGO


-- Tabla MODULOS_ASIGNADOS

join documentos_ubb.dbo.MODULOS_ASIGNADOS as asignados with(nolock)
on		asignados.MODU_CODIGO 	= atencion_asignada.MODU_CODIGO
and		asignados.MOD_CODIGO 	= atencion_asignada.MOD_CODIGO
and		asignados.USOF_CODIGO 	= atencion_asignada.USOF_CODIGO
and		asignados.OFRE_CODIGO 	= atencion_asignada.OFRE_CODIGO
and		asignados.REP_CODIGO 	= atencion_asignada.REP_CODIGO
and		asignados.EDU_CODIGO 	= atencion_asignada.EDU_CODIGO
and		(asignados.MODU_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR asignados.MODU_FECHA_TERMINO IS NULL)

-- Tabla MODULOS_ATENCION

join documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
on		modulos.MOD_CODIGO 	= asignados.MOD_CODIGO
and		modulos.OFRE_CODIGO = asignados.OFRE_CODIGO
and		modulos.CCO_CODIGO 	= asignados.CCO_CODIGO
and		modulos.REP_CODIGO 	= asignados.REP_CODIGO
and		modulos.EDU_CODIGO 	= asignados.EDU_CODIGO
and		(modulos.MOD_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR modulos.MOD_FECHA_TERMINO IS NULL)

--Tabla USUARIOS_OFICINA

join documentos_ubb.dbo.USUARIOS_OFICINA as usuarios with(nolock)
on 		usuarios.USOF_CODIGO 	= asignados.USOF_CODIGO
and		usuarios.OFRE_CODIGO 	= asignados.OFRE_CODIGO
and		usuarios.CCO_CODIGO 	= asignados.CCO_CODIGO
and		usuarios.REP_CODIGO 	= asignados.REP_CODIGO
and		usuarios.EDU_CODIGO 	= asignados.EDU_CODIGO
and		(usuarios.USOF_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR usuarios.USOF_FECHA_TERMINO IS NULL)

where	CONVERT(DATE,motivo.MOAT_FECHA_REGISTRO)	= CONVERT(DATE,GETDATE())
and 	modulos.MOD_CODIGO  =@MOD_CODIGO
and		modulos.OFRE_CODIGO =@OFRE_CODIGO
and		modulos.CCO_CODIGO 	=@CCO_CODIGO
and		modulos.REP_CODIGO 	=@REP_CODIGO
and		modulos.EDU_CODIGO 	=@EDU_CODIGO
and		motivo.estad_codigo = 5
and 	atencion_asignada.estad_codigo = 5
and 	not exists (select 1 from @temp where origen = 1)
and NOT EXISTS (SELECT 1
				  from CREDITOTEST.DBO.MAEPER M1
				  WHERE M1.mae_rut = fila.FILA_RUT)
AND NOT EXISTS (SELECT 1
				  from Academia.DBO.ALUMNO M2
				  WHERE M2.alu_rut = fila.FILA_RUT)

order by motivo.MOAT_FECHA_REGISTRO



select *
from @temp
order by 1 asc
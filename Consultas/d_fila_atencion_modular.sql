create table dbo.MOTIVO_ATENCION 
(
   MOAT_FECHA           date                           not null,
   MOAT_CODIGO          integer                        not null,
   SERV_CODIGO          integer                        not null,
   CATE_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   FILA_CODIGO          integer                        not null,
   FILA_FECHA           date                           not null,
   MOAT_NUMERO          varchar(10)                    null,
   MOAT_FECHA_REGISTRO  datetime                       null,
   MOAT_LOG_REGISTRO    varchar(250)                   null,
   constraint PK_MOTIVO_ATENCION primary key 
   (
         MOAT_CODIGO
      ,  MOAT_FECHA
      ,  SERV_CODIGO
      ,  CATE_CODIGO
      ,  OFRE_CODIGO
      ,  CCO_CODIGO
      ,  REP_CODIGO
      ,  EDU_CODIGO
      ,  FILA_CODIGO
      ,  FILA_FECHA
   )
);

create table DBO.FILAS_ATENCION
(
   FILA_FECHA           date                           not null,
   FILA_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   FILA_RUT             integer                        null,
   FILA_FECHA_REGISTRO  datetime                       null,
   FILA_LOG_REGISTRO    varchar(250)                   null,
   constraint PK_DBO_FILAS_ATENCION primary key clustered 
   (
        FILA_CODIGO
      ,FILA_FECHA
      ,OFRE_CODIGO
      ,CCO_CODIGO
      ,REP_CODIGO
      ,EDU_CODIGO
   )
);

create table DBO.SERVICIOS_REPARTICION 
(
   SERV_CODIGO          integer                        not null,
   CATE_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   SERV_NOMBRE          varchar(250)                   null,
   SERV_ABREVIACION     varchar(2)                     null,
   SERV_FECHA_INICIO    datetime                       null,
   SERV_FECHA_TERMINO   datetime                       null,
   SERV_FECHA_REGISTRO  datetime                       null,
   SERV_LOG_REGISTRO    varchar(250)                   null,
   constraint PK_DBO_SERVICIOS_REPARTICION primary key clustered (SERV_CODIGO, CATE_CODIGO, OFRE_CODIGO, CCO_CODIGO, REP_CODIGO, EDU_CODIGO)
);

create table dbo.SERVICIOS_SE_ASIGNAN 
(
	ASIG_CORRELATIVO	integer							not null,
	SERV_CODIGO			integer							not null,
	CATE_CODIGO			integer							not null,
	OFRE_CODIGO			integer							not null,
	CCO_CODIGO			decimal							not null,
	REP_CODIGO			decimal							not null,
	EDU_CODIGO			integer							not null,
	MOD_CODIGO			integer							not null,
	Fecha_inicio		datetime							null,
	fecha_termino		datetime							null,
	fecha_registro		datetime							null,
	Log_registro		varchar(250)						null,
   constraint PK_SERVICIOS_SE_ASIGNAN primary key clustered (ASIG_CORRELATIVO,SERV_CODIGO, CATE_CODIGO,OFRE_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO,MOD_CODIGO)
);

create table DBO.MODULOS_ATENCION 
(
   MOD_CODIGO           integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   
   MOD_NOMBRE           varchar(250)                   null,
   MOD_ABREVIACION      varchar(250)                   null,
   MOD_FECHA_INICIO     datetime                       null,
   MOD_FECHA_TERMINO    datetime                       null,
   MOD_FECHA_REGISTRO   datetime                       null,
   MOD_LOG_REGISTRO     varchar(250)                   null,
   constraint PK_DBO_MODULOS_ATENCION primary key clustered (MOD_CODIGO,OFRE_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO)
);

create table DBO.MODULOS_ASIGNADOS 
(
   MODU_CODIGO          integer                        not null,
   MOD_CODIGO           integer                        not null,
   USOF_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   OFRE_CODIGO          integer                        not null,
   MODU_FECHA_INICIO    datetime                      null,
   MODU_FECHA_TERMINO   datetime                      null,
   MODU_FECHA_REGISTRO  datetime                      null,
   MODU_LOG_REGISTRO    varchar(250)                   null,
   primary key clustered (MODU_CODIGO,MOD_CODIGO,USOF_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO,OFRE_CODIGO)
);

create table DBO.USUARIOS_OFICINA 
(
   MAE_RUT              decimal                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   USOF_CODIGO          integer                        not null,
   USOF_FECHA_INICIO    datetime                           null,
   USOF_FECHA_TERMINO   datetime                           null,
   USOF_FECHA_REGISTRO  datetime                       null,
   USOF_LOG_REGISTRO    varchar(250)                   null,
   constraint PK_DBO_USUARIOS_OFICINA primary key clustered (USOF_CODIGO,EDU_CODIGO,REP_CODIGO,CCO_CODIGO,OFRE_CODIGO)
);

declare @mod_codigo int
,		@MOAT_FECHA date
,		@moat_numero char
,		@moat_codigo int
,		@fila_rut int
,		@serv_codigo int
,		@cate_codigo int
,		@serv_nombre char
,		@serv_abreviacion char

select	@mod_codigo = 1


select	motivo.MOAT_FECHA
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
where	motivo.MOAT_FECHA = CONVERT(DATE,GETDATE())
and		modulos.MOD_CODIGO  = @mod_codigo
--and		modulos.OFRE_CODIGO = 
--and		modulos.CCO_CODIGO 	= 
--and		modulos.REP_CODIGO 	= 
--and		modulos.EDU_CODIGO 	= 
order by motivo.MOAT_FECHA_REGISTRO


--version en powerbuilder

select   motivo.MOAT_FECHA
,        motivo.moat_numero
,        motivo.MOAT_CODIGO
,        fila.FILA_CODIGO
,        motivo.serv_codigo
,        motivo.cate_codigo
,        servicios.serv_nombre
,        servicios.serv_abreviacion
,        fila.FILA_NOMBRE
,        fila.FILA_APELLIDO_PATERNO
,        fila.FILA_APELLIDO_MATERNO
from documentos_ubb.dbo.MOTIVO_ATENCION as motivo with(nolock)
join documentos_ubb.dbo.FILAS_ATENCION as fila with(nolock)
on       motivo.FILA_FECHA = fila.FILA_FECHA
and   motivo.FILA_CODIGO = fila.FILA_CODIGO
and   motivo.OFRE_CODIGO = fila.OFRE_CODIGO
and   motivo.CCO_CODIGO = fila.CCO_CODIGO
and   motivo.REP_CODIGO = fila.REP_CODIGO
and   motivo.EDU_CODIGO = fila.EDU_CODIGO
and     fila.FILA_FECHA = CONVERT(DATE,GETDATE())
join documentos_ubb.dbo.SERVICIOS_REPARTICION as servicios with(nolock)
on    motivo.SERV_CODIGO = servicios.SERV_CODIGO
and      motivo.CATE_CODIGO = servicios.CATE_CODIGO
and      motivo.OFRE_CODIGO = servicios.OFRE_CODIGO
and      motivo.CCO_CODIGO = servicios.CCO_CODIGO
and      motivo.REP_CODIGO = servicios.REP_CODIGO
and      motivo.EDU_CODIGO = servicios.EDU_CODIGO
and      (servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)
join documentos_ubb.dbo.SERVICIOS_SE_ASIGNAN as asignan with(nolock)
on       servicios.SERV_CODIGO = asignan.SERV_CODIGO
and      servicios.CATE_CODIGO = asignan.CATE_CODIGO
and      servicios.OFRE_CODIGO = asignan.OFRE_CODIGO
and      servicios.CCO_CODIGO = asignan.CCO_CODIGO
and      servicios.REP_CODIGO = asignan.REP_CODIGO
and      servicios.EDU_CODIGO = asignan.EDU_CODIGO
and      (asignan.fecha_termino >= CONVERT(DATETIME,GETDATE()) OR asignan.fecha_termino IS NULL)
join documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
on    asignan.MOD_CODIGO   = modulos.MOD_CODIGO
and      asignan.OFRE_CODIGO = modulos.OFRE_CODIGO
and      asignan.CCO_CODIGO   = modulos.CCO_CODIGO
and      asignan.REP_CODIGO   = modulos.REP_CODIGO
and      asignan.EDU_CODIGO   = modulos.EDU_CODIGO
and      (modulos.MOD_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR modulos.MOD_FECHA_TERMINO IS NULL)
join documentos_ubb.dbo.MODULOS_ASIGNADOS as asignados with(nolock)
on    asignados.MOD_CODIGO    = modulos.MOD_CODIGO
and      asignados.OFRE_CODIGO   = modulos.OFRE_CODIGO
and      asignados.CCO_CODIGO    = modulos.CCO_CODIGO
and      asignados.REP_CODIGO    = modulos.REP_CODIGO
and      asignados.EDU_CODIGO    = modulos.EDU_CODIGO
and      (asignados.MODU_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR asignados.MODU_FECHA_TERMINO IS NULL)
join documentos_ubb.dbo.USUARIOS_OFICINA as usuarios with(nolock)
on       usuarios.USOF_CODIGO    = asignados.USOF_CODIGO
and      usuarios.OFRE_CODIGO    = asignados.OFRE_CODIGO
and      usuarios.CCO_CODIGO  = asignados.CCO_CODIGO
and      usuarios.REP_CODIGO  = asignados.REP_CODIGO
and      usuarios.EDU_CODIGO  = asignados.EDU_CODIGO
and      (usuarios.USOF_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR usuarios.USOF_FECHA_TERMINO IS NULL)
where motivo.MOAT_FECHA = CONVERT(DATE,GETDATE())
and      modulos.MOD_CODIGO   =:MOD_CODIGO
and      modulos.OFRE_CODIGO  =:OFRE_CODIGO
and      modulos.CCO_CODIGO   =:CCO_CODIGO
and      modulos.REP_CODIGO   =:REP_CODIGO
and      modulos.EDU_CODIGO   =:EDU_CODIGO
and      motivo.estad_codigo  = 1
order by motivo.MOAT_FECHA_REGISTRO
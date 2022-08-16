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

create table DBO.MODULOS_ATENCION 
(
   MOD_CODIGO           integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   MOD_NOMBRE           varchar(250)                   null,
   MOD_ABREVIACION      varchar(250)                   null,
   MOD_FECHA_REGISTRO   datetime                      null,
   MOD_LOG_REGISTRO     varchar(250)                   null,
   constraint PK_DBO_MODULOS_ATENCION primary key clustered (MOD_CODIGO,OFRE_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO)
);



select   maeper.mae_nombre                as mae_nombre
,        maeper.mae_apellido_paterno      as mae_apellido_paterno
,        maeper.mae_apellido_materno      as mae_apellido_materno
,        asignados.USOF_CODIGO            as USOF_CODIGO
,        asignados.MODU_CODIGO            as MODU_CODIGO
,        asignados.MOD_CODIGO             as  MOD_CODIGO
,        asignados.CCO_CODIGO             as  CCO_CODIGO
,        asignados.REP_CODIGO             as  REP_CODIGO
,        asignados.EDU_CODIGO             as  EDU_CODIGO
,        asignados.OFRE_CODIGO            as  OFRE_CODIGO
,        asignados.MODU_FECHA_INICIO      as MODU_FECHA_INICIO   
,        asignados.MODU_FECHA_TERMINO     as MODU_FECHA_TERMINO   
,        asignados.MODU_FECHA_REGISTRO    as MODU_FECHA_REGISTRO   
,        asignados.MODU_LOG_REGISTRO      as MODU_LOG_REGISTRO
,        maeper.mae_rut                   as mae_rut
from  documentos_ubb.dbo.MODULOS_ASIGNADOS   as asignados         with(nolock)
join  documentos_ubb.dbo.USUARIOS_OFICINA    as usuarios          with(nolock)
on       asignados.OFRE_CODIGO   = usuarios.OFRE_CODIGO
and      asignados.CCO_CODIGO    = usuarios.CCO_CODIGO
and      asignados.REP_CODIGO    = usuarios.REP_CODIGO
and      asignados.EDU_CODIGO    = usuarios.EDU_CODIGO
and      asignados.USOF_CODIGO   = usuarios.USOF_CODIGO
join  creditotest.dbo.maeper                          as maeper                  with(nolock)
on       maeper.mae_rut = usuarios.MAE_RUT
join  documentos_ubb.dbo.MODULOS_ATENCION       as MODULOS_ATENCION  with(nolock)
on       asignados.OFRE_CODIGO   = MODULOS_ATENCION.OFRE_CODIGO
and      asignados.CCO_CODIGO    = MODULOS_ATENCION.CCO_CODIGO
and      asignados.REP_CODIGO    = MODULOS_ATENCION.REP_CODIGO
and      asignados.EDU_CODIGO    = MODULOS_ATENCION.EDU_CODIGO
and      asignados.MOD_CODIGO    = MODULOS_ATENCION.MOD_CODIGO
where (asignados.MODU_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR asignados.MODU_FECHA_TERMINO IS NULL)
and      asignados.MOD_CODIGO =  :MOD_CODIGO
and      asignados.OFRE_CODIGO   =  :OFRE_CODIGO
and      asignados.CCO_CODIGO =  :CCO_CODIGO
and      asignados.REP_CODIGO    =  :REP_CODIGO
and      asignados.EDU_CODIGO    =  :EDU_CODIGO

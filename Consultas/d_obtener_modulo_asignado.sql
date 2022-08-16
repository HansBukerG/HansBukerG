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

create table dbo.SERVICIOS_SE_ASIGNAN 
(
   ASIG_CORRELATIVO  integer                    not null,
   SERV_CODIGO       integer                    not null,
   CATE_CODIGO       integer                    not null,
   OFRE_CODIGO       integer                    not null,
   CCO_CODIGO        decimal                    not null,
   REP_CODIGO        decimal                    not null,
   EDU_CODIGO        integer                    not null,
   MOD_CODIGO        integer                    not null,
   Fecha_inicio      datetime                   null,
   fecha_termino     datetime                   null,
   fecha_registro    datetime                   null,
   Log_registro      varchar(250)                  null,
   constraint PK_SERVICIOS_SE_ASIGNAN primary key clustered (ASIG_CORRELATIVO,SERV_CODIGO, CATE_CODIGO,OFRE_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO,MOD_CODIGO)
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
   SERV_FECHA_INICIO    datetime                       null,
   SERV_FECHA_TERMINO   datetime                       null,
   SERV_FECHA_REGISTRO  datetime                       null,
   SERV_LOG_REGISTRO    varchar(250)                   null,
   constraint PK_DBO_SERVICIOS_REPARTICION primary key clustered (SERV_CODIGO, CATE_CODIGO, OFRE_CODIGO, CCO_CODIGO, REP_CODIGO, EDU_CODIGO)
);


select count(modulos.MOD_ABREVIACION), modulos.MOD_ABREVIACION
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
where servicios.SERV_CODIGO   = 1
and   servicios.CATE_CODIGO   = 3

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
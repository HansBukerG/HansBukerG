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

--Version funcional

select   ltrim(rtrim(servicios.SERV_NOMBRE)) as serv_nombre
,     servicios.serv_codigo as serv_codigo
,     servicios.cate_codigo as cate_codigo
from  documentos_ubb.dbo.servicios_reparticion as servicios with(nolock)
join  documentos_ubb.dbo.engloban_programas as programas with(nolock)
on       servicios.SERV_CODIGO   = programas.SERV_CODIGO
and   servicios.CATE_CODIGO   = programas.CATE_CODIGO
and   servicios.OFRE_CODIGO   = programas.OFRE_CODIGO
and   servicios.CCO_CODIGO    = programas.CCO_CODIGO
and   servicios.REP_CODIGO    = programas.REP_CODIGO
and   servicios.EDU_CODIGO    = programas.EDU_CODIGO
join  documentos_ubb.dbo.servicio_vincula_situacion as situacion with(nolock)
on       servicios.SERV_CODIGO   = situacion.SERV_CODIGO
and   servicios.CATE_CODIGO   = situacion.CATE_CODIGO
and   servicios.OFRE_CODIGO   = situacion.OFRE_CODIGO
and   servicios.CCO_CODIGO    = situacion.CCO_CODIGO
and   servicios.REP_CODIGO    = situacion.REP_CODIGO
and   servicios.EDU_CODIGO    = situacion.EDU_CODIGO
where    (servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)
and      programas.TPR_CORRELATIVO  =:TPR_CORRELATIVO
and      situacion.SAA_CODIGO       =:SAA_CODIGO
and      servicios.OFRE_CODIGO      =:OFRE_CODIGO 
and      servicios.CCO_CODIGO       =:CCO_CODIGO
and      servicios.REP_CODIGO       =:REP_CODIGO
and      servicios.EDU_CODIGO       =:EDU_CODIGO
and      servicios.SERV_CODIGO in ( 
                                    select asignan.serv_codigo
                                    from servicios_se_asignan as asignan
                                    where servicios.SERV_CODIGO   = asignan.SERV_CODIGO
                                    and   servicios.CATE_CODIGO   = asignan.CATE_CODIGO
                                    and   servicios.OFRE_CODIGO   = asignan.OFRE_CODIGO
                                    and   servicios.CCO_CODIGO    = asignan.CCO_CODIGO
                                    and   servicios.REP_CODIGO    = asignan.REP_CODIGO
                                    and   servicios.EDU_CODIGO    = asignan.EDU_CODIGO
                                    and   (asignan.fecha_termino >= CONVERT(DATETIME,GETDATE()) OR asignan.fecha_termino IS NULL)
                                    )
--
--Version kawaii
--

select   ltrim(rtrim(servicios.SERV_NOMBRE)) as serv_nombre
,     servicios.serv_codigo as serv_codigo
,     servicios.cate_codigo as cate_codigo
,   servicios.SERV_ABREVIACION as serv_abreviacion
,   categoria.cate_abreviacion as cate_abreviacion
from  documentos_ubb.dbo.servicios_reparticion as servicios with(nolock)
join documentos_ubb.dbo.CATEGORIA_SERVICIO as categoria with(nolock)
on   servicios.CATE_CODIGO   = categoria.CATE_CODIGO
and   servicios.OFRE_CODIGO   = categoria.OFRE_CODIGO
and   servicios.CCO_CODIGO    = categoria.CCO_CODIGO
and   servicios.REP_CODIGO    = categoria.REP_CODIGO
and   servicios.EDU_CODIGO    = categoria.EDU_CODIGO
and   (categoria.CATE_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR categoria.CATE_FECHA_TERMINO IS NULL)
join  documentos_ubb.dbo.engloban_programas as programas with(nolock)
on       servicios.SERV_CODIGO   = programas.SERV_CODIGO
and   servicios.CATE_CODIGO   = programas.CATE_CODIGO
and   servicios.OFRE_CODIGO   = programas.OFRE_CODIGO
and   servicios.CCO_CODIGO    = programas.CCO_CODIGO
and   servicios.REP_CODIGO    = programas.REP_CODIGO
and   servicios.EDU_CODIGO    = programas.EDU_CODIGO
join  documentos_ubb.dbo.servicio_vincula_situacion as situacion with(nolock)
on       servicios.SERV_CODIGO   = situacion.SERV_CODIGO
and   servicios.CATE_CODIGO   = situacion.CATE_CODIGO
and   servicios.OFRE_CODIGO   = situacion.OFRE_CODIGO
and   servicios.CCO_CODIGO    = situacion.CCO_CODIGO
and   servicios.REP_CODIGO    = situacion.REP_CODIGO
and   servicios.EDU_CODIGO    = situacion.EDU_CODIGO
where    (servicios.SERV_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR servicios.SERV_FECHA_TERMINO IS NULL)
and      programas.TPR_CORRELATIVO  =:TPR_CORRELATIVO
and      situacion.SAA_CODIGO       =:SAA_CODIGO
and      servicios.OFRE_CODIGO      =:OFRE_CODIGO 
and      servicios.CCO_CODIGO       =:CCO_CODIGO
and      servicios.REP_CODIGO       =:REP_CODIGO
and      servicios.EDU_CODIGO       =:EDU_CODIGO
and      servicios.SERV_CODIGO 
in (
      select asignan.serv_codigo
      from servicios_se_asignan as asignan
      
      join documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
      on    modulos.MOD_CODIGO = asignan.MOD_CODIGO
      and   modulos.OFRE_CODIGO = asignan.OFRE_CODIGO
      and   modulos.CCO_CODIGO = asignan.CCO_CODIGO
      and   modulos.REP_CODIGO = asignan.REP_CODIGO
      and   modulos.EDU_CODIGO = asignan.EDU_CODIGO
      and (modulos.MOD_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR modulos.MOD_FECHA_TERMINO IS NULL)
      
      join documentos_ubb.dbo.MODULOS_ASIGNADOS as asignados with(nolock)
      on asignados.MOD_CODIGO = modulos.MOD_CODIGO
      and asignados.OFRE_CODIGO = modulos.OFRE_CODIGO
      and asignados.CCO_CODIGO = modulos.CCO_CODIGO
      and asignados.REP_CODIGO = modulos.REP_CODIGO
      and asignados.EDU_CODIGO = modulos.EDU_CODIGO
      and (asignados.MODU_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR asignados.MODU_FECHA_TERMINO IS NULL)
      
      join documentos_ubb.dbo.USUARIOS_OFICINA as usuarios with(nolock)
      on usuarios.usof_codigo = asignados.usof_codigo
      and usuarios.OFRE_CODIGO = asignados.OFRE_CODIGO
      and usuarios.CCO_CODIGO = asignados.CCO_CODIGO
      and usuarios.REP_CODIGO = asignados.REP_CODIGO
      and usuarios.EDU_CODIGO = asignados.EDU_CODIGO
      and (usuarios.USOF_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR usuarios.USOF_FECHA_TERMINO IS NULL)
      
      where servicios.SERV_CODIGO   = asignan.SERV_CODIGO
      and   servicios.CATE_CODIGO   = asignan.CATE_CODIGO
      and   servicios.OFRE_CODIGO   = asignan.OFRE_CODIGO
      and   servicios.CCO_CODIGO    = asignan.CCO_CODIGO
      and   servicios.REP_CODIGO    = asignan.REP_CODIGO
      and   servicios.EDU_CODIGO    = asignan.EDU_CODIGO
      and   (asignan.fecha_termino >= CONVERT(DATETIME,GETDATE()) OR asignan.fecha_termino IS NULL)
)
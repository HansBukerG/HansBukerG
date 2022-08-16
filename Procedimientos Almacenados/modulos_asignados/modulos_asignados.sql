create table DBO.MODULOS_ASIGNADOS 
(
      MODU_CODIGO          integer                       not null
   ,  MOD_CODIGO           integer                       not null
   ,  USOF_CODIGO          integer                       not null
   ,  CCO_CODIGO           decimal                       not null
   ,  REP_CODIGO           decimal                       not null
   ,  EDU_CODIGO           integer                       not null
   ,  OFRE_CODIGO          integer                       not null
   ,  MODU_FECHA_INICIO    datetime                      null
   ,  MODU_FECHA_TERMINO   datetime                      null
   ,  MODU_FECHA_REGISTRO  datetime                      null
   ,  MODU_LOG_REGISTRO    varchar(250)                  null
   primary key clustered (MODU_CODIGO,MOD_CODIGO,USOF_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO,OFRE_CODIGO)
);
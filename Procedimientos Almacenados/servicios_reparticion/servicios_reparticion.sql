//Tabla DBO.SERVICIOS_REPARTICION 

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
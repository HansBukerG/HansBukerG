create table DBO.OFICINA_REPARTICION
(
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   OFRE_NOMBRE_OFICINA  varchar(250)                   null,
   OFRE_ABREVIACION     varchar(250)                   null,
   OFRE_FECHA_INICIO    datetime                       null,
   OFRE_FECHA_TERMINO   datetime                       null,
   OFRE_FECHA_REGISTRO  datetime                       null,
   OFRE_LOG_REGISTRO    varchar(250)                   null,
   constraint PK_DBO_OFICINA_REPARTICION primary key clustered (OFRE_CODIGO, CCO_CODIGO, REP_CODIGO, EDU_CODIGO)
);
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


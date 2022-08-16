create table dbo.ATENCION_ASIGNADA
(
   atas_correlativo     integer                        not null,
   USOF_CODIGO          integer                        not null,
   MOD_CODIGO           integer                        not null,
   MODU_CODIGO          integer                        not null,
   MOAT_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   FILA_YEAR            integer                        not null,
   FILA_CODIGO          integer                        not null,
   ESTAD_CODIGO         integer                        not null,
   CATE_CODIGO          integer                        not null,
   SERV_CODIGO          integer                        not null,
   ATAS_FECHA_REGISTRO  datetime                       null,
   ATAS_LOG_REGISTRO    varchar(250)                   null,
   ATAS_FECHA_ATENCION  datetime                       null,
   constraint PK_ATENCION_ASIGNADA primary key clustered (atas_correlativo, MOAT_CODIGO, OFRE_CODIGO, REP_CODIGO, EDU_CODIGO, FILA_YEAR, FILA_CODIGO, MODU_CODIGO, MOD_CODIGO, USOF_CODIGO)
);
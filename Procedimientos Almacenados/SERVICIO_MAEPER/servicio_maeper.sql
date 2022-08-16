create table dbo.SERVICIO_MAEPER 
(
   SEMA_CODIGO          integer                        not null,
   SERV_CODIGO          integer                        not null,
   CATE_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   SEMA_DESCRIPCION     varchar(50)                    null,
   SEMA_FECHA_REGISTRO  datetime                       null,
   SEMA_LOG_REGISTRO    varchar(250)                   null,
   constraint PK_SERVICIO_MAEPER primary key clustered (SERV_CODIGO, CATE_CODIGO, OFRE_CODIGO, CCO_CODIGO, REP_CODIGO, EDU_CODIGO, SEMA_CODIGO)
);
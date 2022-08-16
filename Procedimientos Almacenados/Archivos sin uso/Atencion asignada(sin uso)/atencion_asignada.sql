create table DBO.ATENCION_ASIGNADA 
(
   ATE_FECHA            date                           not null,
   ATE_CODIGO           integer                        not null,
   SERV_CODIGO          integer                        not null,
   CATE_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   MOD_CODIGO           integer                        not null,
   FILA_FECHA           date                           not null,
   FILA_CODIGO          integer                        not null,
   MODU_CODIGO          integer                        not null,
   ATE_NUMERO           varchar(10)                    null,
   ATE_FECHA_REGISTRO   datetime                       null,
   ATE_LOG_REGISTRO     varchar(250)                   null,
   constraint PK_DBO_ATENCION_ASIGNADA primary key clustered (
         ATE_FECHA
      ,  ATE_CODIGO
      ,  SERV_CODIGO
      ,  CATE_CODIGO
      ,  OFRE_CODIGO
      ,  CCO_CODIGO
      ,  REP_CODIGO
      ,  EDU_CODIGO
      ,  MOD_CODIGO
      )
);
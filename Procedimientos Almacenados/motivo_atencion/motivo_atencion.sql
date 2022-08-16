create table dbo.MOTIVO_ATENCION
(
   MOAT_CODIGO                      integer                       not null,
   FILA_YEAR                        integer                       not null,
   FILA_CODIGO                      integer                       not null,
   OFRE_CODIGO                      integer                       not null,
   REP_CODIGO                       decimal                       not null,
   EDU_CODIGO                       integer                       not null,
   CATE_CODIGO                      integer                       not null,
   SERV_CODIGO                      integer                       not null,
   TPR_REFERENCIA                   integer                       null,
   MOAT_NUMERO                      varchar(10)                   null,
   ESTAD_CODIGO                     integer                       null,
   MOAT_FECHA_REGISTRO              datetime                      null,
   MOAT_LOG_REGISTRO                varchar(250)                  null,
   MOAT_FECHA_INICIO                datetime                      null,
   MOAT_FECHA_TERMINO               datetime                      null,
   MOAT_FECHA_PAUSA_ACUMULATIVO     datetime                      null,
   pca_codigo                       integer                       null,
   crr_codigo                       integer                       null,
   alc_ano_ingreso                  integer                       null,
   alc_periodo                      integer                       null
   constraint PK_MOTIVO_ATENCION primary key (MOAT_CODIGO, OFRE_CODIGO, REP_CODIGO, EDU_CODIGO, FILA_YEAR, FILA_CODIGO, CATE_CODIGO, SERV_CODIGO)
);



ALTER TABLE dbo.MOTIVO_ATENCION 
ADD   pca_codigo                       integer                       null
,     crr_codigo                       integer                       null
,     alc_ano_ingreso                  integer                       null
,     alc_periodo                      integer                       null

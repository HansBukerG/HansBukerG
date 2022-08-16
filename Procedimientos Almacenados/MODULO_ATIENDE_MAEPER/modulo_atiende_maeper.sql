create table dbo.MODULO_ATIENDE_MAEPER 
(
   MAM_CORRELATIVO      integer                        not null,
   MOD_CODIGO           integer                        not null,
   OFRE_CODIGO          integer                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   MAM_DESCRIPCION      varchar(100)                    null,
   FECHA_REGISTRO       datetime                       null,
   LOG_REGISTRO         varchar(250)                   null,
   constraint PK_MODULO_ATIENDE_MAEPER primary key (MAM_CORRELATIVO, MOD_CODIGO, OFRE_CODIGO, REP_CODIGO, EDU_CODIGO)
);
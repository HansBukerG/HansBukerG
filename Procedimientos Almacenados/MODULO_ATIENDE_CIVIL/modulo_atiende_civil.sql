create table dbo.MODULO_ATIENDE_CIVIL 
(
   MAC_CORRELATIVO      integer                        not null,
   MOD_CODIGO           integer                        not null,
   OFRE_CODIGO          integer                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   MAC_DESCRIPCION      varchar(20)                    null,
   FECHA_REGISTRO       datetime                       null,
   LOG_REGISTRO         varchar(250)                   null,
   constraint PK_MODULO_ATIENDE_CIVIL primary key (MAC_CORRELATIVO, MOD_CODIGO, OFRE_CODIGO, REP_CODIGO, EDU_CODIGO)
);

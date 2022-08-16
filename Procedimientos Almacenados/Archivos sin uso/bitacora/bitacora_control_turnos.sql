create table dbo.BITACORA_CONTROL_TURNOS 
(
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   BI_FECHA_REGISTRO    datetime                       null,
   constraint PK_BITACORA_CONTROL_TURNOS primary key clustered (OFRE_CODIGO, CCO_CODIGO, REP_CODIGO, EDU_CODIGO)
);
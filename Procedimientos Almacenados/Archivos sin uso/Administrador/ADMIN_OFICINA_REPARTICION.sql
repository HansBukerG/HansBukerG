create table dbo.ADMIN_OFICINA_REPARTICION 
(
   AOR_CORRELATIVO      integer                        	not null,
   MAE_RUT              decimal                        	null,
   REP_CODIGO           decimal                      	not null,
   AOR_FECHA_INICIO     datetime                      	null,
   AOR_FECHA_TERMINO    datetime                      	null,
   AOR_FECHA_REGISTRO   datetime                      	null,
   AOR_LOG_REGISTRO     varchar(250)                   	null,
   constraint PK_ADMIN_OFICINA_REPARTICION primary key clustered (AOR_CORRELATIVO,REP_CODIGO)
);




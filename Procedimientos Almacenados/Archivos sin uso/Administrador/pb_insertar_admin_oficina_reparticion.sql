create proc dbo.pb_pb_insertar_admin_oficina_reparticion
(
   @AOR_CORRELATIVO      integer,
   @MAE_RUT              decimal,
   @REP_CODIGO           decimal,
   @AOR_FECHA_INICIO     datetime,
   @AOR_FECHA_TERMINO    datetime,
   @AOR_FECHA_REGISTRO   datetime,
   @AOR_LOG_REGISTRO     varchar(250)
) as
insert into DOCUMENTOS_UBB.dbo.ADMIN_OFICINA_REPARTICION with(updlock)
(
   AOR_CORRELATIVO,
   MAE_RUT,
   REP_CODIGO,
   AOR_FECHA_INICIO,
   AOR_FECHA_TERMINO,
   AOR_FECHA_REGISTRO,
   AOR_LOG_REGISTRO
)
values 
(
   @AOR_CORRELATIVO,
   @MAE_RUT,
   @REP_CODIGO,
   @AOR_FECHA_INICIO,
   @AOR_FECHA_TERMINO,
   @AOR_FECHA_REGISTRO,
   @AOR_LOG_REGISTRO
);


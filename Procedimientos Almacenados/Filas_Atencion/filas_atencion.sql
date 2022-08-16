create table DBO.FILAS_ATENCION
(
   FILA_YEAR               integer                       not null ,
   FILA_CODIGO             integer                       not null ,
   OFRE_CODIGO             integer                       not null ,
   REP_CODIGO              decimal                       not null ,
   EDU_CODIGO              integer                       not null ,
   FILA_RUT                integer                       null     ,
   FILA_FECHA_REGISTRO      datetime                     null     ,
   FILA_LOG_REGISTRO       varchar(250)                  null     
   constraint PK_DBO_FILAS_ATENCION primary key clustered 
   (
         FILA_YEAR
      ,  FILA_CODIGO
      ,  OFRE_CODIGO
      ,  REP_CODIGO
      ,  EDU_CODIGO
   )
);



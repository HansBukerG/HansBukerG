create table dbo.OFICINA_IP_PUERTO 
(
   CON_CORRELATIVO      integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   CON_IP               varchar(100)                   null,
   CON_PUERTO           varchar(100)                   null,
   CON_FECHA_REGISTRO   datetime					   null,
   constraint PK_OFICINA_IP_PUERTO primary key clustered 
   (
   		  CON_CORRELATIVO
   		, OFRE_CODIGO
   		, CCO_CODIGO
   		, REP_CODIGO
   		, EDU_CODIGO
   	)
);
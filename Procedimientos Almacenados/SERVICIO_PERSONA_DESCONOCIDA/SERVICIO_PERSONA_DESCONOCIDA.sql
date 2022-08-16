create table dbo.SERVICIO_PERSONA_DESCONOCIDA 
(
   DESC_CODIGO          integer                        not null,
   SERV_CODIGO          integer                        not null,
   CATE_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   DESC_DESCRIPCION     varchar(50)                    null,
   DESC_FECHA_REGISTRO  datetime                       null,
   DESC_LOG_REGISTRO    varchar(250)                   null,
   constraint PK_SERVICIO_PERSONA_DESCONOCID primary key clustered 
   (
	   		DESC_CODIGO
	   	,	SERV_CODIGO
	   	,	CATE_CODIGO
	   	,	OFRE_CODIGO
	   	,	CCO_CODIGO
	   	,	REP_CODIGO
	   	,	EDU_CODIGO
   	)
);
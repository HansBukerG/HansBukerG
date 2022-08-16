//Tabla DBO_CATEGORIA_SERVICIO

CREATE table DOCUMENTOS_UBB.DBO.CATEGORIA_SERVICIO 
(	
	CATE_CODIGO          integer                        not null,
	OFRE_CODIGO          integer                        not null,
	CCO_CODIGO           decimal                        not null,
	REP_CODIGO           decimal                        not null,
	EDU_CODIGO           integer                        not null,
	CATE_NOMBRE          varchar(250)                       null,
	CATE_ABREVIACION     varchar(2)                     	null,
	CATE_FECHA_INICIO    datetime                       	null,
	CATE_FECHA_TERMINO   datetime                       	null,
	CATE_FECHA_REGISTRO  datetime                      		null,
	CATE_LOG_REGISTRO    varchar(250)                   	null,
	primary key clustered (CATE_CODIGO, OFRE_CODIGO, CCO_CODIGO, REP_CODIGO, EDU_CODIGO)
);

create table dbo.SERVICIOS_SE_ASIGNAN 
(
	ASIG_CORRELATIVO	integer							not null,
	SERV_CODIGO			integer							not null,
	CATE_CODIGO			integer							not null,
	OFRE_CODIGO			integer							not null,
	CCO_CODIGO			decimal							not null,
	REP_CODIGO			decimal							not null,
	EDU_CODIGO			integer							not null,
	MOD_CODIGO			integer							not null,
	Fecha_inicio		datetime							null,
	fecha_termino		datetime							null,
	fecha_registro		datetime							null,
	Log_registro		varchar(250)						null,
   constraint PK_SERVICIOS_SE_ASIGNAN primary key clustered (ASIG_CORRELATIVO,SERV_CODIGO, CATE_CODIGO,OFRE_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO,MOD_CODIGO)
);

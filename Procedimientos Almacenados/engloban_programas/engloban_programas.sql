create table dbo.ENGLOBAN_PROGRAMAS 
(
	ENPR_CODIGO          integer					not null,
	TPR_CORRELATIVO      integer					not null,
	SERV_CODIGO          integer                    not null,
	CATE_CODIGO          integer                    not null,
	OFRE_CODIGO          integer					not null,
	CCO_CODIGO           decimal					not null,
	REP_CODIGO           decimal					not null,
	EDU_CODIGO           integer					not null,
	ENPR_FECHA_REGISTRO  datetime						null,
	ENPR_LOG_REGISTRO    varchar(250)					null,
	primary key clustered (
		ENPR_CODIGO
		,TPR_CORRELATIVO
		,SERV_CODIGO
		,CATE_CODIGO
		,OFRE_CODIGO
		,CCO_CODIGO
		,REP_CODIGO
		,EDU_CODIGO)
);
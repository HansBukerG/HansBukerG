--pb_insertar_nueva_fila
create table DBO.ATENCION_ASIGNADA 
(
   ATE_FECHA            date                           not null,
   ATE_CODIGO           integer                        not null,
   SERV_CODIGO          integer                        not null,
   CATE_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   MOD_CODIGO           integer                        not null,
   FILA_FECHA           date                           not null,
   FILA_CODIGO          integer                        not null,
   MODU_CODIGO          integer                        not null,
   ATE_NUMERO           varchar(10)                    null,
   ATE_FECHA_REGISTRO   datetime                       null,
   ATE_LOG_REGISTRO     varchar(250)                   null,
   constraint PK_DBO_ATENCION_ASIGNADA primary key clustered (
         ATE_FECHA
      ,  ATE_CODIGO
      ,  SERV_CODIGO
      ,  CATE_CODIGO
      ,  OFRE_CODIGO
      ,  CCO_CODIGO
      ,  REP_CODIGO
      ,  EDU_CODIGO
      ,  MOD_CODIGO
      )
);

create proc dbo.pb_insertar_nueva_fila
	(
		@ATE_FECHA            date
	,   @ATE_CODIGO           integer
	,   @SERV_CODIGO          integer
	,   @CATE_CODIGO          integer
	,   @OFRE_CODIGO          integer
	,   @CCO_CODIGO           decimal
	,   @REP_CODIGO           decimal
	,   @EDU_CODIGO           integer
	,   @MOD_CODIGO           integer
	,   @FILA_FECHA           date
	,   @FILA_CODIGO          integer
	,   @MODU_CODIGO          integer
	,   @ATE_NUMERO           varchar(10)
	,   @ATE_FECHA_REGISTRO   datetime
	,   @ATE_LOG_REGISTRO     varchar(250)
	) as
insert into DOCUMENTOS_UBB.dbo.ATENCION_ASIGNADA with(updlock)
	(
		ATE_FECHA
	,   ATE_CODIGO
	,   SERV_CODIGO
	,   CATE_CODIGO
	,   OFRE_CODIGO
	,   CCO_CODIGO
	,   REP_CODIGO
	,   EDU_CODIGO
	,   MOD_CODIGO
	,   FILA_FECHA
	,   FILA_CODIGO
	,   MODU_CODIGO
	,   ATE_NUMERO
	,   ATE_FECHA_REGISTRO
	,   ATE_LOG_REGISTRO
	)
values 
	(
		@ATE_FECHA
	,   @ATE_CODIGO
	,   @SERV_CODIGO
	,   @CATE_CODIGO
	,   @OFRE_CODIGO
	,   @CCO_CODIGO
	,   @REP_CODIGO
	,   @EDU_CODIGO
	,   @MOD_CODIGO
	,   @FILA_FECHA
	,   @FILA_CODIGO
	,   @MODU_CODIGO
	,   @ATE_NUMERO
	,   @ATE_FECHA_REGISTRO
	,   @ATE_LOG_REGISTRO
	);


datetime fecha
date fecha_hoy
long correlativo

fecha = f_obtenerfechasql()
fecha_hoy = date(fecha)

select isnull(max(FILA_CODIGO),0)+1
into :correlativo
from DOCUMENTOS_UBB.dbo.filas_atencion with (nolock)
where	FILA_FECHA 		=	:fecha_hoy
and		SERV_CODIGO 	= 	:serv_codigo
and 	CATE_CODIGO		=	:cate_codigo
and		OFRE_CODIGO 	= 	:ofre_codigo_global
and		CCO_CODIGO 		=	:cco_codigo_global
and		REP_CODIGO 		=	:rep_codigo_global
and		EDU_CODIGO 		=	:edu_codigo_global;



declare pb_insertar_nueva_fila procedure for DOCUMENTOS_UBB.dbo.pb_insertar_nueva_fila
		@ATE_FECHA			=:fila_fecha_codigo
	,   @ATE_CODIGO			=:fila_codigo
	,   @SERV_CODIGO		=:serv_codigo_global
	,   @CATE_CODIGO		=:cate_codigo_global
	,   @OFRE_CODIGO		=:ofre_codigo_global
	,   @CCO_CODIGO			=:cco_codigo_global
	,   @REP_CODIGO			=:rep_codigo_global
	,   @EDU_CODIGO			=:edu_codigo_global
	,   @MOD_CODIGO			=:mod_codigo
	,   @FILA_FECHA			=:fila_fecha_codigo
	,   @FILA_CODIGO		=:correlativo
	,   @MODU_CODIGO		=:modu_codigo
	,   @ATE_NUMERO			=:
	,	@ATE_FECHA_REGISTRO	=:fecha
     ,	@ATE_LOG_REGISTRO	=:gs_login;

 	execute pb_insertar_nueva_fila;
	if sqlca.sqlcode < 0 then
		ls_error = sqlca.sqlerrtext;
		close pb_insertar_nueva_fila;
		messagebox("error","error en sp: "+ls_error, stopsign!)
		return
	end if
	messagebox("hecho","se ha insertado el dato")
	close pb_insertar_nueva_fila;
return
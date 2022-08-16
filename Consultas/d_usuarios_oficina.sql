SELECT
	USUARIOS.cco_codigo					as cco_codigo
,	USUARIOS.USOF_CODIGO				as USOF_CODIGO
,	USUARIOS.mae_rut						as mae_rut
,	USUARIOS.rep_codigo					as rep_codigo
,	OFICINA.ofre_codigo						as ofre_codigo
,	MAEPER.mae_nombre					as mae_nombre
,	MAEPER.mae_apellido_paterno		as mae_apellido_paterno 
,    MAEPER.mae_apellido_materno		as mae_apellido_materno
,	USUARIOS.USOF_FECHA_INICIO 	as USOF_FECHA_INICIO
,	USUARIOS.USOF_FECHA_TERMINO	as USOF_FECHA_TERMINO
FROM	DOCUMENTOS_UBB.dbo.OFICINA_REPARTICION 		as OFICINA with(nolock)
join DOCUMENTOS_UBB.dbo.USUARIOS_OFICINA 		as USUARIOS 		with(nolock) 
on  		USUARIOS.ofre_codigo	=	OFICINA.ofre_codigo
and 		USUARIOS.cco_codigo		= 	OFICINA.cco_codigo
and			USUARIOS.rep_codigo		= 	OFICINA.rep_codigo
and 		USUARIOS.edu_codigo 	= 	OFICINA.edu_codigo
join 		CREDITOTEST.DBO.CONTRATO 					as CONTRATO 	with(nolock) 	
on  		USUARIOS.mae_rut			= 	CONTRATO.mae_rut
join	 	CREDITOTEST.dbo.maeper 							as MAEPER 		with(nolock)  	
on 			MAEPER.mae_rut			=	CONTRATO.mae_rut 	
join 		Vrae.dbo.reparticion 									as REPARTICION 	with(nolock)		
on  		REPARTICION.rep_codigo 	= OFICINA.rep_codigo
WHERE 		 (CONTRATO.cnt_fecha_termino >= CONVERT(DATETIME,GETDATE()) OR CONTRATO.cnt_fecha_termino IS NULL)
and			(USUARIOS.USOF_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR USUARIOS.USOF_FECHA_TERMINO IS NULL)
and			USUARIOS.ofre_codigo =	:ofre_codigo
and			USUARIOS.cco_codigo	 =	:cco_codigo
and   			USUARIOS.rep_codigo	 =	:rep_codigo
and   			USUARIOS.edu_codigo  =	:EDU_CODIGO
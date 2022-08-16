SELECT	maeper.mae_nombre 			as mae_nombre
	,	maeper.mae_apellido_paterno 		as mae_apellido_paterno
	,	maeper.mae_apellido_materno 	as mae_apellido_materno
	, 	usuarios_oficina.mae_rut 			as rut
	,	usuarios_oficina.usof_codigo		as usof_codigo
FROM
	DOCUMENTOS_UBB.dbo.OFICINA_REPARTICION 		as oficina_reparticion with(nolock)
	join DOCUMENTOS_UBB.dbo.USUARIOS_OFICINA 		as usuarios_oficina 		with(nolock) 
		on  		usuarios_oficina.ofre_codigo	=	oficina_reparticion.ofre_codigo
		and 		usuarios_oficina.cco_codigo		= 	oficina_reparticion.cco_codigo
		and		usuarios_oficina.rep_codigo		= 	oficina_reparticion.rep_codigo
		and 		usuarios_oficina.edu_codigo 	= 	oficina_reparticion.edu_codigo
	join 		CREDITOTEST.DBO.CONTRATO 					as contrato 	with(nolock) 	
		on  usuarios_oficina.mae_rut			= 	contrato.mae_rut
	join	 	CREDITOTEST.dbo.maeper 							as maeper 		with(nolock)  	
		on maeper.mae_rut			=	contrato.mae_rut 	
	join 		Vrae.dbo.reparticion 									as reparticion 	with(nolock)		
		on  reparticion.rep_codigo 	= oficina_reparticion.rep_codigo
	join  SALAS.[dbo].[edificios] as edificios with(nolock)
		on       oficina_reparticion.edu_codigo      = edificios.id
	WHERE (contrato.cnt_fecha_termino >= CONVERT(DATE,GETDATE()) OR contrato.cnt_fecha_termino IS NULL)
		and (usuarios_oficina.USOF_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR usuarios_oficina.USOF_FECHA_TERMINO IS NULL)
		and maeper.mae_apellido_paterno like 	:apellido+'%'
		and oficina_reparticion.ofre_codigo = 	:ofre_codigo
		and oficina_reparticion.cco_codigo 	=	:cco_codigo
		and oficina_reparticion.rep_codigo 	=	:rep_codigo
		and oficina_reparticion.edu_codigo 	=	:edu_codigo

		
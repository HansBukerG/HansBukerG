select  reparticion.rep_nombre 			as rep_nombre,
		EDIFICIOS_UBB.edu_descripcion 	as edu_descripcionas,
		OFICINA_REPARTICION.ofre_codigo as ofre_codigo,
		OFICINA_REPARTICION.cco_codigo 	as cco_codigo,
		OFICINA_REPARTICION.rep_codigo 	as rep_codigo,
		OFICINA_REPARTICION.edu_codigo 	as edu_codigo
from	DOCUMENTOS_UBB.dbo.OFICINA_REPARTICION 						as OFICINA_REPARTICION 	with(nolock)
join 	DOCUMENTOS_UBB.dbo.USUARIOS_OFICINA 					as USUARIOS_OFICINA 	with(nolock) 
		on  		USUARIOS_OFICINA.ofre_codigo			=	OFICINA_REPARTICION.ofre_codigo
		and 		USUARIOS_OFICINA.cco_codigo			= 	OFICINA_REPARTICION.cco_codigo
		and			USUARIOS_OFICINA.rep_codigo			= 	OFICINA_REPARTICION.rep_codigo
		and 		USUARIOS_OFICINA.edu_codigo 			= 	OFICINA_REPARTICION.edu_codigo 

join 	CREDITOTEST.DBO.CONTRATO 			as CONTRATO 	with(nolock) 	
		on  USUARIOS_OFICINA.mae_rut			= 	CONTRATO.mae_rut

join	 CREDITOTEST.dbo.maeper 				as maeper 	with(nolock)  	
		on maeper.mae_rut			=	CONTRATO.mae_rut 	

join 	Vrae.dbo.reparticion 							as reparticion 	with(nolock)		
		on  reparticion.rep_codigo 	= OFICINA_REPARTICION.rep_codigo

join 	Academia.dbo.EDIFICIOS_UBB 		  	as EDIFICIOS_UBB 	with(nolock) 
		on EDIFICIOS_UBB.edu_codigo		= OFICINA_REPARTICION.edu_codigo
	
WHERE (CONTRATO.cnt_fecha_termino >= CONVERT(DATE,GETDATE()) OR CONTRATO.cnt_fecha_termino IS NULL)
	and		USUARIOS_OFICINA.mae_rut = :mae_rut


	//powerbuilder

select  ltrim(rtrim(reparticion.rep_nombre)) 			as rep_nombre,
		ltrim(rtrim(EDIFICIOS_UBB.edu_descripcion)) 	as edu_descripcionas,
		OFICINA_REPARTICION.ofre_codigo as ofre_codigo,
		OFICINA_REPARTICION.cco_codigo 	as cco_codigo,
		OFICINA_REPARTICION.rep_codigo 	as rep_codigo,
		OFICINA_REPARTICION.edu_codigo 	as edu_codigo
from	DOCUMENTOS_UBB.dbo.OFICINA_REPARTICION 						as OFICINA_REPARTICION 	with(nolock)
join 	DOCUMENTOS_UBB.dbo.USUARIOS_OFICINA 					as USUARIOS_OFICINA 	with(nolock) 
		on  		USUARIOS_OFICINA.ofre_codigo			=	OFICINA_REPARTICION.ofre_codigo
		and 		USUARIOS_OFICINA.cco_codigo			= 	OFICINA_REPARTICION.cco_codigo
		and			USUARIOS_OFICINA.rep_codigo			= 	OFICINA_REPARTICION.rep_codigo
		and 		USUARIOS_OFICINA.edu_codigo 			= 	OFICINA_REPARTICION.edu_codigo 

join 	CREDITOTEST.DBO.CONTRATO 			as CONTRATO 	with(nolock) 	
		on  USUARIOS_OFICINA.mae_rut			= 	CONTRATO.mae_rut

join	 CREDITOTEST.dbo.maeper 				as maeper 	with(nolock)  	
		on maeper.mae_rut			=	CONTRATO.mae_rut 	

join 	Vrae.dbo.reparticion 							as reparticion 	with(nolock)		
		on  reparticion.rep_codigo 	= OFICINA_REPARTICION.rep_codigo

join 	Academia.dbo.EDIFICIOS_UBB 		  	as EDIFICIOS_UBB 	with(nolock) 
		on EDIFICIOS_UBB.edu_codigo		= OFICINA_REPARTICION.edu_codigo
	
WHERE (CONTRATO.cnt_fecha_termino >= CONVERT(DATE,GETDATE()) OR CONTRATO.cnt_fecha_termino IS NULL)
	and		USUARIOS_OFICINA.mae_rut = :mae_rut
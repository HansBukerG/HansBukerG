select  *	
from			DOCUMENTOS_UBB.dbo.modulos_atencion 		as modulos_atencion 	with(nolock)
join 			DOCUMENTOS_UBB.dbo.oficina_reparticion 		as oficina_reparticion 	with(nolock) 
	on  		oficina_reparticion.ofre_codigo		=		modulos_atencion.ofre_codigo
	and 		oficina_reparticion.cco_codigo		= 		modulos_atencion.cco_codigo
	and			oficina_reparticion.rep_codigo		= 		modulos_atencion.rep_codigo
	and 		oficina_reparticion.edu_codigo 		= 		modulos_atencion.edu_codigo
join 	Vrae.dbo.reparticion 								as reparticion 	with(nolock)		
		on  	reparticion.rep_codigo				=	 	oficina_reparticion.rep_codigo

join 	Academia.dbo.EDIFICIOS_UBB 		  	as EDIFICIOS_UBB 	with(nolock) 
		on EDIFICIOS_UBB.edu_codigo					=		oficina_reparticion.edu_codigo


select *
from DOCUMENTOS_UBB.dbo.modulos_atencion
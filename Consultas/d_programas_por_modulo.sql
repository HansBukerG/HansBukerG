select 	ltrim(rtrim(programa.tpr_descripcion)) 	as tpr_descripcion
,		programa.TPR_CORRELATIVO 	as TPR_CORRELATIVO

from  Documentos_ubb.dbo.MODULO_ATIENDE as atiende with(nolock)

join Academia.dbo.tipo_programa as programa with(nolock)
on	programa.TPR_CORRELATIVO = atiende.TPR_CORRELATIVO

join documentos_ubb.dbo.modulos_atencion as modulos with (nolock)
on atiende.mod_codigo 	= modulos.mod_codigo
and atiende.MOD_CODIGO 	= modulos.MOD_CODIGO
and atiende.OFRE_CODIGO	= modulos.OFRE_CODIGO
and atiende.REP_CODIGO 	= modulos.REP_CODIGO
and atiende.EDU_CODIGO 	= modulos.EDU_CODIGO

where 		atiende.MOD_CODIGO		=:MOD_CODIGO
and 			atiende.OFRE_CODIGO =:OFRE_CODIGO
and 			atiende.REP_CODIGO 	=:REP_CODIGO
and 			atiende.EDU_CODIGO 	=:EDU_CODIGO

order by 2
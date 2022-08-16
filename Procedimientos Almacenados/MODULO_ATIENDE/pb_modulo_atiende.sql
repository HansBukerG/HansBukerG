/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 05-07-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores
	
	
	@-Parametro_Entrada0: ofre_codigo
	@-Parametro_Entrada1: rep_codigo
	@-Parametro_Entrada2: edu_codigo
	@-Parametro_Entrada3: MOD_CODIGO

	@-Descripcion_Objeto0: Realiza una consulta a la tabla tipo_programa comparando con datos existentes en la oficina
	@-Regla_Objeto0: Debe existir un modulo creado para poder asigar un tipo de programa
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modulo_atiende_agregar;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter procedure dbo.pb_MODULO_ATIENDE
(
	@ofre_codigo	int
	,@rep_codigo	int
	,@edu_codigo	int
	,@MOD_CODIGO	int
)

as 

select	ltrim(rtrim(tipo_programa.tpr_descripcion)) as tpr_descripcion
,		ltrim(rtrim(tipo_programa.tpr_nemonico)) as tpr_nemonico
,		tipo_programa.tpr_correlativo

from Academia.dbo.tipo_programa as tipo_programa

where tipo_programa.tpr_correlativo not in 
(
	select 	atiende.tpr_correlativo

	from 	documentos_ubb.dbo.MODULO_ATIENDE as atiende with(nolock)

	where 	atiende.ofre_codigo = @ofre_codigo
	and 	atiende.rep_codigo 	= @rep_codigo
	and 	atiende.edu_codigo 	= @edu_codigo
	and 	atiende.MOD_CODIGO 	= @MOD_CODIGO
)

order by 3
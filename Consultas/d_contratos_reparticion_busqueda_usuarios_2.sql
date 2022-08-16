create proc dbo.pb_buscar_usuarios_oficina
(
	@OFRE_CODIGO 	int,
	@cco_codigo 	decimal,
	@REP_CODIGO decimal,
	@EDU_CODIGO int
)
as
SELECT
	t3.mae_rut 								as mae_rut,
	t3.rep_codigo 							as rep_codigo,
	t6.EDU_CODIGO 							as edu_codigo,
	t1.ofre_codigo 							as ofre_codigo,
	t4.mae_nombre 				as mae_nombre,
	t4.mae_apellido_paterno 		as mae_apellido_paterno,
	t4.mae_apellido_materno 		as mae_apellido_materno,
	t5.rep_nombre 			as rep_nombre, 
	t6.EDU_DESCRIPCION 		as EDU_DESCRIPCIPCION
FROM
	DOCUMENTOS_UBB.dbo.OFICINA_REPARTICION 		as t1 with(nolock)
	join DOCUMENTOS_UBB.dbo.USUARIOS_OFICINA 		as t2 		with(nolock) 
	on  		t2.ofre_codigo	=	t1.ofre_codigo
	and 		t2.cco_codigo		= 	t1.cco_codigo
	and			t2.rep_codigo		= 	t1.rep_codigo
	and 		t2.edu_codigo 	= 	t1.edu_codigo
	join 		CREDITOTEST.DBO.CONTRATO 					as t3 	with(nolock) 	on  t2.mae_rut			= 	t3.mae_rut
	join	 	CREDITOTEST.dbo.maeper 							as t4 		with(nolock)  	on t4.mae_rut			=	t3.mae_rut 	
	join 		Vrae.dbo.reparticion 									as t5 	with(nolock)		on  t5.rep_codigo 	= t1.rep_codigo
	join 		Academia.dbo.EDIFICIOS_UBB 		  			as t6 		with(nolock) on t6.edu_codigo		= t1.edu_codigo
	WHERE (t3.cnt_fecha_termino >= CONVERT(DATE,GETDATE()) OR t3.cnt_fecha_termino IS NULL)
	and		t2.ofre_codigo	=	@ofre_codigo
	and		t2.cco_codigo		=	@cco_codigo
	and   	t2.rep_codigo		=	@rep_codigo
	and   	t2.edu_codigo 	=	@EDU_CODIGO
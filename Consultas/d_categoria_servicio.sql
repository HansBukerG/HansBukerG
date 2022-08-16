create table DBO.CATEGORIA_SERVICIO 
(	
	CATE_CODIGO          integer                        not null,
	OFRE_CODIGO          integer                        not null,
	CCO_CODIGO           decimal                        not null,
	REP_CODIGO           decimal                        not null,
	EDU_CODIGO           integer                        not null,
	CATE_NOMBRE          varchar(250)                   null,
	CATE_FECHA_INICIO    datetime                       null,
	CATE_FECHA_TERMINO   datetime                       null,
	CATE_FECHA_REGISTRO  datetime                       null,
	CATE_LOG_REGISTRO    varchar(250)                   null,
	primary key clustered (CATE_CODIGO, OFRE_CODIGO, CCO_CODIGO, REP_CODIGO, EDU_CODIGO)
);


select 	categoria.CATE_CODIGO,
		categoria.OFRE_CODIGO,
		categoria.CCO_CODIGO,
		categoria.REP_CODIGO,
		categoria.EDU_CODIGO,
		categoria.CATE_NOMBRE,
		categoria.CATE_FECHA_REGISTRO,
		categoria.CATE_LOG_REGISTRO,
		reparticion.rep_nombre,
		edificios.edu_descripcion
from documentos_ubb.DBO.CATEGORIA_SERVICIO	as categoria with(nolock)
join documentos_ubb.dbo.oficina_reparticion as oficina with(nolock)
on 		categoria.OFRE_CODIGO 	= oficina.OFRE_CODIGO
and		categoria.CCO_CODIGO 	= oficina.CCO_CODIGO
and		categoria.REP_CODIGO 	= oficina.REP_CODIGO
and		categoria.EDU_CODIGO 	= oficina.EDU_CODIGO
join Vrae.dbo.reparticion as reparticion with(nolock)
on 		oficina.cco_codigo 		= reparticion.cco_codigo
and 	oficina.rep_codigo 		= reparticion.rep_codigo
join Academia.dbo.Edificios_ubb as edificios with(nolock)
on 		oficina.edu_codigo 		= edificios.edu_Codigo

//Esta parte esta integrada en el pb

select 	ltrim(rtrim(categoria.CATE_NOMBRE)) as CATE_NOMBRE,
		ltrim(rtrim(reparticion.rep_nombre)) as rep_nombre,
		ltrim(rtrim(edificios.edu_descripcion)) as edu_descripcion,
		categoria.CATE_CODIGO as CATE_CODIGO,
		categoria.OFRE_CODIGO as OFRE_CODIGO,
		categoria.CCO_CODIGO as cco_codigo,
		categoria.REP_CODIGO as rep_codigo,
		categoria.EDU_CODIGO as EDU_CODIGO,
		categoria.CATE_FECHA_REGISTRO as CATE_FECHA_REGISTRO,
		ltrim(rtrim(categoria.CATE_LOG_REGISTRO)) as CATE_LOG_REGISTRO
from documentos_ubb.DBO.CATEGORIA_SERVICIO	as categoria with(nolock)
join documentos_ubb.dbo.oficina_reparticion as oficina with(nolock)
on 		categoria.OFRE_CODIGO 	= oficina.OFRE_CODIGO
and		categoria.CCO_CODIGO 	= oficina.CCO_CODIGO
and		categoria.REP_CODIGO 	= oficina.REP_CODIGO
and		categoria.EDU_CODIGO 	= oficina.EDU_CODIGO
join Vrae.dbo.reparticion as reparticion with(nolock)
on 		oficina.cco_codigo 		= reparticion.cco_codigo
and 	oficina.rep_codigo 		= reparticion.rep_codigo
join Academia.dbo.Edificios_ubb as edificios with(nolock)
on 		oficina.edu_codigo 		= edificios.edu_Codigo
where 	categoria.OFRE_CODIGO = :OFRE_CODIGO
and 	(categoria.CATE_FECHA_TERMINO >= CONVERT(DATE,GETDATE()) OR categoria.CATE_FECHA_TERMINO IS NULL)
and		categoria.CCO_CODIGO = :CCO_CODIGO
and		categoria.REP_CODIGO = :REP_CODIGO
and		categoria.EDU_CODIGO = :EDU_CODIGO
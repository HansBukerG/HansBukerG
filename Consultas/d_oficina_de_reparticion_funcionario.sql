create table DBO.USUARIOS_OFICINA 
(
   MAE_RUT              decimal                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   USOF_CODIGO          integer                        not null,
   USOF_FECHA_INICIO    datetime                           null,
   USOF_FECHA_TERMINO   datetime                           null,
   USOF_FECHA_REGISTRO  datetime                       null,
   USOF_LOG_REGISTRO    varchar(250)                   null,
   constraint PK_DBO_USUARIOS_OFICINA primary key clustered (USOF_CODIGO,EDU_CODIGO,REP_CODIGO,CCO_CODIGO,OFRE_CODIGO)
);

SELECT  
		distinct
		ltrim(rtrim(edificios.nombre)) as EDU_DESCRIPCION
,		ltrim(rtrim(reparticion.rep_nombre)) as rep_nombre
,       ltrim(rtrim(oficina.OFRE_NOMBRE_OFICINA)) as OFRE_NOMBRE_OFICINA
,		ltrim(rtrim(oficina.OFRE_ABREVIACION)) as OFRE_ABREVIACION
,		oficina.OFRE_FECHA_INICIO  as OFRE_FECHA_INICIO
,		oficina.OFRE_FECHA_TERMINO as OFRE_FECHA_TERMINO
,		oficina.CCO_CODIGO         as CCO_CODIGO
,		oficina.REP_CODIGO         as REP_CODIGO
,		oficina.EDU_CODIGO         as EDU_CODIGO
,		oficina.OFRE_CODIGO     as OFRE_CODIGO
,		oficina.OFRE_FECHA_REGISTRO as OFRE_FECHA_REGISTRO
,		oficina.OFRE_LOG_REGISTRO  as OFRE_LOG_REGISTRO
,		edificios.campus_id       as cmp_codigo
,		ubica = 0
FROM  DOCUMENTOS_UBB.dbo.oficina_reparticion as oficina with(nolock)
join  SALAS.[dbo].[edificios] as edificios   with(nolock)
on    oficina.EDU_CODIGO = edificios.id
join  creditotest.dbo.contrato as contrato with (nolock)
on		oficina.rep_codigo = contrato.rep_codigo
and		(contrato.cnt_fecha_termino >= CONVERT(DATE,GETDATE()) OR contrato.cnt_fecha_termino IS NULL)
join  vrae.dbo.reparticion as reparticion with(nolock)
on    reparticion.rep_codigo= oficina.rep_codigo
and      reparticion.cco_codigo= oficina.cco_codigo
join DOCUMENTOS_UBB.dbo.USUARIOS_OFICINA as usuarios with(nolock)
on 		usuarios.mae_rut=contrato.mae_rut
and		usuarios.OFRE_CODIGO = oficina.OFRE_CODIGO
and		usuarios.CCO_CODIGO = oficina.CCO_CODIGO
and		usuarios.REP_CODIGO = oficina.REP_CODIGO
and		usuarios.EDU_CODIGO = oficina.EDU_CODIGO
and 	(usuarios.USOF_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR usuarios.USOF_FECHA_TERMINO IS NULL)
where    (oficina.OFRE_FECHA_TERMINO >= CONVERT(DATETIME,GETDATE()) OR oficina.OFRE_FECHA_TERMINO IS NULL)
and      edificios.campus_id  	=:sede
and      oficina.rep_codigo   	=:rep_codigo
and      contrato.mae_rut 		=:rut
order by EDU_DESCRIPCION
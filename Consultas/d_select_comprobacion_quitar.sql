select isnull(max(OFICINA_DEFINE_MODALIDAD.MODA_CODIGO),0)+0
from DOCUMENTOS_UBB.dbo.MODALIDAD_ATENCION_OFICINA 	as  MODALIDAD_ATENCION_OFICINA with (nolock)
join  DOCUMENTOS_UBB.DBO.OFICINA_DEFINE_MODALIDAD 	as  OFICINA_DEFINE_MODALIDAD with(nolock)
on MODALIDAD_ATENCION_OFICINA.MODA_CODIGO = OFICINA_DEFINE_MODALIDAD.MODA_CODIGO
where OFICINA_DEFINE_MODALIDAD.MODA_CODIGO =:moda_codigo_global
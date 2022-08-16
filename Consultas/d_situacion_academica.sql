select 	ltrim(rtrim(situacion.saa_descripcion)) as saa_descripcion
,		situacion.saa_codigo as saa_codigo
from academia.dbo.situacion_academica as situacion with(nolock)
order by 1
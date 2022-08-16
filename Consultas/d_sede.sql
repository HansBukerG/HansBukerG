select id as cmp_codigo
, rtrim(ltrim(nombre)) as cmp_nombre
, ubica = 0
from salas.dbo.campus CMP with (nolock)

order by 2
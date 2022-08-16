select id as EDU_CODIGO
, rtrim(ltrim(nombre)) as EDU_DESCRIPCION
, ubica = 0
from SALAS.[dbo].[edificios] as edificios with(nolock)
where nombre like '%'+:edificio+'%'
select 	contrato.cnt_fecha_termino as cnt_fecha_termino
from 		CREDITOTEST.dbo.maeper 	as maeper 
join 		CREDITOTEST.DBO.CONTRATO as contrato 
on 		maeper.mae_rut = contrato.mae_rut
where 	(contrato.cnt_fecha_termino >= CONVERT(DATE,GETDATE()) OR contrato.cnt_fecha_termino IS NULL)
and 	maeper.mae_rut =:mae_rut_global
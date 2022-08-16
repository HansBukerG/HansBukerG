SELECT 	ltrim(rtrim(contratos.mae_rut)) as mae_rut,ltrim(rtrim(contratos.rep_codigo))as rep_codigo,ltrim(rtrim(maeper.mae_nombre)) as mae_nombre,ltrim(rtrim(maeper.mae_apellido_paterno)) as mae_apellido_paterno,ltrim(rtrim(maeper.mae_apellido_materno)) as mae_apellido_materno
FROM 	CREDITOTEST.DBO.CONTRATO as contratos,Creditotest.dbo.maeper as maeper with(nolock)
WHERE (contratos.cnt_fecha_termino >= CONVERT(DATE,GETDATE()) OR contratos.cnt_fecha_termino IS NULL)
and		contratos.mae_rut=maeper.mae_rut
and  		rep_codigo =:codigo

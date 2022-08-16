SELECT 	
	contratos.mae_rut as mae_rut,
	contratos.rep_codigo as rep_codigo,
	ltrim(rtrim(maeper.mae_nombre)) as mae_nombre,
	ltrim(rtrim(maeper.mae_apellido_paterno)) as mae_apellido_paterno,
	ltrim(rtrim(maeper.mae_apellido_materno)) as mae_apellido_materno
FROM 	CREDITOTEST.DBO.CONTRATO as contratos,CREDITOTEST.dbo.maeper as maeper with(nolock)
WHERE (contratos.cnt_fecha_termino >= CONVERT(DATE,GETDATE()) OR contratos.cnt_fecha_termino IS NULL)
and		contratos.mae_rut=maeper.mae_rut
and  		maeper.mae_rut =:mae_rut



dw_usuario


long ill_fila_2
long mae_rut
string mae_nombre
string mae_apellido_paterno
string mae_apellido_materno


ill_fila_2 = dw_usuario.find("mae_rut="+string(gl_rut),1,dw_usuario.rowcount())

mae_nombre		 		= string(dw_usuario.getitemstring(ill_fila_2,"mae_apellido_paterno"))
mae_apellido_paterno	= string(dw_usuario.getitemstring(ill_fila_2,"mae_apellido_paterno"))
mae_apellido_materno	= string(dw_usuario.getitemstring(ill_fila_2,"mae_apellido_materno"))
st_log_usuario.text = "Rut: "+mae_rut+" "+mae_nombre+" "+mae_apellido_paterno+" "+mae_apellido_materno
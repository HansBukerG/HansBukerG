create proc dbo.pb_quitar_admin
(
   @AOR_CORRELATIVO      integer,
   @MAE_RUT              decimal,
   @REP_CODIGO           decimal
) as
delete from DOCUMENTOS_UBB.dbo.ADMIN_OFICINA_REPARTICION
with(updlock)
where 	@AOR_CORRELATIVO	=   AOR_CORRELATIVO
and 	@MAE_RUT			=   MAE_RUT
and   	@REP_CODIGO			=   REP_CODIGO

	admin_rut_global 	=  		dw_administradores.GetItemDecimal(li_fila_administrador,"MAE_RUT")
	rep_admin_global =		dw_administradores.getitemdecimal(li_fila_administrador,"REP_CODIGO")
	aor_correlativo_global = dw_administradores.GetItemDecimal(li_fila_administrador,"AOR_CORRELATIVO")
	bandera_admin_global = 1


string ls_error

if bandera_admin_global = 0 then
	messagebox("error","Debes seleccionar un usuario para quitar", stopsign!)
	return
end if

	declare pb_quitar_admin procedure for DOCUMENTOS_UBB.dbo.pb_quitar_admin
		@AOR_CORRELATIVO	= :AOR_CORRELATIVO,
		@MAE_RUT 		= :MAE_RUT,
		@REP_CODIGO 	= :REP_CODIGO;
			
			
//		if sqlca.sqlcode < 0 then
//			ls_error = sqlca.sqlerrtext;
//			close pb_quitar_admin;
//			messagebox("error","error en sintaxis: "+ls_error, stopsign!)
//			return
//		end if
			
		execute pb_quitar_admin;
		if sqlca.sqlcode < 0 then
				ls_error = sqlca.sqlerrtext;
				close pb_quitar_admin;
				admin_rut_global 		=  		0
				rep_admin_global 		=		0
				aor_correlativo_global 	= 		0
				bandera_admin_global 	= 		0
				messagebox("error","error en sp: "+ls_error, stopsign!)
				return
		end if
			//Aqui se muestra en la datawindow la lista de elementos existentes en la tabla oficina_reparticion
			
			close pb_quitar_admin;
			admin_rut_global 		=  		0
			rep_admin_global 		=		0
			aor_correlativo_global 	= 		0
			bandera_admin_global 	= 		0
			dw_usuarios_en_oficina.retrieve(0)
			messagebox("Dato quitado","El dato fue quitado con exito")
		return

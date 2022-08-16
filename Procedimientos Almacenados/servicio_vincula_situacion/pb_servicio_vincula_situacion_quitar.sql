/**INICIO_DATOS_PROCEDIMIENTO 
   
   @-autor0: Hans Buker Gutiérrez
   @-Fecha_Creacion0: 25-06-2018
   @-modificado_por0: 
   @-Fecha_Modificacion0: 
   @-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
   
   @-Parametro_Entrada0: SERV_CODIGO
   @-Parametro_Entrada1: CATE_CODIGO
   @-Parametro_Entrada2: OFRE_CODIGO
   @-Parametro_Entrada3: CCO_CODIGO
   @-Parametro_Entrada4: REP_CODIGO
   @-Parametro_Entrada5: EDU_CODIGO
   @-Parametro_Entrada6: SVS_CODIGO
   @-Parametro_Entrada7: SAA_CODIGO

   @-Descripcion_Objeto0: SP encargado de desvincular una situacion academica a un servicio
   @-Regla_Objeto0: Debe existir una un servicio vinculado primero para poderlo quitar
   @-String_Prueba0: EXEC Documentos_ubb.dbo.pb_servicio_vincula_situacion_quitar;

FIN_DATOS_PROCEDIMIENTO**/ 
   
alter proc dbo.pb_servicio_vincula_situacion_quitar
(
	@SERV_CODIGO         integer
,	@CATE_CODIGO         integer
,	@OFRE_CODIGO         integer
,	@CCO_CODIGO          decimal
,	@REP_CODIGO          decimal
,	@EDU_CODIGO          integer
,	@SVS_CODIGO          integer
,	@SAA_CODIGO 		integer
) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;


delete from DOCUMENTOS_UBB.dbo.servicio_vincula_situacion
with(updlock)
where	SERV_CODIGO = @SERV_CODIGO
and		CATE_CODIGO = @CATE_CODIGO
and		OFRE_CODIGO = @OFRE_CODIGO
and		CCO_CODIGO = @CCO_CODIGO
and		REP_CODIGO = @REP_CODIGO
and		EDU_CODIGO = @EDU_CODIGO
and		SVS_CODIGO = @SVS_CODIGO
and		SAA_CODIGO = @SAA_CODIGO

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
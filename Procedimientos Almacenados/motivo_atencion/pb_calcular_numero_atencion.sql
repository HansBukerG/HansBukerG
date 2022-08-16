/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
	
	@-Parametro_Entrada0: anno
	@-Parametro_Entrada1: ofre_codigo
	@-Parametro_Entrada2: rep_codigo
	@-Parametro_Entrada3: edu_codigo
	@-Parametro_Entrada4: cate_codigo
	@-Parametro_Entrada5: serv_codigo
	@-Parametro_Entrada6: tpr_referencia
	@-Parametro_Entrada7: fecha

	@-Parametro_Salida0: correlativo

	@-Descripcion_Objeto0: Calcula el numero de atencion de la persona que ingresa rut en el totem de atenciòn
	@-Regla_Objeto0: El usuario debe haber ingresado su rut primero
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_calcular_numero_atencion;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_calcular_numero_atencion
(
		@anno			integer
	,	@ofre_codigo	integer
	,	@rep_codigo		decimal
	,	@edu_codigo		integer
	,	@cate_codigo	integer
	,	@serv_codigo	integer
	,	@tpr_referencia	integer
	,	@fecha			date
)
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	declare @numero_atencion table
	(
			correlativo integer
	)

	insert into @numero_atencion
	(
			correlativo
	)

	select	isnull(max(motivo.MOAT_CODIGO),0)+1
	from	DOCUMENTOS_UBB.dbo.MOTIVO_ATENCION as motivo with (nolock)
	where   motivo.FILA_YEAR							=  @anno
	and     motivo.OFRE_CODIGO							=  @ofre_codigo
	and     motivo.REP_CODIGO							=  @rep_codigo
	and     motivo.EDU_CODIGO							=  @edu_codigo
	and     motivo.CATE_CODIGO							=  @cate_codigo
	and     motivo.SERV_CODIGO							=  @serv_codigo
	and     motivo.tpr_referencia						=  @tpr_referencia
	and		convert(date,motivo.MOAT_FECHA_REGISTRO)	=  @fecha;

	select	correlativo
	from	@numero_atencion

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
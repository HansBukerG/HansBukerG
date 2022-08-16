/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: Hans Buker Gutiérrez
	@-Fecha_Modificacion0: 29-06-2018 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
	
	
	@-Parametro_Entrada0: MOAT_CODIGO
	@-Parametro_Entrada1: FILA_YEAR
	@-Parametro_Entrada2: FILA_CODIGO
	@-Parametro_Entrada3: OFRE_CODIGO
	@-Parametro_Entrada4: REP_CODIGO
	@-Parametro_Entrada5: EDU_CODIGO
	@-Parametro_Entrada6: ESTAD_CODIGO

	@-Descripcion_Objeto0: Modifica el estado de una atención dependiendo de la situación de esta
	@-Regla_Objeto0: Es necesario tener una atencion en espera para poder ir cambiando sus estados
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_modificar_motivo_atencion;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_modificar_motivo_atencion
(
		@MOAT_CODIGO          			integer
   ,	@FILA_YEAR            			integer
   ,	@FILA_CODIGO          			integer
   , 	@OFRE_CODIGO          			integer
   ,	@REP_CODIGO           			decimal
   ,	@EDU_CODIGO           			integer
   ,	@ESTAD_CODIGO         			integer
   ,	@MOAT_FECHA_INICIO              datetime
   ,	@MOAT_FECHA_TERMINO             datetime
   ,	@MOAT_FECHA_PAUSA_ACUMULATIVO   datetime
   ,	@origen							integer
) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	UPDATE DOCUMENTOS_UBB.dbo.MOTIVO_ATENCION 
	with(updlock)
	set		ESTAD_CODIGO					= @ESTAD_CODIGO
	WHERE   MOAT_CODIGO						= @MOAT_CODIGO
	and     FILA_YEAR						= @FILA_YEAR
	and     FILA_CODIGO						= @FILA_CODIGO
	and     OFRE_CODIGO						= @OFRE_CODIGO
	and     REP_CODIGO						= @REP_CODIGO
	and     EDU_CODIGO						= @EDU_CODIGO

--Atencion entrante

if @origen = 2
begin
	UPDATE DOCUMENTOS_UBB.dbo.MOTIVO_ATENCION 
	with(updlock)
	set		MOAT_FECHA_INICIO				= @MOAT_FECHA_INICIO
	WHERE   MOAT_CODIGO						= @MOAT_CODIGO
	and     FILA_YEAR						= @FILA_YEAR
	and     FILA_CODIGO						= @FILA_CODIGO
	and     OFRE_CODIGO						= @OFRE_CODIGO
	and     REP_CODIGO						= @REP_CODIGO
	and     EDU_CODIGO						= @EDU_CODIGO
	
END

--Atencion Finalizada

if @origen = 3
begin
	UPDATE DOCUMENTOS_UBB.dbo.MOTIVO_ATENCION 
	with(updlock)
	set		MOAT_FECHA_TERMINO		= @MOAT_FECHA_TERMINO
	WHERE   MOAT_CODIGO				= @MOAT_CODIGO
	and     FILA_YEAR				= @FILA_YEAR
	and     FILA_CODIGO				= @FILA_CODIGO
	and     OFRE_CODIGO				= @OFRE_CODIGO
	and     REP_CODIGO				= @REP_CODIGO
	and     EDU_CODIGO				= @EDU_CODIGO
END

--Atencion Pausada
/*
if @origen = 5
begin
declare @fecha_inicio datetime

	UPDATE DOCUMENTOS_UBB.dbo.MOTIVO_ATENCION 
	with(updlock)
	set		MOAT_FECHA_PAUSA_ACUMULATIVO		= @MOAT_FECHA_PAUSA_ACUMULATIVO
	WHERE   MOAT_CODIGO						= @MOAT_CODIGO
	and     FILA_YEAR						= @FILA_YEAR
	and     FILA_CODIGO						= @FILA_CODIGO
	and     OFRE_CODIGO						= @OFRE_CODIGO
	and     REP_CODIGO						= @REP_CODIGO
	and     EDU_CODIGO						= @EDU_CODIGO
	
END
*/

----Atencion Reanudada
if @origen = 7
begin
	declare @fecha_pausa datetime, @fecha_reanudada datetime

	select @fecha_pausa = a.ATAS_FECHA_REGISTRO
	from ATENCION_ASIGNADA a
	WHERE   a.MOAT_CODIGO						= @MOAT_CODIGO
		and     a.FILA_YEAR						= @FILA_YEAR
		and     a.FILA_CODIGO					= @FILA_CODIGO
		and     a.OFRE_CODIGO					= @OFRE_CODIGO
		and     a.REP_CODIGO					= @REP_CODIGO
		and     a.EDU_CODIGO					= @EDU_CODIGO
		and		a.atas_correlativo			= (select max(atas_correlativo)
												from ATENCION_ASIGNADA a2
												where a2.MOAT_CODIGO						= a.MOAT_CODIGO
													and     a2.FILA_YEAR					= a.FILA_YEAR
													and     a2.FILA_CODIGO					= a.FILA_CODIGO
													and     a2.OFRE_CODIGO					= a.OFRE_CODIGO
													and     a2.REP_CODIGO					= a.REP_CODIGO
													and     a2.EDU_CODIGO					= a.EDU_CODIGO
													and		a2.ESTAD_CODIGO					= 5)

	select @fecha_reanudada = a.ATAS_FECHA_REGISTRO
	from ATENCION_ASIGNADA a
	WHERE   a.MOAT_CODIGO						= @MOAT_CODIGO
		and     a.FILA_YEAR						= @FILA_YEAR
		and     a.FILA_CODIGO					= @FILA_CODIGO
		and     a.OFRE_CODIGO					= @OFRE_CODIGO
		and     a.REP_CODIGO					= @REP_CODIGO
		and     a.EDU_CODIGO					= @EDU_CODIGO
		and		a.atas_correlativo			= (select max(atas_correlativo)
												from ATENCION_ASIGNADA a2
												where a2.MOAT_CODIGO						= a.MOAT_CODIGO
													and     a2.FILA_YEAR					= a.FILA_YEAR
													and     a2.FILA_CODIGO					= a.FILA_CODIGO
													and     a2.OFRE_CODIGO					= a.OFRE_CODIGO
													and     a2.REP_CODIGO					= a.REP_CODIGO
													and     a2.EDU_CODIGO					= a.EDU_CODIGO
													and		a2.ESTAD_CODIGO					= 7)

	UPDATE DOCUMENTOS_UBB.dbo.MOTIVO_ATENCION 
	with(updlock)
	set		MOAT_FECHA_PAUSA_ACUMULATIVO	= cast(dateadd(MS, datediff(MS, @fecha_pausa, @fecha_reanudada), '00:00:00') as time)
	WHERE   MOAT_CODIGO						= @MOAT_CODIGO
	and     FILA_YEAR						= @FILA_YEAR
	and     FILA_CODIGO						= @FILA_CODIGO
	and     OFRE_CODIGO						= @OFRE_CODIGO
	and     REP_CODIGO						= @REP_CODIGO
	and     EDU_CODIGO						= @EDU_CODIGO
END

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
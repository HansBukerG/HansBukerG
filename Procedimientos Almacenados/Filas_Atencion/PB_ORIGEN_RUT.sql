
/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, proceso_control_de_turnos,Totem_marcha_blanca, cb_ingresar(boton)
	
	
	@-Parametro_Entrada0: rut

	@-Parametro_Salida0: 0
	@-Parametro_Salida1: 1
	@-Parametro_Salida2: 2

	@-Descripcion_Objeto0: sp para identificar el origen del rut ingresado
	@-Regla_Objeto0: se debe ingresar un rut previamente para poder ser utilizado
	@-String_Prueba0: EXEC Documentos_ubb.dbo.PB_ORIGEN_RUT 18389381;
	
FIN_DATOS_PROCEDIMIENTO**/	



CREATE PROC DBO.PB_ORIGEN_RUT
(
 @rut INT
)
 AS


--SELECT @rut = 17221208--8872338--18389381
IF @rut IS NULL
BEGIN
	SELECT -1
	RETURN
END

IF (SELECT COUNT(1)
	FROM ACADEMIA.DBO.ALUMNO with(nolock)
	WHERE alu_rut = @rut) > 0
BEGIN
	SELECT 0 AS origen --ALUMNO
	RETURN
END


IF (SELECT COUNT(1)
	FROM CREDITOTEST.DBO.MAEPER MAE with(nolock)
	JOIN CREDITOTEST.DBO.CONTRATO CNT with(nolock) ON CNT.mae_rut = MAE.mae_rut
	AND (CNT.cnt_fecha_termino >= CAST(GETDATE() AS DATE) OR CNT.cnt_fecha_termino IS NULL)
	WHERE MAE.mae_rut = @rut) > 0
BEGIN
	SELECT 1 AS origen --MAEPER
	RETURN
END


IF (SELECT COUNT(1)
	FROM CREDITOTEST.DBO.MAEPER MAE with(nolock)
	JOIN CREDITOTEST.DBO.CONVENIO CNT with(nolock) ON CNT.mae_rut = MAE.mae_rut
	AND (CNT.cnv_fecha_termino >= CAST(GETDATE() AS DATE) OR CNT.cnv_fecha_termino IS NULL)
	WHERE MAE.mae_rut = @rut) > 0
BEGIN
	SELECT 1 AS origen--MAEPER
	RETURN
END

SELECT 2 AS origen--EXTERNO UBB

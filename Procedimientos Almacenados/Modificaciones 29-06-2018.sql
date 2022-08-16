--Modificaciones al 26/07/2018
--DOCUMENTOS_UBB
-- Tabla Motivo_atencion columnas a insertar

ALTER TABLE dbo.MOTIVO_ATENCION 
ADD   pca_codigo                       integer                       null
,     crr_codigo                       integer                       null
,     alc_ano_ingreso                  integer                       null
,     alc_periodo                      integer                       null

-- SP a modificar

dbo.pb_ingresar_motivo_atencion

dbo.PB_Registro_detallado
dbo.pb_atenciones_por_tipo_programa
dbo.pb_atenciones_por_situacion_académica
dbo.pb_atenciones_por_servicio
dbo.pb_atenciones_por_promedio_tiempo_atencion
dbo.pb_atenciones_por_promedio_espera
dbo.pb_atenciones_por_mes
dbo.pb_atenciones_por_funcionario
dbo.pb_atenciones_por_dia
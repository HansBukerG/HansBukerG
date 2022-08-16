--BD Documentos_ubb

-- Tablas

dbo.ATENCION_ASIGNADA
dbo.CATEGORIA_SERVICIO
dbo.ENGLOBAN_PROGRAMAS
dbo.ESTADO_ATENCION
dbo.FILAS_ATENCION
dbo.MODULO_ATIENDE
dbo.MODULO_ATIENDE_CIVIL
dbo.MODULO_ATIENDE_MAEPER
dbo.MODULOS_ASIGNADOS
dbo.MODULOS_ATENCION
dbo.MOTIVO_ATENCION
dbo.OFICINA_IP_PUERTO
dbo.OFICINA_REPARTICION
dbo.PARAMETROS_ATENCION_PUBLICO
dbo.SERVICIO_MAEPER
dbo.SERVICIO_PERSONA_DESCONOCIDA
dbo.servicio_vincula_situacion
dbo.SERVICIOS_REPARTICION
dbo.SERVICIOS_SE_ASIGNAN
dbo.USUARIOS_OFICINA


--Procedimientos Almacenados

dbo.pb_asignar_atención.
dbo.pb_modificar_atencion_asignada
dbo.pb_modificar_categoria
dbo.pb_insertar_nueva_categoria
dbo.pb_quitar_categoria
dbo.pb_desvincular_programa
dbo.pb_ligar_programa
dbo.pb_eliminar_fila_atencion
dbo.pb_insertar_fila_atencion
dbo.PB_ORIGEN_RUT
dbo.pb_verificar_alumno
dbo.pb_fila_pausa
dbo.pb_fila_por_modulo
dbo.pb_fila_unica_2
dbo.pb_modulo_atiende_agregar
dbo.pb_modulo_atiende_quitar
dbo.pb_modulo_atiende_civil_agregar
dbo.pb_modulo_atiende_civil_quitar
dbo.pb_modulo_atiende_maeper_agregar
dbo.pb_modulo_atiende_maeper_quitar
dbo.pb_activar_modulo
dbo.pb_modificar_asignacion_usuario
dbo.sp_insertar_nuevo_modulo
dbo.pb_modificar_modulo
dbo.pb_quitar_Modulo_atencion
dbo.pb_calcular_numero_atencion
dbo.pb_ingresar_motivo_atencion
dbo.pb_modificar_motivo_atencion
dbo.pb_ingresar_nueva_ip
dbo.pb_insertar_oficina_reparticion
dbo.pb_modificar_oficina_reparticion
dbo.quitar_oficina_reparticion
dbo.pb_atenciones_por_dia
dbo.pb_atenciones_por_funcionario
dbo.pb_atenciones_por_mes
dbo.pb_atenciones_por_promedio_espera
dbo.pb_atenciones_por_promedio_tiempo_atencion
dbo.pb_atenciones_por_servicio
dbo.pb_atenciones_por_situacion_académica
dbo.pb_atenciones_por_tipo_programa
dbo.PB_Registro_detallado
dbo.pb_eliminar_servicio_maeper
dbo.pb_insertar_servicio_maeper
dbo.pb_eliminar_servicio_persona_desconocida
dbo.pb_insertar_servicio_persona_desconocida
dbo.pb_servicio_vincula_situacion_agregar
dbo.pb_servicio_vincula_situacion_quitar
dbo.pb_insertar_nuevo_servicio
dbo.pb_modificar_servicio
dbo.pb_quitar_servicio
dbo.PB_SERVICIOS_SE_ASIGNAN_AGREGAR
dbo.PB_SERVICIOS_SE_ASIGNAN_MODIFICAR
dbo.pb_situacion_academica
dbo.pb_tipo_programa
dbo.insertar_usuarios_oficina
dbo.pb_buscar_usuarios_oficina
dbo.pb_modificar_usuario_oficina
dbo.pb_quitar_usuarios_oficina
dbo.pb_MODULO_ATIENDE

--Inserciones especiales

insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(1,'En Espera');
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(2,'En Atención');
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(3,'Atención Finalizada');
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(4,'Atención Saltada');.
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(5,'Atención Pausada');
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(6,'Atención No Finalizada');
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(7,'Atención Reanudada');

--Perfil


select * from ubb..SISTEMAS_UBB --47    Sistema Control Turnos    0    1
select * from ubb..USUARIO_PERFIL --1    analisis    47

insert into Ubb..SISTEMAS_UBB values(48,'Sistema Control Turnos',0,1)
insert into Ubb..SISTEMAS_UBB values(48,'Sistema Control Turnos',0,1)

insert into Ubb..PERFIL values( 1,48,'Administrador','w_ppal')
insert into Ubb..PERFIL values( 2,48,'General','w_ppal')

insert into ubb..USUARIO_PERFIL values(1,'analisis',48)
insert into ubb..USUARIO_PERFIL values(1,'cvidal',48)
insert into ubb..USUARIO_PERFIL values(1,'hbuker',48)
insert into ubb..USUARIO_PERFIL values(1,'jbriones',48)
insert into ubb..USUARIO_PERFIL values(1,'vlopezp',48)
insert into ubb..USUARIO_PERFIL values(2,'dtapia',48)
insert into ubb..USUARIO_PERFIL values(2,'hbuker',48)

update Ubb..PARAMETROS_UBB  set control_turnos = 48


insert into documentos_ubb.dbo.ADMINISTRADOR_LISTAS_SISTEMA(mae_rut,als_password) values(12972970,'123456')


documentos_ubb.dbo.ESTADO_ATENCION



dbo.pb_eliminar_asignacion
dbo.pb_eliminar_atencion_asignada
dbo.PB_SERVICIOS_ASIGNADOS_ELIMINAR
-- estado_atencion.sql

/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, Todo el sistema, 
	
	
	@-Parametro_Entrada0: 1
	@-Parametro_Entrada1: 2
	@-Parametro_Entrada2: 3
	@-Parametro_Entrada3: 4
	@-Parametro_Entrada4: 5
	@-Parametro_Entrada5: 6

	@-Descripcion_Objeto0: Tabla que controla los estados de atención
	@-Regla_Objeto0: Debe existir una oficina de reparticion junto a una fila para poder crear estados
	@-String_Prueba0: Select * from Documentos_ubb.dbo.ESTADO_ATENCION;
	
	
FIN_DATOS_PROCEDIMIENTO**/	


create table DBO.ESTADO_ATENCION 
(
   ESTAD_CODIGO         integer                        not null,
   ESTAD_NOMBRE         varchar(50)                    null,
   constraint PK_DBO_ESTADO_ATENCION primary key clustered (ESTAD_CODIGO)
);

insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(1,'En Espera');
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(2,'En Atención');
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(3,'Atención Finalizada');
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(4,'Atención Saltada');.
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(5,'Atención Pausada');
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(6,'Atención No Finalizada');
insert into DOCUMENTOS_UBB.dbo.ESTADO_ATENCION with(updlock)(ESTAD_CODIGO,ESTAD_NOMBRE)values(7,'Atención Reanudada');
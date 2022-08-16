/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, 
	
	
	@-Parametro_Entrada0: CON_CORRELATIVO
	@-Parametro_Entrada1: OFRE_CODIGO
	@-Parametro_Entrada2: CCO_CODIGO
	@-Parametro_Entrada3: REP_CODIGO
	@-Parametro_Entrada4: EDU_CODIGO
	@-Parametro_Entrada5: CON_IP
	@-Parametro_Entrada6: CON_PUERTO
	@-Parametro_Entrada7: CON_FECHA_REGISTRO

	@-Descripcion_Objeto0: Ingresa la ip publica del entorno de red del computador al momento de iniciar sesion con la pantalla de llamada de atención
	@-Regla_Objeto0: Es necesario tener una oficina de reparticion creada para poder ejecutar este sp
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_ingresar_nueva_ip;
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_ingresar_nueva_ip
(
   @CON_CORRELATIVO      integer,
   @OFRE_CODIGO          integer,
   @CCO_CODIGO           decimal,
   @REP_CODIGO           decimal,
   @EDU_CODIGO           integer,
   @CON_IP               varchar(100),
   @CON_PUERTO           varchar(100),
   @CON_FECHA_REGISTRO   datetime
) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

	insert into DOCUMENTOS_UBB.dbo.OFICINA_IP_PUERTO 
	with(updlock)
	(
		 CON_CORRELATIVO
		, OFRE_CODIGO
		, CCO_CODIGO
		, REP_CODIGO
		, EDU_CODIGO
		, CON_IP
		, CON_PUERTO
		, CON_FECHA_REGISTRO
	)
	values 
	(
		 @CON_CORRELATIVO
		, @OFRE_CODIGO
		, @CCO_CODIGO
		, @REP_CODIGO
		, @EDU_CODIGO
		, @CON_IP
		, @CON_PUERTO
		, @CON_FECHA_REGISTRO
	);

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;
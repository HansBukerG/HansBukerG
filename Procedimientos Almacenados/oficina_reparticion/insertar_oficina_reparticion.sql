/**INICIO_DATOS_PROCEDIMIENTO 
   
   @-autor0: Hans Buker Gutiérrez
   @-Fecha_Creacion0: 25-06-2018
   @-modificado_por0: 
   @-Fecha_Modificacion0: 
   @-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores
   
   @-Parametro_Entrada0: OFRE_CODIGO
   @-Parametro_Entrada1: CCO_CODIGO
   @-Parametro_Entrada2: REP_CODIGO
   @-Parametro_Entrada3: EDU_CODIGO
   @-Parametro_Entrada4: OFRE_NOMBRE_OFICINA
   @-Parametro_Entrada5: OFRE_ABREVIACION
   @-Parametro_Entrada6: OFRE_FECHA_INICIO
   @-Parametro_Entrada7: OFRE_FECHA_TERMINO
   @-Parametro_Entrada8: OFRE_FECHA_REGISTRO
   @-Parametro_Entrada9: OFRE_LOG_REGISTRO

   @-Descripcion_Objeto0: Ingresa una nueva oficina de reparticion
   @-Regla_Objeto0: Debe ser ingresada por un usuario con perfil de administrador
   @-String_Prueba0: EXEC Documentos_ubb.dbo.pb_insertar_oficina_reparticion;
   
FIN_DATOS_PROCEDIMIENTO**/ 


alter proc dbo.pb_insertar_oficina_reparticion
(
		@OFRE_CODIGO          integer                         
   ,	@CCO_CODIGO           decimal                         
   ,	@REP_CODIGO           decimal                         
   ,	@EDU_CODIGO           integer                         
   ,	@OFRE_NOMBRE_OFICINA  varchar(250)
   ,	@OFRE_ABREVIACION     varchar(250)
   ,	@OFRE_FECHA_INICIO    datetime
   ,	@OFRE_FECHA_TERMINO   datetime
   ,	@OFRE_FECHA_REGISTRO  datetime
   ,	@OFRE_LOG_REGISTRO    varchar(250)
) as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION;

   insert into DOCUMENTOS_UBB.dbo.oficina_reparticion with(updlock)
   (
   		OFRE_CODIGO                                   
      ,	CCO_CODIGO                                    
      ,	REP_CODIGO                                    
      ,	EDU_CODIGO                                    
      ,	OFRE_NOMBRE_OFICINA 
      ,	OFRE_ABREVIACION     
      ,	OFRE_FECHA_INICIO    
      ,	OFRE_FECHA_TERMINO   
      ,	OFRE_FECHA_REGISTRO  
      ,	OFRE_LOG_REGISTRO   
   )
   values 
   (
   		@OFRE_CODIGO                                   
      ,	@CCO_CODIGO                                    
      ,	@REP_CODIGO                                    
      ,	@EDU_CODIGO                                    
      ,	@OFRE_NOMBRE_OFICINA 
      ,	@OFRE_ABREVIACION     
      ,	@OFRE_FECHA_INICIO    
      ,	@OFRE_FECHA_TERMINO   
      ,	@OFRE_FECHA_REGISTRO  
      ,	@OFRE_LOG_REGISTRO  
   );

COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH; 


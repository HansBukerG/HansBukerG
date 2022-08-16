/**INICIO_DATOS_PROCEDIMIENTO	
	
	@-autor0: Hans Buker Gutiérrez
	@-Fecha_Creacion0: 25-06-2018
	@-modificado_por0: 
	@-Fecha_Modificacion0: 
	@-usado_por0: Sistema de Gestión y Control de Listas de Espera, mantenedores, dw_categorias_por_oficina
	
	
	@-Parametro_Entrada0: CATE_CODIGO
	@-Parametro_Entrada1: OFRE_CODIGO
	@-Parametro_Entrada2: CCO_CODIGO
	@-Parametro_Entrada3: REP_CODIGO
	@-Parametro_Entrada4: EDU_CODIGO
	@-Parametro_Entrada5: CATE_NOMBRE
	@-Parametro_Entrada6: CATE_ABREVIACION
	@-Parametro_Entrada7: CATE_FECHA_INICIO
	@-Parametro_Entrada8: CATE_FECHA_TERMINO
	@-Parametro_Entrada9: CATE_FECHA_REGISTRO
	@-Parametro_Entrada10: CATE_LOG_REGISTRO
	
	@-Descripcion_Objeto0: Ingresa una nueva categoría en el sistema
	@-Regla_Objeto0: Debe existir una oficina de repartición para poder crear una categoría
	@-String_Prueba0: EXEC Documentos_ubb.dbo.pb_insertar_nueva_categoria 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ;
	
	
FIN_DATOS_PROCEDIMIENTO**/	


alter proc dbo.pb_insertar_nueva_categoria
	(
		@CATE_CODIGO          integer,
		@OFRE_CODIGO          integer,
		@CCO_CODIGO           decimal,
		@REP_CODIGO           decimal,
		@EDU_CODIGO           integer,
		@CATE_NOMBRE          varchar(250),
		@CATE_ABREVIACION     varchar(2),
		@CATE_FECHA_INICIO    datetime,
		@CATE_FECHA_TERMINO   datetime,
		@CATE_FECHA_REGISTRO  datetime,
		@CATE_LOG_REGISTRO    varchar(250)
	) 
as

DECLARE @error VARCHAR(200)
BEGIN TRY  
BEGIN TRANSACTION; 

insert into DOCUMENTOS_UBB.dbo.CATEGORIA_SERVICIO with(updlock)
	(
		CATE_CODIGO          ,
		OFRE_CODIGO          ,
		CCO_CODIGO           ,
		REP_CODIGO           ,
		EDU_CODIGO           ,
		CATE_NOMBRE          ,
		CATE_ABREVIACION	 ,
		CATE_FECHA_INICIO    ,
		CATE_FECHA_TERMINO   ,
		CATE_FECHA_REGISTRO  ,
		CATE_LOG_REGISTRO
	)
values 
	(
		@CATE_CODIGO          ,
		@OFRE_CODIGO          ,
		@CCO_CODIGO           ,
		@REP_CODIGO           ,
		@EDU_CODIGO           ,
		@CATE_NOMBRE          ,
		@CATE_ABREVIACION	  ,
		@CATE_FECHA_INICIO    ,
		@CATE_FECHA_TERMINO   ,
		@CATE_FECHA_REGISTRO  ,
		@CATE_LOG_REGISTRO
	);
	
COMMIT
END TRY  
BEGIN CATCH  
  SELECT @error = ERROR_MESSAGE()
  RAISERROR(@error, 16, 1)
  ROLLBACK TRANSACTION;  
END CATCH;

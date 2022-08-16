create table dbo.servicio_vincula_situacion 
(
   SERV_CODIGO          integer                        not null,
   CATE_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   SAA_CODIGO           integer                        not null,
   SVS_CODIGO           integer                        not null,
   SVS_FECHA_REGISTRO   datetime                       null,
   SVS_LOG_REGISTRO     varchar(250)                   null,
   constraint PK_RELATIONSHIP_40 primary key clustered (
      SERV_CODIGO
      ,SAA_CODIGO
      ,CATE_CODIGO
      ,OFRE_CODIGO
      ,CCO_CODIGO
      ,REP_CODIGO
      ,EDU_CODIGO
      ,SVS_CODIGO)
);
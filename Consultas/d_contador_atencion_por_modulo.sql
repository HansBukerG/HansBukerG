create table DBO.FILAS_ATENCION 
(
   FILA_FECHA           date                           not null,
   FILA_CODIGO          integer                        not null,
   SERV_CODIGO          integer                        not null,
   CATE_CODIGO          integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   MOD_CODIGO           integer                        not null,
   FILA_RUT             integer                        null,
   FILA_NUMERO          varchar(10)                    null,
   FILA_FECHA_REGISTRO  datetime                       null,
   FILA_LOG_REGISTRO    varchar(250)                   null,
   constraint PK_DBO_FILAS_ATENCION primary key clustered (FILA_FECHA,FILA_CODIGO,SERV_CODIGO,CATE_CODIGO,OFRE_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO,MOD_CODIGO)
);

create table DBO.MODULOS_ATENCION 
(
   MOD_CODIGO           integer                        not null,
   OFRE_CODIGO          integer                        not null,
   CCO_CODIGO           decimal                        not null,
   REP_CODIGO           decimal                        not null,
   EDU_CODIGO           integer                        not null,
   
   MOD_LOG_IN           int                            null,

   MOD_NOMBRE           varchar(250)                   null,
   MOD_ABREVIACION      varchar(250)                   null,
   MOD_FECHA_INICIO     datetime                       null,
   MOD_FECHA_TERMINO    datetime                       null,
   MOD_FECHA_REGISTRO   datetime                       null,
   MOD_LOG_REGISTRO     varchar(250)                   null,
   constraint PK_DBO_MODULOS_ATENCION primary key clustered (MOD_CODIGO,OFRE_CODIGO,CCO_CODIGO,REP_CODIGO,EDU_CODIGO)
);


alter table documentos_ubb.dbo.MODULOS_ATENCION
ADD   MOD_LOG_IN   int NULL
,     MOD_CONTADOR INT 


select  top 1 modulos.MOD_NOMBRE, count(filas.MOD_CODIGO) as ordenamiento
from documentos_ubb.dbo.MODULOS_ATENCION as modulos with(nolock)
join documentos_ubb.dbo.filas_atencion as filas with(nolock)
on       filas.MOD_CODIGO  = modulos.MOD_CODIGO
and      filas.OFRE_CODIGO = modulos.OFRE_CODIGO
and      filas.CCO_CODIGO  = modulos.CCO_CODIGO
and      filas.REP_CODigo  = modulos.REP_CODIGO
and      filas.EDU_CODIGO  = modulos.EDU_CODIGO
group by modulos.MOD_NOMBRE
order by ordenamiento

select top 1 ip.CON_IP, ip.CON_PUERTO
into :ls_hostname, :puerto
from  documentos_ubb.dbo.OFICINA_IP_PUERTO as ip
where ip.OFRE_CODIGO = str_recibir.OFRE_CODIGO
and ip.CCO_CODIGO = str_recibir.CCO_CODIGO
and ip.REP_CODIGO = str_recibir.REP_CODIGO
and ip.EDU_CODIGO = str_recibir.EDU_CODIGO
order by ip.con_fecha_registro desc;
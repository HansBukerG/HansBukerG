create trigger trigger_insertar_bitacora
on documentos_ubb.dbo.MOTIVO_ATENCION
for insert
as
declare @fecha_registro    datetime
,		  @ofre_codigo       int
,		  @cco_codigo	      decimal
,		  @rep_codigo        decimal
,		  @edu_codigo	      int

select  @fecha_registro = MOAT_FECHA_REGISTRO
,		  @ofre_codigo   	= OFRE_CODIGO
,		  @cco_codigo   	= CCO_CODIGO
,		  @rep_codigo   	= REP_CODIGO
,		  @edu_codigo   	= EDU_CODIGO
from inserted
-- Primera parte del trigger
	if exists(  select *
				from documentos_ubb.dbo.BITACORA_CONTROL_TURNOS b
				where	 	b.OFRE_CODIGO 	= @ofre_codigo
				and 	b.CCO_CODIGO 	= @cco_codigo
				and 	b.REP_CODIGO 	= @rep_codigo
				and 	b.EDU_CODIGO 	= @edu_codigo
				)
				UPDATE  dbo.BITACORA_CONTROL_TURNOS with(updlock)
				SET 	BI_FECHA_REGISTRO 	= 	@fecha_registro
				where 	OFRE_CODIGO = @ofre_codigo
				and 	CCO_CODIGO = @cco_codigo
            and   EDU_CODIGO = @edu_codigo
				and 	REP_CODIGO = @rep_codigo
	else
		insert into documentos_ubb.dbo.BITACORA_CONTROL_TURNOS
		(
				BI_FECHA_REGISTRO
			,	OFRE_CODIGO
			,	CCO_CODIGO
			,	REP_CODIGO
			,	EDU_CODIGO
		)
		values
		(
				@fecha_registro
			,	@ofre_codigo
			,	@cco_codigo
			,	@rep_codigo
			,	@edu_codigo
		)
--Segunda parte del trigger

   
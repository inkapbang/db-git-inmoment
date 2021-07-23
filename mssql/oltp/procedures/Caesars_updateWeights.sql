SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[Caesars_updateWeights]


as

set nocount on

/*
	usage:

	exec Caesars_updateWeights
*/


declare @max int, @count int
declare @rep int
declare @wei float
declare @seq int

set @count = 1

begin

	---- Preparation
	--if not exists (select * from sys.objects where object_id = object_id(N'[dbo].[__weight_res]') and type in (N'u'))
	--begin
	--create table [dbo].[__weight_res](
	--	[id] [bigint] null,
	--	[responseid] [int] not null,
	--	[name] [varchar](200) null,
	--	[offercode] [varchar](100) null,
	--	[dia] [int] null,
	--	[gld] [int] null,
	--	[plt] [int] null,
	--	[sev] [int] null,
	--	[hsp] [int] null,
	--	[sev_dia] [float] null,
	--	[plt_plt] [float] null,
	--	[gld_hsp] [float] null,
	--	[weight_tier] [decimal](12, 8) null
	--) on [primary]
	--end


	select @rep = MIN(responseId), @max= max(responseId) from __weight_res


	while (@rep <= @max)

	begin

	  select @wei= Weight_tier from __weight_res where responseId = @rep
	  
	  select @seq = MAX(sequence) from SurveyResponseAnswer where surveyResponseObjectId = @rep

	  insert into SurveyResponseAnswer(surveyResponseObjectId, sequence, version, dataFieldObjectId, textValue)
	  select @rep, @seq+1, 1, 237924, @wei
	  
	  select @rep = MIN(responseId) from __weight_res where responseId > @rep
	  
	  set @count = @count + 1
	  
	  if @count % 100 = 0
	  begin
		waitfor delay '00:00:05'
	  end
	  
	  
	end



	-- Check for duplication
	/*
	if exists (
	select sra.surveyresponseobjectid  
	from SurveyResponseAnswer sra
	--join __weight_res r on r.responseId = sra.surveyResponseObjectId
	where sra.dataFieldObjectId = 237924
	group by sra.surveyresponseobjectid
	having count(*)>1
	)
		

	select sra.surveyresponseobjectid  
	from SurveyResponseAnswer sra (nolock)
	join __weight_res r (nolock) on r.responseId = sra.surveyResponseObjectId
	where sra.dataFieldObjectId = 237924

	*/


	truncate table __weight_res


end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

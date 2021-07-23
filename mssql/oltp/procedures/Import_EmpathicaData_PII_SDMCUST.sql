SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		In-Kap Bang
-- Create date: 2017.05.31
-- Description:	Import PII Data For SDMCUST
-- =============================================
CREATE PROCEDURE [dbo].[Import_EmpathicaData_PII_SDMCUST]
@RID int,
@MS_RID int
AS
BEGIN

/*
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @Answer_TBL table (MS_SurveyResponseObjectId int not null, textValue nvarchar(2000) null, DFID int null)
	
	insert into @Answer_TBL
	select	MS_SurveyResponseObjectId,CertCode as textValue,116251 as DFID from putwh06.import.dbo.temp_sdmcust_PII_20170531 with (nolock) where ResponseId = @RID and CertCode is not null
	union all
	select	MS_SurveyResponseObjectId,FirstName,116247 from putwh06.import.dbo.temp_sdmcust_PII_20170531 with (nolock) where ResponseId = @RID and FirstName is not null
	union all
	select	MS_SurveyResponseObjectId,LastName,116248 from putwh06.import.dbo.temp_sdmcust_PII_20170531 with (nolock) where ResponseId = @RID and LastName is not null
	union all
	select	MS_SurveyResponseObjectId,EMail,116250 from putwh06.import.dbo.temp_sdmcust_PII_20170531 with (nolock) where ResponseId = @RID and EMail is not null
	union all
	select	MS_SurveyResponseObjectId,Phone,116249 from putwh06.import.dbo.temp_sdmcust_PII_20170531 with (nolock) where ResponseId = @RID and Phone is not null
	union all
	select	MS_SurveyResponseObjectId,TIME_OF_VISIT,208134 from putwh06.import.dbo.temp_sdmcust_PII_20170531 with (nolock) where ResponseId = @RID and TIME_OF_VISIT is not null
	union all
	select	MS_SurveyResponseObjectId,REGISTER_NUMBER,155082 from putwh06.import.dbo.temp_sdmcust_PII_20170531 with (nolock) where ResponseId = @RID and REGISTER_NUMBER is not null
	union all
	select	MS_SurveyResponseObjectId,SDMC2_ERP2,135425 from putwh06.import.dbo.temp_sdmcust_PII_20170531 with (nolock) where ResponseId = @RID and SDMC2_ERP2 is not null
	union all
	select	MS_SurveyResponseObjectId,InboundId,186840 from putwh06.import.dbo.temp_sdmcust_PII_20170531 with (nolock) where ResponseId = @RID and InboundId is not null and SourceId <> 2

	declare @SEQID int, @DupeCnt int
	select @SEQID = max(sequence) from SurveyResponseAnswer with (nolock) where surveyResponseObjectId = @MS_RID

	if @SEQID is not null
	begin

		delete from @Answer_TBL where DFID in (select dataFieldObjectId from SurveyResponseAnswer with (nolock) where surveyResponseObjectId = @MS_RID)

			begin transaction IMPORT_PII_SDMCUST

			insert into SurveyResponseAnswer (surveyResponseObjectId,sequence,textValue,dataFieldObjectId)
			select	MS_SurveyResponseObjectId,
					DENSE_RANK() OVER (ORDER BY DFID) + @SEQID as sequence,
					textValue,
					DFID
			from	@Answer_TBL
			if @@error = 0 
			begin
				commit transaction IMPORT_PII_SDMCUST
				--print 'Success'
				update putwh06.import.dbo.temp_sdmcust_PII_20170531 set ProcessedFlag = 1 where ResponseId = @RID
			end
			else
			begin
				rollback transaction IMPORT_PII_SDMCUST
				--print 'Fail: RID:'+convert(varchar(100),@RID)
				return 1
			end
	end
	else return 1
*/

	return 0


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

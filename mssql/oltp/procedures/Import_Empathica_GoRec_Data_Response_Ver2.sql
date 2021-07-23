SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		In-Kap Bang
-- Create date: 2014.05.22
-- Description:	Import Empathica GoRecommend Data
-- =============================================
CREATE PROCEDURE [dbo].[Import_Empathica_GoRec_Data_Response_Ver2]
@OrganizationId int,
@ClientId int,
@EmpathicaSessionId int,
@EmpathicaRecommendationId int,
@EmpathicaRecommendationPostId int,
@MS_SurveyResponseObjectId bigint OUTPUT
AS
BEGIN

/*
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @SRAIDs table (objectId bigint,dataFieldObjectId int)
	declare @COMMENTIDs table (objectId bigint,SRAID bigint)
	--declare @MS_SurveyResponseObjectId int

	declare @GoRec_ts datetime,@EmpathicaLocationUnitCode varchar(50),
		@Val_110830 bigint,@Val_110832 bigint,@Val_54 int,@Val_110817 int,@Val_110842 bit,@Val_97933 int,@Val_110814 int,@Val_110827 int,@Val_110834 varchar(200),
		@Val_97937 int,@Val_110816 int,@Val_110829 int,@Val_110836 varchar(200),@Val_110812 int,@Val_110813 int,@Val_110818 int,@Val_110826 int,@Val_110819 int,
		@Val_110823 int,@Val_110820 int,@Val_110824 int,@Val_110822 int,@Val_110825 int,@Val_110843 nvarchar(max),@Val_110833 varchar(10),
		@LocationId int,@OfferId int,@SurveyGatewayId int,@SurveyId int, @Culture varchar(50)

	select	
			@EmpathicaLocationUnitCode = EmpathicaLocationUnitCode,
			@Val_110830 = [110830],
			@Val_110832 = [110832],
			@Val_54 = [54],
			@Val_110817 = [110817],
			@Val_110842 = [110842],
			@Val_97933 = [97933],
			@Val_110814 = [110814],
			@Val_110827 = [110827],
			@Val_110834 = [110834],
			@Val_97937 = [97937],
			@Val_110816 = [110816],
			@Val_110829 = [110829],
			@Val_110836 = [110836],
			@Val_110812 = [110812],
			@Val_110813 = [110813],
			@Val_110818 = [110818],
			@Val_110826 = [110826],
			@Val_110819 = [110819],
			@Val_110823 = [110823],
			@Val_110820 = [110820],
			@Val_110824 = [110824],
			@Val_110822 = [110822],
			@Val_110825 = [110825],
			@Val_110843 = [110843],
			@Val_110833 = [110833],
			@GoRec_ts = ts,
			@Culture = Culture,
			@LocationId = locationObjectId,
			@OfferId = offerObjectId,
			@SurveyGatewayId = surveyGatewayObjectId,
			@SurveyId = surveyObjectId
	from	putwh01.Import.dbo.GoRecData with (nolock)
	where	(organizationObjectId = @OrganizationId and ClientId = @ClientId and EmpathicaSessionId = @EmpathicaSessionId and EmpathicaRecommendationId = @EmpathicaRecommendationId and EmpathicaRecommendationPostId = @EmpathicaRecommendationPostId)
			and MS_surveyResponseObjectId is null
	if @@error <> 0 or @@rowcount = 0
	begin
		print 'Cannot Find Row with EmpathicaSessionId:'+cast(@EmpathicaSessionId as varchar(100))+'| OrgID: '+cast(@OrganizationId as varchar(100)) + '| ClientId: ' + convert(varchar(100),@ClientId) + '| RecommendationId: ' + convert(varchar(100),@EmpathicaRecommendationId) + '| RecommendationPostId' + convert(varchar(100),@EmpathicaRecommendationPostId)

		return 1
	end




	-- Insert SurveyResponse
	BEGIN TRANSACTION IMPORT_GOREC

	INSERT INTO dbo.surveyresponse
	([surveyGatewayObjectId],
	[beginDate],
	[complete],
	[surveyObjectId],
	[version],
	[isRead],
	[dateOfService],
	[beginTime],
	[beginDateUTC],
	[exclusionReason],
	[locationObjectId],
	[offerObjectId],
	[offerCode],[reviewOptin],modeType,msrepl_tran_version)

	

	select	@SurveyGatewayId,
			convert(varchar(10),@GoRec_ts,101),
			1,
			@SurveyId,
			1,
			1,
			convert(varchar(10),@GoRec_ts,101),
			dateadd(day,datediff(day,@GoRec_ts,'1990-01-01'),@GoRec_ts),
			@GoRec_ts,
			0,
			@LocationId,
			@OfferId,
			@EmpathicaLocationUnitCode,
			0,
			3,
			newid()
	if @@error <> 0 or @@rowcount = 0
	begin
		print 'Error inserting To SurveyResponse'
		rollback transaction IMPORT_GOREC
		return 1
	end

	set @MS_SurveyResponseObjectId = SCOPE_IDENTITY()
	if @MS_SurveyResponseObjectId is null 
	begin
		print 'Identity.SurveyResponse Not Received'
		return 1
	end

			
	INSERT INTO dbo.SurveyResponseAnswer (surveyResponseObjectId,msrepl_tran_version,sequence,numericValue,textValue,dateValue,booleanValue,version,
				dataFieldObjectId,dataFieldOptionObjectId)
	OUTPUT inserted.objectId,inserted.dataFieldObjectId into @SRAIDs

	select	@MS_SurveyResponseObjectId,
			newid(),
			dense_rank() over (order by dataFieldId) - 1 as Sequence,
			numericValue,
			textValue,
			NULL,
			booleanValue,
			1,
			dataFieldId,
			NULL
	from

	(

	select	
			110830 as dataFieldId,
			NULL as numericValue,
			convert(varchar(200),@Val_110830) as textValue,
			NULL as booleanValue
	union all
	select	110837,NULL,NULL,NULL
	union all
	select	110832,NULL,convert(varchar(200),@Val_110832),NULL where @Val_110832 is not null
	union all
	select	110839,NULL,NULL,NULL
	union all
	select	110831,NULL,NULL,NULL
	union all
	select	110838,NULL,NULL,NULL
	union all
	select	54,NULL,NULL,@Val_54 where @Val_54 is not null
	union all
	select	110817,NULL,NULL,@Val_110817 where @Val_110817 is not null
	union all
	select	110842,NULL,NULL,@Val_110842 where @Val_110842 is not null
	union all
	select	97933,NULL,NULL,@Val_97933 where @Val_97933 is not null
	union all
	select	110814,convert(varchar(200),@Val_110814),NULL,NULL where @Val_110814 is not null
	union all
	select	110827,convert(varchar(200),@Val_110827),NULL,NULL where @Val_110827 is not null
	union all
	select	110834,NULL,convert(varchar(200),@Val_110834),NULL where @Val_110834 is not null
	union all
	select	97937,NULL,NULL,@Val_97937 where @Val_97937 is not null
	union all
	select	110816,convert(varchar(200),@Val_110816),NULL,NULL where @Val_110816 is not null
	union all
	select	110829,convert(varchar(200),@Val_110829),NULL,NULL where @Val_110829 is not null
	union all
	select	110836,NULL,convert(varchar(200),@Val_110836),NULL where @Val_110836 is not null
	union all
	select	97934,NULL,NULL,NULL
	union all
	select	110815,NULL,NULL,NULL
	union all
	select	110828,NULL,NULL,NULL
	union all
	select	110835,NULL,NULL,NULL
	union all
	select	110812,NULL,NULL,@Val_110812 where @Val_110812 is not null
	union all
	select	110813,convert(varchar(200),@Val_110813),NULL,NULL where @Val_110813 is not null
	union all
	select	110818,convert(varchar(200),@Val_110818),NULL,NULL where @Val_110818 is not null
	union all
	select	110826,convert(varchar(200),@Val_110826),NULL,NULL where @Val_110826 is not null
	union all
	select	110819,NULL,NULL,@Val_110819 where @Val_110819 is not null
	union all
	select	110840,NULL,NULL,NULL
	union all
	select	110823,NULL,NULL,@Val_110823 where @Val_110823 is not null
	union all
	select	110841,NULL,NULL,NULL
	union all
	select	110820,NULL,NULL,@Val_110820 where @Val_110820 is not null
	union all
	select	110821,NULL,NULL,NULL
	union all
	select	110824,NULL,NULL,@Val_110824 where @Val_110824 is not null
	union all
	select	110822,NULL,NULL,@Val_110822 where @Val_110822 is not null
	union all
	select	110825,NULL,NULL,@Val_110825 where @Val_110825 is not null
	union all
	select	110833,NULL,convert(varchar(200),@Val_110833),NULL where @Val_110833 is not null
	union all
	select	110843,NULL,NULL,NULL

	) AnswerBucket

	if @@error <> 0 or @@rowcount = 0
	begin
		print 'Error Inserting To SurveyResponseAnswer'
		rollback transaction IMPORT_GOREC
		return 2
	end


	-- Handle Comments
	if @Val_110843 is not null
	begin
		INSERT INTO dbo.Comment (msrepl_tran_version,version,surveyResponseAnswerObjectId,commentType,commentText,commentTextLengthBytes,commentTextLengthChars,transcriptionState,audioContentType,commentLanguage)
		OUTPUT inserted.objectId,inserted.surveyResponseAnswerObjectId into @COMMENTIDs
		select	newid(),1,s.objectId,0,@Val_110843,datalength(@Val_110843),len(@Val_110843),0,0,case when @Culture = 'en-US' then 1 else NULL end
		from	@SRAIDS s
		where	s.dataFieldObjectId = 110843
		if @@error <> 0 
		begin
			print 'Error Inserting To Comment'
			rollback transaction IMPORT_GOREC
			return 3
		end
	end

	UPDATE dbo.SurveyResponseAnswer
	SET binaryContentObjectId = c.objectId
	FROM @COMMENTIDs c
	WHERE	c.SRAID = dbo.SurveyResponseAnswer.objectId
	if @@error <> 0 
	begin
		print 'Error Updating binaryContentObjectId'
		rollback transaction IMPORT_GOREC
		return 5
	end


	COMMIT TRANSACTION IMPORT_GOREC

	--BEGIN TRANSACTION UPDATE_RESPONSEID
	UPDATE putwh01.Import.dbo.GoRecData
		SET MS_surveyResponseObjectId = @MS_SurveyResponseObjectId
	WHERE	organizationObjectId = @OrganizationId and ClientId = @ClientId and EmpathicaSessionId = @EmpathicaSessionId and EmpathicaRecommendationId = @EmpathicaRecommendationId and EmpathicaRecommendationPostId = @EmpathicaRecommendationPostId
	if @@error <> 0 or @@rowcount = 0
	begin
		print 'Error Updating GoRecData'
		--rollback transaction UPDATE_RESPONSEID
		return 4
	end


*/

	return 0


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

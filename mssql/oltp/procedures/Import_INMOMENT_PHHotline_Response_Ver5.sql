SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Bailey Hu
-- Create date: 2016.04.21
-- Description:	Import Empathica Data
-- =============================================
CREATE PROCEDURE [dbo].[Import_INMOMENT_PHHotline_Response_Ver5]
@OrganizationId int,
@ResponseId varchar(200),
@ResponseSourceId int,
@MS_SurveyResponseObjectId int OUTPUT
AS
BEGIN

/*
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @SRAIDs table (objectId bigint,dataFieldObjectId int)
	declare @COMMENTIDs table (objectId bigint,SRAID bigint)

	--declare @MS_SurveyResponseObjectId int

	-- Insert SurveyResponse
	BEGIN TRANSACTION IMPORT_RESPONSE_INMOMENT

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
	[offerCode],[reviewOptin],modeType,responseSourceObjectId,redemptionCodeVal,
	[minutes]
	)


	select	r.surveyGatewayId,
			r.begindate,
			1,
			r.surveyId,
			0,
			0,
			r.dateOfService,
			r.beginTime,
			r.beginDateUTC,
			0,
			r.locationObjectId,
			r.offerObjectId,
			r.offerCode,
			NULL,
			3,
			@ResponseSourceId,
			0,
			[minute]
	from	putwh06.Import.dbo.ResponseHeader_INMOMENT r with (nolock)
	where	r.ResponseId = @ResponseId and r.OrganizationId = @OrganizationId and r.MS_SurveyResponseObjectId is null
	if @@error <> 0 or @@rowcount = 0 or @@rowcount > 1
	begin
		print 'Error Inserting To SurveyResponse'
		rollback transaction IMPORT_RESPONSE_INMOMENT
		return 1
	end

	set @MS_SurveyResponseObjectId = SCOPE_IDENTITY()


	-- Prepare for Additional Information
	declare @SurveyLang varchar(10)
	select	@SurveyLang = r.Lang
	from	putwh06.Import.dbo.ResponseHeader_INMOMENT r with (nolock)
	where	(r.ResponseId = @ResponseId and r.OrganizationId = @OrganizationId)
	
		

			
	INSERT INTO dbo.SurveyResponseAnswer (surveyResponseObjectId,sequence,numericValue,textValue,dateValue,booleanValue,version,
				dataFieldObjectId,dataFieldOptionObjectId)
	OUTPUT inserted.objectId,inserted.dataFieldObjectId into @SRAIDs


	select	@MS_SurveyResponseObjectId,
			dense_rank() over (order by dataFieldObjectId,dataFieldOptionObjectId) - 1 as Sequence,
			numericValue,
			case when fieldType = 5 then NULL else textValue end as textValue,
			dateValue,
			booleanValue,
			1,
			dataFieldObjectId,
			dataFieldOptionObjectId
	from	putwh06.Import.dbo.ResponseDetailChoice_INMOMENT r with (nolock)
	where	r.OrganizationId = @OrganizationId and r.ResponseId = @ResponseId
	if @@error <> 0 or @@rowcount = 0
	begin
		print 'Error Inserting To SurveyResponseAnswer'
		rollback transaction IMPORT_RESPONSE_INMOMENT
		return 2
	end
	
	if exists (select null from @SRAIDs s inner join dbo.DataField df with (nolock) on (s.dataFieldObjectId = df.objectId)
				where df.fieldType = 5)
	begin
		-- Handle Comments
		INSERT INTO dbo.Comment (version,surveyResponseAnswerObjectId,commentType,commentText,commentTextLengthBytes,commentTextLengthChars,transcriptionState,audioContentType,commentLanguage)
		OUTPUT inserted.objectId,inserted.surveyResponseAnswerObjectId into @COMMENTIDs

		SELECT	1,ID_Filter.objectId,0,Answer_Filter.AnswerValue,datalength(Answer_Filter.AnswerValue),len(Answer_Filter.AnswerValue),0,0,case @SurveyLang when 'EN' then 1 when 'FR' then 2 when 'DE' then 3 when 'ES' then 4 else NULL end as commentLanguage
		FROM
		(
		select	s.objectId,s.dataFieldObjectId
		from	@SRAIDs s
				inner join dbo.DataField df with (nolock) on (s.dataFieldObjectId = df.objectId)
		where	df.fieldType = 5
		) ID_Filter
		inner join 
		(

			select	
					r.ResponseId,
					r.dataFieldObjectId,
					r.dataFieldOptionObjectId,
					r.textValue as AnswerValue
			from	putwh06.Import.dbo.ResponseDetailChoice_INMOMENT r with (nolock)
			where	r.ResponseId = @ResponseId and r.OrganizationId = @OrganizationId 
		) Answer_Filter on (ID_Filter.dataFieldObjectId = Answer_Filter.dataFieldObjectId)
		if @@error <> 0 
		begin
			print 'Error Inserting To Comment'
			rollback transaction IMPORT_RESPONSE_INMOMENT
			return 3
		end

		UPDATE dbo.SurveyResponseAnswer
		SET binaryContentObjectId = c.objectId
		FROM @COMMENTIDs c
		WHERE	c.SRAID = dbo.SurveyResponseAnswer.objectId
		if @@error <> 0 
		begin
			print 'Error Updating binaryContentObjectId'
			rollback transaction IMPORT_RESPONSE_INMOMENT
			return 5
		end
	end
			


	COMMIT TRANSACTION IMPORT_RESPONSE_INMOMENT

	--BEGIN TRANSACTION UPDATE_RESPONSEID
	UPDATE putwh06.Import.dbo.ResponseHeader_INMOMENT
		SET MS_SurveyResponseObjectId = @MS_SurveyResponseObjectId
	WHERE	OrganizationId = @OrganizationId and ResponseId = @ResponseId
	if @@error <> 0 or @@rowcount = 0
	begin
		print 'Error Updating ResponseHeader'
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

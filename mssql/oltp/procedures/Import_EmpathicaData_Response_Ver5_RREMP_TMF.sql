SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		In-Kap Bang
-- Create date: 2014.04.09
-- Description:	Import Empathica Data
-- =============================================
CREATE PROCEDURE [dbo].[Import_EmpathicaData_Response_Ver5_RREMP_TMF]
@OrganizationId int,
@ClientId int,
@ResponseId int,
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
	BEGIN TRANSACTION IMPORT_RESPONSE

	INSERT INTO dbo.surveyresponse
	([surveyGatewayObjectId],
	[ani],
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
	[offerCode],[reviewOptin],modeType,externalId,responseSourceObjectId)

	select	r.MS_SurveyGatewayId,
			case when isnumeric(r.inboundId) <> 1 then NULL else r.inboundId end as [ani],
			CONVERT(VARCHAR(10), r.ResponseDt, 110),
			1,
			case r.MS_offerId
			when 6269 then 10483
			when 6349 then 10614 end as surveyObjectId,
			1,
			1,
			CONVERT(VARCHAR(10), r.VisitDt, 110),
			dateadd(day,datediff(day,r.ResponseDt,'1900-01-01'),r.ResponseDt),
			r.ResponseDt,
			0,
			r.MS_locationId,
			r.MS_offerId,
			c.offerCode,--r.UnitCode,
			0,
			3,
			r.ResponseId,
			@ResponseSourceId
	from	putwh06.Import.dbo.ResponseHeader r with (nolock)
			inner join mindshare.dbo.OfferCode c with (nolock) on (r.MS_locationId = c.locationObjectId and r.MS_OfferId = c.offerObjectId and r.MS_SurveyGatewayId = c.surveyGatewayObjectId)
			inner join putwh06.Import.dbo.SourceType sot with (nolock) on (r.OrganizationId = sot.OrganizationId and r.ClientId = sot.ClientId and r.SourceId = sot.SourceId)
	where	r.ResponseId = @ResponseId and r.OrganizationId = @OrganizationId and r.ClientId = @ClientId and r.MS_SurveyResponseObjectId IS NULL
	if @@error <> 0 or @@rowcount = 0 or @@rowcount > 1
	begin
		print 'Error Inserting To SurveyResponse'
		rollback transaction IMPORT_RESPONSE
		return 1
	end

	set @MS_SurveyResponseObjectId = SCOPE_IDENTITY()
	
	-- Prepare for Additional Information
	declare @SurveyID int,@SourceDesc varchar(100),@SurveyLang varchar(20),@CertCode varchar(200),@VisitDT datetime,@ResponseDT datetime,@UnitCode varchar(200)
	select	@SurveyID = r.SurveyId,
			@SourceDesc = sot.SourceDesc,
			@SurveyLang = r.Lang,
			@CertCode = r.CertCode,
			@VisitDt = r.VisitDt,
			@ResponseDT = r.ResponseDt,
			@UnitCode = r.UnitCode
	from	putwh06.Import.dbo.ResponseHeader r with (nolock) 
			inner join putwh06.Import.dbo.SourceType sot with (nolock) on (r.OrganizationId = sot.OrganizationId and r.ClientId = sot.ClientId and r.SourceId = sot.SourceId)
	where	(r.ResponseId = @ResponseId and r.OrganizationId = @OrganizationId and r.ClientId = @ClientId)
	

			
	INSERT INTO dbo.SurveyResponseAnswer (surveyResponseObjectId,sequence,numericValue,textValue,dateValue,booleanValue,version,
				dataFieldObjectId,dataFieldOptionObjectId)
	OUTPUT inserted.objectId,inserted.dataFieldObjectId into @SRAIDs

	select	@MS_SurveyResponseObjectId,
			dense_rank() over (order by MS_dataFieldId,MS_dataFieldOptionId) - 1 as Sequence,
			case when MS_FieldType = 1 then AnswerValue else NULL end as numericValue,
			case when MS_FieldType in (2) then substring(AnswerValue,1,200) else NULL end as textValue,
			case when MS_FieldType in (3,46) then AnswerValue else NULL end as dateValue,
			case when MS_FieldType = 41 then AnswerValue else NULL end as booleanValue,
			1,
			MS_dataFieldId,
			MS_dataFieldOptionId
	from

	(



	-- Handle Additional Questions

select	@OrganizationId as OrganizationId,
		@ResponseId as ResponseId,
		rda.MS_fieldType,
		'' as QType,
		rda.MS_DataFieldName as QCode,
		-1 as QuestionId,
		case when rda.MS_DataFieldName = 'RESPONSE_ADD' then convert(varchar(4000),@ResponseId)
			 when rda.MS_DataFieldName = 'VISITDATE_ADD' then convert(varchar(4000),@VisitDt)
			 when rda.MS_DataFieldName = 'SURVEYDATE_ADD' then convert(varchar(4000),@ResponseDT)
			 when rda.MS_DataFieldName = 'CERTCODE_ADD' then convert(varchar(4000),@CertCode)
			 when rda.MS_DataFieldName = 'SOURCEID_ADD' then convert(varchar(4000),@SourceDesc)
			 when rda.MS_DataFieldName = 'LANGUAGE_ADD' then convert(varchar(4000),@SurveyLang)
			 when rda.MS_DataFieldName = 'SURVEYID_ADD' then convert(varchar(4000),@SurveyId)
			 when rda.MS_DataFieldName = 'UNITCODE_ADD' then convert(varchar(4000),@UnitCode)
			 else null end as AnswerValue,
		rda.QOrder,
		rda.AOrder,
		rda.MS_DataFieldId,
		rda.MS_DataFieldOptionId
from	putwh06.Import.dbo.ResponseDetail_Addition rda with (nolock)
where	rda.OrganizationId = @OrganizationId and rda.ClientId = @ClientId
		and MS_DataFieldOptionId is null

union all

select	@OrganizationId,
		@ResponseId,
		rda.MS_fieldType,
		'' as QType,
		rda.MS_DataFieldName as QCode,
		-1 as QuestionId,
		case when rda.MS_DataFieldName = 'RESPONSE_ADD' then convert(varchar(4000),@ResponseId)
			 when rda.MS_DataFieldName = 'VISITDATE_ADD' then convert(varchar(4000),@VisitDt)
			 when rda.MS_DataFieldName = 'SURVEYDATE_ADD' then convert(varchar(4000),@ResponseDT)
			 when rda.MS_DataFieldName = 'CERTCODE_ADD' then convert(varchar(4000),@CertCode)
			 when rda.MS_DataFieldName = 'SOURCEID_ADD' then convert(varchar(4000),@SourceDesc)
			 when rda.MS_DataFieldName = 'LANGUAGE_ADD' then convert(varchar(4000),@SurveyLang)
			 when rda.MS_DataFieldName = 'SURVEYID_ADD' then convert(varchar(4000),@SurveyId)
			 when rda.MS_DataFieldName = 'UNITCODE_ADD' then convert(varchar(4000),@UnitCode)
			 else null end as AnswerValue,
		rda.QOrder,
		rda.AOrder,
		rda.MS_DataFieldId,
		rda.MS_DataFieldOptionId
from	putwh06.Import.dbo.ResponseDetail_Addition rda with (nolock)
where	rda.OrganizationId = @OrganizationId and rda.ClientId = @ClientId
		and MS_DataFieldOptionId is not null
		and (MS_DataFieldOptionName = @SurveyLang or MS_DataFieldOptionName = convert(varchar(100),@SurveyId) or MS_DataFieldOptionName = @UnitCode 
			or MS_DataFieldOptionName = @SourceDesc)



	--
	union all

	select	rd.OrganizationId,
			rd.ResponseId,
			dm.MS_FieldType,
			dm.QType,
			dm.QCode,
			rd.QuestionId,
			case when dm.MS_FieldType = 41 THEN '1' ELSE convert(varchar(4000),rd.AnswerId) END as AnswerValue,
			dm.QOrder,
			dm.AOrder,
			dm.MS_DataFieldId,
			dm.MS_DataFieldOptionId
	from	putwh06.Import.dbo.DataFieldMap dm with (nolock)
			inner join putwh06.Import.dbo.ResponseDetailChoice rd with (nolock) on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId and dm.AnswerId = rd.AnswerId and dm.SurveyId = @SurveyId)
	where	rd.ResponseId = @ResponseId and rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId
			and dm.MS_DataFieldId is not null and dm.MS_FieldType <> 25

	union all

	select	rd.OrganizationId,
			rd.ResponseId,
			dm.MS_FieldType,
			dm.QType,
			dm.QCode,
			rd.QuestionId,
			rd.AnswerValue,
			dm.QOrder,
			dm.AOrder,
			dm.MS_DataFieldId,
			dm.MS_DataFieldOptionId
	from	putwh06.Import.dbo.DataFieldMap dm with (nolock)
			inner join putwh06.Import.dbo.ResponseDetailChoiceOther rd with (nolock) on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId and dm.SurveyId = @SurveyId)
	where	rd.ResponseId = @ResponseId and rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId
			and dm.MS_DataFieldId is not null and dm.MS_FieldType <> 25
			
	union all

	select	rd.OrganizationId,
			rd.ResponseId,
			dm.MS_FieldType,
			dm.QType,
			dm.QCode,
			rd.QuestionId,
			convert(varchar(4000),rd.AnswerValue) as AnswerValue,
			dm.QOrder,
			dm.AOrder,
			dm.MS_DataFieldId,
			dm.MS_DataFieldOptionId
	from	putwh06.Import.dbo.DataFieldMap dm with (nolock)
			inner join putwh06.Import.dbo.ResponseDetailChoiceQTy rd with (nolock) on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId and dm.AnswerId = rd.AnswerId and dm.SurveyId = @SurveyId)
	where	rd.ResponseId = @ResponseId and rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId
			and dm.MS_DataFieldId is not null and dm.MS_FieldType <> 25
	/*
	union all
	-- Handle Location-Related Choices

		select	rd.OrganizationId,
			rd.ResponseId,
			dm.MS_FieldType,
			dm.QType,
			dm.QCode,
			rd.QuestionId,
			rd.AnswerValue,
			dm.QOrder,
			dm.AOrder,
			dm.MS_DataFieldId,
			dm.MS_DataFieldOptionId
	from	putwh06.Import.dbo.DataFieldMap dm with (nolock)
			inner join DataField d with (nolock) on (dm.OrganizationId = d.organizationObjectId and dm.MS_DataFieldId = d.objectId and dm.MS_FieldType = 25)
			inner join LocationCategory l with (nolock) on (d.locationCategoryTypeObjectId = l.locationCategoryTypeObjectId and d.organizationObjectId = l.organizationObjectId)
			inner join putwh06.Import.dbo.ResponseDetailChoiceOther rd with (nolock) on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId and dm.SurveyId = @SurveyId)

	where	rd.ResponseId = @ResponseId and rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId
			and dm.MS_DataFieldId is not null 
			and rd.AnswerValue = l.name
	*/


	) AnswerBucket
	if @@error <> 0 or @@rowcount = 0
	begin
		print 'Error Inserting To SurveyResponseAnswer'
		rollback transaction IMPORT_RESPONSE
		return 2
	end

	if exists (select null from @SRAIDs s inner join putwh06.Import.dbo.DataFieldMap df with (nolock) on (s.dataFieldObjectId = df.MS_dataFieldId and df.OrganizationId = @OrganizationId and df.ClientId = @ClientId)
				where df.MS_fieldType = 5)
	begin
		-- Handle Comments
		INSERT INTO dbo.Comment (version,surveyResponseAnswerObjectId,commentType,commentText,commentTextLengthBytes,commentTextLengthChars,transcriptionState,audioContentType,commentLanguage)
		OUTPUT inserted.objectId,inserted.surveyResponseAnswerObjectId into @COMMENTIDs

		SELECT	1,ID_Filter.objectId,0,Answer_Filter.AnswerValue,datalength(Answer_Filter.AnswerValue),len(Answer_Filter.AnswerValue),0,0,case @SurveyLang when 'EN' then 1 when 'FR' then 2 when 'ES' then 4 else NULL end as commentLanguage
		FROM
		(
		select	s.objectId,s.dataFieldObjectId
		from	@SRAIDs s
				--inner join dbo.SurveyResponseAnswer sra with (nolock) on (s.objectId = sra.objectId)
				inner join dbo.DataField df with (nolock) on (s.dataFieldObjectId = df.objectId)
		where	df.fieldType = 5
		) ID_Filter
		inner join 
		(
			select	rd.OrganizationId,
				rd.ResponseId,
				dm.MS_FieldType,
				dm.QType,
				dm.QCode,
				rd.QuestionId,
				rd.AnswerValue,
				dm.QOrder,
				dm.AOrder,
				dm.MS_DataFieldId,
				dm.MS_DataFieldOptionId
		from	putwh06.Import.dbo.DataFieldMap dm with (nolock)
				inner join putwh06.Import.dbo.ResponseDetailChoiceOther rd with (nolock) on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId)
		where	rd.ResponseId = @ResponseId and rd.OrganizationId = @OrganizationId  and rd.ClientId = @ClientId and dm.MS_FieldType = 5 and dm.SurveyId = @SurveyID 
		) Answer_Filter on (ID_Filter.dataFieldObjectId = Answer_Filter.MS_DataFieldId)
		if @@error <> 0 
		begin
			print 'Error Inserting To Comment'
			rollback transaction IMPORT_RESPONSE
			return 3
		end

		UPDATE dbo.SurveyResponseAnswer
		SET binaryContentObjectId = c.objectId
		FROM @COMMENTIDs c
		WHERE	c.SRAID = dbo.SurveyResponseAnswer.objectId
		if @@error <> 0 
		begin
			print 'Error Updating binaryContentObjectId'
			rollback transaction IMPORT_RESPONSE
			return 5
		end
	end
			


	COMMIT TRANSACTION IMPORT_RESPONSE

	--BEGIN TRANSACTION UPDATE_RESPONSEID
	UPDATE putwh06.Import.dbo.ResponseHeader
		SET MS_SurveyResponseObjectId = @MS_SurveyResponseObjectId
	WHERE	OrganizationId = @OrganizationId and ClientId = @ClientId and ResponseId = @ResponseId
	if @@error <> 0 or @@rowcount = 0
	begin
		print 'Error Updating ResponseHeader'
		--rollback transaction UPDATE_RESPONSEID
		return 4
	end

	--COMMIT TRANSACTION IMPORT_RESPONSE
*/

	return 0


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

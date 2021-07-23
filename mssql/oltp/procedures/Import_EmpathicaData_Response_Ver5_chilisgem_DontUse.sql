SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		In-Kap Bang
-- Create date: 2014.04.09
-- Description:	Import Empathica Data
-- =============================================
CREATE PROCEDURE [dbo].[Import_EmpathicaData_Response_Ver5_chilisgem_DontUse]
@OrganizationId int,
@ClientId int,
@ResponseId int,
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
	[offerCode],[reviewOptin],modeType,msrepl_tran_version)

	select	r.MS_SurveyGatewayId,
			case when isnumeric(r.inboundId) <> 1 then NULL else r.inboundId end as [ani],
			CONVERT(VARCHAR(10), r.ResponseDt, 110),
			1,
			case r.MS_offerId when 4599 then 8403
					when 5099 then 7475 end,
			1,
			1,
			CONVERT(VARCHAR(10), r.VisitDt, 110),
			dateadd(day,datediff(day,r.ResponseDt,'1990-01-01'),r.ResponseDt),
			r.ResponseDt,
			0,
			r.MS_locationId,
			r.MS_offerId,
			r.UnitCode,
			0,
			3,
			newid()
	from	putwh01.Import.dbo.ResponseHeader r with (nolock)
			--inner join putwh01.Import.dbo.SourceType sot with (nolock) on (r.OrganizationId = sot.OrganizationId and r.ClientId = sot.ClientId and r.SourceId = sot.SourceId)
	where	r.ResponseId = @ResponseId and r.OrganizationId = @OrganizationId and r.ClientId = @ClientId and r.MS_SurveyResponseObjectId IS NULL
	if @@error <> 0 or @@rowcount = 0
	begin
		print 'Error Inserting To SurveyResponse'
		rollback transaction IMPORT_RESPONSE
		return 1
	end

	set @MS_SurveyResponseObjectId = SCOPE_IDENTITY()
	
	-- Prepare for Additional Information
	declare @SurveyID int,@SourceDesc varchar(100),@SurveyLang varchar(20),@CertCode varchar(200),@VisitDT datetime
	select	@SurveyID = r.SurveyId,
			@SourceDesc = sot.SourceDesc,
			@SurveyLang = r.Lang,
			@CertCode = r.CertCode,
			@VisitDt = r.VisitDt
	from	putwh01.Import.dbo.ResponseHeader r with (nolock) 
			inner join putwh01.Import.dbo.SourceType sot with (nolock) on (r.OrganizationId = sot.OrganizationId and r.ClientId = sot.ClientId and r.SourceId = sot.SourceId)
	where	(r.ResponseId = @ResponseId and r.OrganizationId = @OrganizationId and r.ClientId = @ClientId)
	
	-- Capture REASON
	declare @REASONVAL int
	select	@REASONVAL = case when AnswerId in (1,2,3) then AnswerId else -1 end 
	from	putwh01.Import.dbo.ResponseDetailChoice with (nolock) 
	where	OrganizationId = @OrganizationId and ClientId = @ClientId and ResponseId = @ResponseId and QuestionId = 1

			
	INSERT INTO dbo.SurveyResponseAnswer (surveyResponseObjectId,msrepl_tran_version,sequence,numericValue,textValue,dateValue,booleanValue,version,
				dataFieldObjectId,dataFieldOptionObjectId)
	OUTPUT inserted.objectId,inserted.dataFieldObjectId into @SRAIDs

	select	@MS_SurveyResponseObjectId,
			newid(),
			dense_rank() over (order by QOrder,AOrder) - 1 as Sequence,
			case when MS_FieldType = 1 then AnswerValue else NULL end as numericValue,
			case when MS_FieldType = 2 then AnswerValue else NULL end as textValue,
			case when MS_FieldType in (3,7,46) then AnswerValue else NULL end as dateValue,
			case when MS_FieldType = 41 then AnswerValue else NULL end as booleanValue,
			1,
			MS_dataFieldId,
			MS_dataFieldOptionId
	from

	(
	-- Handle Additional Questions
	-- Response ID
	select	@OrganizationId as OrganizationId,
			@ResponseId as ResponseId,
			rda.MS_fieldType,
			'' as QType,
			rda.MS_DataFieldName as QCode,
			-1 as QuestionId,
			case when rda.MS_fieldType = 41 then '1' ELSE convert(varchar(4000),@ResponseId) END as AnswerValue,
			rda.QOrder,
			rda.AOrder,
			rda.MS_DataFieldId,
			rda.MS_DataFieldOptionId
	from	putwh01.Import.dbo.ResponseDetail_Addition rda with (nolock)
	where	rda.OrganizationId = @OrganizationId and rda.ClientId = @ClientId
			and rda.MS_DataFieldName = 'Response ID'

	union all
	-- Survey ID
	select	@OrganizationId,
			@ResponseId,
			rda.MS_fieldType,
			'' as QType,
			rda.MS_DataFieldName as QCode,
			-1 as QuestionId,
			case when rda.MS_fieldType = 41 then '1' ELSE convert(varchar(4000),@SurveyID) END as AnswerValue,
			rda.QOrder,
			rda.AOrder,
			rda.MS_DataFieldId,
			rda.MS_DataFieldOptionId
	from	putwh01.Import.dbo.ResponseDetail_Addition rda with (nolock)
	where	rda.OrganizationId = @OrganizationId and rda.ClientId = @ClientId
			and rda.MS_DataFieldName = 'Survey ID'
			and rda.MS_DataFieldOptionName = @SurveyID

	union all
	-- Source ID (MC)
	select	@OrganizationId,
			@ResponseId,
			rda.MS_fieldType,
			'' as QType,
			rda.MS_DataFieldName as QCode,
			-1 as QuestionId,
			case when rda.MS_fieldType = 41 then '1' ELSE convert(varchar(4000),@SourceDesc) END as AnswerValue,
			rda.QOrder,
			rda.AOrder,
			rda.MS_DataFieldId,
			rda.MS_DataFieldOptionId
	from	putwh01.Import.dbo.ResponseDetail_Addition rda with (nolock)
	where	rda.OrganizationId = @OrganizationId and rda.ClientId = @ClientId
			and rda.MS_DataFieldName = 'Source ID (MC)'
			and rda.MS_DataFieldOptionName = @SourceDesc

	union all
	-- Survey Language
	select	@OrganizationId,
			@ResponseId,
			rda.MS_fieldType,
			'' as QType,
			rda.MS_DataFieldName as QCode,
			-1 as QuestionId,
			case when rda.MS_fieldType = 41 then '1' ELSE convert(varchar(4000),@SurveyLang) END as AnswerValue,
			rda.QOrder,
			rda.AOrder,
			rda.MS_DataFieldId,
			rda.MS_DataFieldOptionId
	from	putwh01.Import.dbo.ResponseDetail_Addition rda with (nolock)
	where	rda.OrganizationId = @OrganizationId and rda.ClientId = @ClientId
			and rda.MS_DataFieldName = 'Survey Language'
			and rda.MS_DataFieldOptionName = @SurveyLang


	union all

	  -- Response ID
	select	@OrganizationId,
			@ResponseId,
			rda.MS_fieldType,
			'' as QType,
			rda.MS_DataFieldName as QCode,
			-1 as QuestionId,
			case when rda.MS_fieldType = 41 then '1' ELSE convert(varchar(4000),@CertCode) END as AnswerValue,
			rda.QOrder,
			rda.AOrder,
			rda.MS_DataFieldId,
			rda.MS_DataFieldOptionId
	from	putwh01.Import.dbo.ResponseDetail_Addition rda with (nolock)
	where	rda.OrganizationId = @OrganizationId and rda.ClientId = @ClientId
			and rda.MS_DataFieldName = 'Certificate'


	union all

	  -- Date of Service
	select	@OrganizationId,
			@ResponseId,
			rda.MS_fieldType,
			'' as QType,
			rda.MS_DataFieldName as QCode,
			-1 as QuestionId,
			case when rda.MS_fieldType = 41 then '1' ELSE convert(varchar(4000),@VisitDt) END as AnswerValue,
			rda.QOrder,
			rda.AOrder,
			rda.MS_DataFieldId,
			rda.MS_DataFieldOptionId
	from	putwh01.Import.dbo.ResponseDetail_Addition rda with (nolock)
	where	rda.OrganizationId = @OrganizationId and rda.ClientId = @ClientId
			and rda.MS_DataFieldName = 'Date of Service'
	--
	union all

	--/*
	---- handle all non SR_PROBLEM and SR_PROBLEM_OPP for SurveyID 1
	--select	rd.OrganizationId,
	--		rd.ResponseId,
	--		dm.MS_FieldType,
	--		dm.QType,
	--		dm.QCode,
	--		rd.QuestionId,
	--		case when dm.MS_FieldType = 41 THEN '1' ELSE convert(varchar(4000),rd.AnswerId) END as AnswerValue,
	--		dm.QOrder,
	--		dm.AOrder,
	--		dm.MS_DataFieldId,
	--		dm.MS_DataFieldOptionId
	--from	putwh01.Import.dbo.DataFieldMap dm with (nolock) 
	--		inner join (select OrganizationId,ClientId,ResponseId,QuestionId,AnswerId from putwh01.Import.dbo.ResponseDetailChoice with (nolock) where OrganizationId = @OrganizationId and ClientId = @ClientId and ResponseId = @ResponseId) rd on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId and dm.AnswerId = rd.AnswerId and dm.SurveyId = @SurveyId)
	--where	--rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId and rd.ResponseId = @ResponseId
	--		(dm.MS_DataFieldId is not null
	--		and ((dm.QCode not in ('SR_PROBLEM','SR_PROBLEM_OPP') and dm.SurveyId = 1) or (dm.SurveyId <> 1)))
	--		--and rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId and rd.ResponseId = @ResponseId
	

	
	--	-- handle all non SR_PROBLEM and SR_PROBLEM_OPP for SurveyID 1
	--select	rd.OrganizationId,
	--		rd.ResponseId,
	--		dm.MS_FieldType,
	--		dm.QType,
	--		dm.QCode,
	--		rd.QuestionId,
	--		case when dm.MS_FieldType = 41 THEN '1' ELSE convert(varchar(4000),rd.AnswerId) END as AnswerValue,
	--		dm.QOrder,
	--		dm.AOrder,
	--		dm.MS_DataFieldId,
	--		dm.MS_DataFieldOptionId
	--from	putwh01.Import.dbo.DataFieldMap dm with (nolock) 
	--		inner hash join (select OrganizationId,ClientId,ResponseId,QuestionId,AnswerId from putwh01.Import.dbo.ResponseDetailChoice with (nolock) where OrganizationId = @OrganizationId and ClientId = @ClientId and ResponseId = @ResponseId) rd   on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId and dm.AnswerId = rd.AnswerId and dm.SurveyId = @SurveyId)
	--where	--rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId and rd.ResponseId = @ResponseId
	--		(dm.MS_DataFieldId is not null
	--		and ((dm.QuestionId not in (127,527) and dm.SurveyId = 1) or (dm.SurveyId <> 1)))
	--		and rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId and rd.ResponseId = @ResponseId
	--*/
	-- handle all non SR_PROBLEM and SR_PROBLEM_OPP for SurveyID 1
	select	rd.OrganizationId,
			rd.ResponseId,
			rd.MS_FieldType,
			rd.QType,
			rd.QCode,
			rd.QuestionId,
			case when rd.MS_FieldType = 41 then '1' else convert(varchar(4000),rd.AnswerId) end as AnswerValue,
			rd.QOrder,
			rd.AOrder,
			rd.MS_DataFieldId,
			rd.MS_DataFieldOptionId
	from	putwh01.Import.dbo.v_ResponseDetailChoice rd with (nolock,noexpand)
	where	((rd.QuestionId not in (127,527) and rd.SurveyId = 1) or (rd.SurveyId <> 1))
			and rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId and rd.ResponseId = @ResponseId

	union all

	-- handle specific SR_PROBLEM/SR_PROBLEM_OPP for SurveyID 1

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
	from	putwh01.Import.dbo.DataFieldMap_Supplement dm with (nolock)
			inner join putwh01.Import.dbo.ResponseDetailChoice rd with (nolock) on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId and dm.AnswerId = rd.AnswerId and dm.SurveyId = @SurveyId)
	where	rd.ResponseId = @ResponseId and rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId
			and dm.MS_DataFieldId is not null
			and dm.REASONVAL = @REASONVAL
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
	from	putwh01.Import.dbo.DataFieldMap dm with (nolock)
			inner join putwh01.Import.dbo.ResponseDetailChoiceOther rd with (nolock) on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId and dm.SurveyId = @SurveyId)
	where	rd.ResponseId = @ResponseId and rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId
			and dm.MS_DataFieldId is not null
			
	union all

	select	rd.OrganizationId,
			rd.ResponseId,
			dm.MS_FieldType,
			dm.QType,
			dm.QCode,
			rd.QuestionId,
			convert(varchar(4000),rd.AnswerValue) as AnswerValue,
			dm.QOrder,
			1,
			dm.MS_DataFieldId,
			dm.MS_DataFieldOptionId
	from	putwh01.Import.dbo.DataFieldMap dm with (nolock)
			inner join putwh01.Import.dbo.ResponseDetailChoiceQTy rd with (nolock) on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId and dm.AnswerId = rd.AnswerId and dm.SurveyId = @SurveyId)
	where	rd.ResponseId = @ResponseId and rd.OrganizationId = @OrganizationId and rd.ClientId = @ClientId
			and dm.MS_DataFieldId is not null
	) AnswerBucket
	if @@error <> 0 or @@rowcount = 0
	begin
		print 'Error Inserting To SurveyResponseAnswer'
		rollback transaction IMPORT_RESPONSE
		return 2
	end

	if exists (select null from @SRAIDs s inner join putwh01.Import.dbo.DataFieldMap df with (nolock) on (s.dataFieldObjectId = df.MS_dataFieldId and df.OrganizationId = @OrganizationId and df.ClientId = @ClientId)
				where df.MS_fieldType = 5)
	begin
		-- Handle Comments
		INSERT INTO dbo.Comment (msrepl_tran_version,version,surveyResponseAnswerObjectId,commentType,commentText,commentTextLengthBytes,commentTextLengthChars,transcriptionState,audioContentType)
		OUTPUT inserted.objectId,inserted.surveyResponseAnswerObjectId into @COMMENTIDs

		SELECT	newid(),1,ID_Filter.objectId,0,Answer_Filter.AnswerValue,datalength(Answer_Filter.AnswerValue),len(Answer_Filter.AnswerValue),0,0
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
		from	putwh01.Import.dbo.DataFieldMap dm with (nolock)
				inner join putwh01.Import.dbo.ResponseDetailChoiceOther rd with (nolock) on (dm.OrganizationId = rd.OrganizationId and dm.ClientId = rd.ClientId and dm.QuestionId = rd.QuestionId)
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
	UPDATE putwh01.Import.dbo.ResponseHeader
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

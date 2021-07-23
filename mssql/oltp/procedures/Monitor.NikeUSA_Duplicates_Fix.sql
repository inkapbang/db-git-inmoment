SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [Monitor].[NikeUSA_Duplicates_Fix]
--ALTER Procedure Monitor.[NikeUSA_Duplicates_Opsview]
	(	@responseId		int )
AS
/**************************************  Nike USA Duplicates  **************************************
	
		-- Fix latest duplicate redemption code for Nike USA
		
	History:
		6.26.2015	BJ Tenney
			-- Wrote and Tested


	EXEC [Monitor].[NikeUSA_Duplicates_Fix]
		@responseId	= 1
			

*****************************************************************************************************/
--DECLARE @responseId		int
--SET @responseId=1
		DECLARE @code varchar(50)
		update top(1) RedemptionCodeCustom with (rowlock)
			set @code = redemptionCode, activationDate=getDate()
			where organizationObjectId = 1283 and market='NkUSA' and activationDate is null
		Update SurveyResponseAnswer set textValue=SUBSTRING(@code, 1, 19) where dataFieldObjectId=140582 and surveyResponseObjectId=@responseId
		--pin--
		Update SurveyResponseAnswer set textValue=SUBSTRING(@code, 20, 6) where dataFieldObjectId=140583 and surveyResponseObjectId=@responseId
		--select top 1 @code=redemptionCode from Doctor.Mindshare.dbo.RedemptionCodeCustom  where organizationObjectId = 1283 and market='NkUSA' and activationDate is null
	
	--print @code
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

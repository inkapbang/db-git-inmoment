SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Import_Empathica_Pizzahut_OVRECOM_DUPLICATE]
@SurveyResponseObjectId int,
@dataFieldObjectId int,
@dataFieldOptionObjectId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @maxSequence int
	
	select @maxSequence = max(sequence) from SurveyResponseAnswer with (nolock) where surveyResponseObjectId = @SurveyResponseObjectId
	if @@error <> 0 or @@rowcount = 0 or @maxSequence is null return 1

	
	insert into SurveyResponseAnswer (surveyResponseObjectId,binaryContentObjectId,sequence,numericValue,textValue,dateValue,booleanValue,version,dataFieldObjectId,dataFieldOptionObjectId,encrypted,encryptiontype)
		values (@SurveyResponseObjectId,NULL,@maxSequence+1,NULL,NULL,NULL,NULL,0,@dataFieldObjectId,@dataFieldOptionObjectId,NULL,0)
	if (@@error = 0 and @@rowcount = 1) return 0
	else return 1



END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

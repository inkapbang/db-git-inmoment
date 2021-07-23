SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Import_Empathica_Update_ResponseSourceID]
@SurveyResponseObjectId int,
@RSID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @error int,@rowcnt int

	update SurveyResponse
		set responseSourceObjectId = @RSID
	where	objectId = @SurveyResponseObjectId --and responseSourceObjectId is null
	select @error = @@error,@rowcnt = @@rowcount

	--print 'SRID: '+convert(varchar(100),@SurveyResponseObjectId)+' RSID: '+convert(varchar(100),@RSID) + 'rowcount: '+convert(varchar(100),@rowcnt)

	if (@error = 0) return 0 else return 1


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

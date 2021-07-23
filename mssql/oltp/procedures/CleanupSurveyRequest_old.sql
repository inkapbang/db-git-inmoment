SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create PROCEDURE [dbo].[CleanupSurveyRequest_old] as
begin
	delete from SurveyRequest  with (rowlock) where purgeTime < GetDate()
	update SurveyRequest with (rowlock) set state = 3, failurereason = 7, failuremessage = 'Request automatically expired.', version = version + 1 where (not state = 3) and expirationTime < GETDATE()
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

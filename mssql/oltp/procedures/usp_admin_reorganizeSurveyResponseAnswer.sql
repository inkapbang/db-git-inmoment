SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure usp_admin_reorganizeSurveyResponseAnswer
as
begin try
	ALTER INDEX ALL ON surveyresponseanswer reorganize
end try
BEGIN CATCH
Select ERROR_NUMBER() AS ErrorNumber,
       ERROR_SEVERITY() AS ErrorSeverity,
       ERROR_STATE() AS ErrorState,
       ERROR_PROCEDURE() AS ErrorProcedure,
       ERROR_LINE() AS ErrorLine,
       ERROR_MESSAGE() AS ErrorMessage
END CATCH
return
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

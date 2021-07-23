SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc SetSystemEnabled (@enabled int)
as
begin
	update GlobalSettings set voiceSurveyEnabled = @enabled, webSurveyEnabled = @enabled, reportingEnabled = @enabled
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

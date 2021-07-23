SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE trigger [dbo].[Survey_After_Delete] on [dbo].[Survey]
FOR DELETE
NOT FOR REPLICATION 
AS
BEGIN
	DECLARE @surveyObjectId AS INT;
	SELECT @surveyObjectId = objectId from deleted;
	DELETE FROM OfferSurvey WHERE surveyObjectId = @surveyObjectId;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[Survey_After_Delete] ON [dbo].[Survey]
GO

GO

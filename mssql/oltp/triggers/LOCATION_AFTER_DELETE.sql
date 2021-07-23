SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[LOCATION_AFTER_DELETE] on [dbo].[Location] AFTER DELETE 
NOT FOR REPLICATION
AS
BEGIN
	DECLARE @locationObjectId INT;
	SELECT @locationObjectId = objectId FROM deleted;
	DELETE FROM LocationCategoryLocation WHERE locationObjectId = @locationObjectId;
	DELETE FROM UserAccountLocation WHERE locationObjectId = @locationObjectId;
	DELETE FROM OfferCode WHERE locationObjectId = @locationObjectId;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[LOCATION_AFTER_DELETE] ON [dbo].[Location]
GO

GO

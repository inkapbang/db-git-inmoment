SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  TRIGGER [dbo].[OrganizationUserAccountDelete] ON [dbo].[OrganizationUserAccount]
FOR DELETE
NOT FOR REPLICATION 
AS
BEGIN
	DECLARE dc CURSOR LOCAL FOR
		SELECT userAccountObjectId, organizationObjectId FROM DELETED
	DECLARE @userId INT, @orgId INT
	OPEN dc
	FETCH NEXT FROM dc INTO @userId, @orgId
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DELETE FROM UserAccountLocation
			WHERE userAccountObjectId = @userId
				AND locationObjectId IN
					(SELECT objectId FROM Location WHERE organizationObjectId = @orgId)
		FETCH NEXT FROM dc INTO @userId, @orgId
	END
	CLOSE dc
	DEALLOCATE dc
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[OrganizationUserAccountDelete] ON [dbo].[OrganizationUserAccount]
GO

GO

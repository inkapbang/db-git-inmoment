SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--Delete System Announments that have reached "deployment" a month or more ago
CREATE TRIGGER truncate_SystemAnnouncementUserAccount
ON [SystemAnnouncementUserAccount]
AFTER INSERT AS
Begin
    DELETE SystemAnnouncementUserAccount FROM SystemAnnouncementUserAccount 
	LEFT JOIN SystemAnnouncement ON SystemAnnouncementUserAccount.systemAnnouncementObjectId = SystemAnnouncement.objectId
	WHERE SystemAnnouncementUserAccount.userAccountObjectId IN (select userAccountObjectId from INSERTED)
	AND SystemAnnouncement.downtimeStartDateTime < DateAdd(mm, -1, GETDATE())  
End
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[truncate_SystemAnnouncementUserAccount] ON [dbo].[SystemAnnouncementUserAccount]
GO

GO

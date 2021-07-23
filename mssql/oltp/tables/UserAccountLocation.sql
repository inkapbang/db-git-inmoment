CREATE TABLE [dbo].[UserAccountLocation] (
   [userAccountObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_UserAccountLocation] PRIMARY KEY CLUSTERED ([userAccountObjectId], [locationObjectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_UserAccountLocation_Location_UserAccount] ON [dbo].[UserAccountLocation] ([locationObjectId], [userAccountObjectId])

GO

CREATE TABLE [dbo].[UserAccountState] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [userObjectId] [int] NOT NULL,
   [dashboardObjectId] [int] NULL,
   [dashboardMapObjectId] [int] NULL

   ,CONSTRAINT [PK_UserAccountState] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_UserAccountState_dashboardObjectId] ON [dbo].[UserAccountState] ([dashboardObjectId])
CREATE NONCLUSTERED INDEX [IX_UserAccountState_userObjectId] ON [dbo].[UserAccountState] ([userObjectId])

GO

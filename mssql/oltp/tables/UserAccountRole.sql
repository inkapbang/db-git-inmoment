CREATE TABLE [dbo].[UserAccountRole] (
   [userAccountObjectId] [int] NOT NULL,
   [role] [int] NOT NULL

   ,CONSTRAINT [PK_UserAccountRole] PRIMARY KEY CLUSTERED ([userAccountObjectId], [role])
)


GO

CREATE TABLE [dbo].[UserAccountRoleSocHistory] (
   [userAccountObjectId] [int] NOT NULL,
   [role] [int] NOT NULL,
   [dt] [datetime] NULL
       DEFAULT (getdate())

   ,CONSTRAINT [PK_UserAccountRoleSocHist] PRIMARY KEY CLUSTERED ([userAccountObjectId], [role])
)


GO

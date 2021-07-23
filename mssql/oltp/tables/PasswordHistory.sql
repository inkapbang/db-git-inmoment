CREATE TABLE [dbo].[PasswordHistory] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [userAccountObjectId] [int] NOT NULL,
   [password] [nvarchar](150) NOT NULL,
   [date] [datetime] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [passwordHash] [nvarchar](150) NOT NULL

   ,CONSTRAINT [PK_PasswordHistory] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PasswordHistory_UseraccountObjectidDate] ON [dbo].[PasswordHistory] ([userAccountObjectId], [date]) INCLUDE ([password], [version])

GO

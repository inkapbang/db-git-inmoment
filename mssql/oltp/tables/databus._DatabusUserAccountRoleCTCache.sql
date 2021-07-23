CREATE TABLE [databus].[_DatabusUserAccountRoleCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [userAccountObjectId] [int] NOT NULL,
   [role] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUserAccountRoleCTCache_userAccountObjectId_role] PRIMARY KEY CLUSTERED ([userAccountObjectId], [role])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUserAccountRoleCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUserAccountRoleCTCache] ([ctVersion], [ctSurrogateKey])

GO

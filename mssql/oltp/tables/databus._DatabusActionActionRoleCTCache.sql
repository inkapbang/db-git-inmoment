CREATE TABLE [databus].[_DatabusActionActionRoleCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [actionObjectId] [int] NOT NULL,
   [actionRoleObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusActionActionRoleCTCache_actionObjectId_actionRoleObjectId] PRIMARY KEY CLUSTERED ([actionObjectId], [actionRoleObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusActionActionRoleCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusActionActionRoleCTCache] ([ctVersion], [ctSurrogateKey])

GO

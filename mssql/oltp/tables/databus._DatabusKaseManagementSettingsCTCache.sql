CREATE TABLE [databus].[_DatabusKaseManagementSettingsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusKaseManagementSettingsCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusKaseManagementSettingsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusKaseManagementSettingsCTCache] ([ctVersion], [ctSurrogateKey])

GO

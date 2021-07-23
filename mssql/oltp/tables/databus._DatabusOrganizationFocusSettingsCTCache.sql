CREATE TABLE [databus].[_DatabusOrganizationFocusSettingsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationFocusSettingsCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationFocusSettingsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationFocusSettingsCTCache] ([ctVersion], [ctSurrogateKey])

GO

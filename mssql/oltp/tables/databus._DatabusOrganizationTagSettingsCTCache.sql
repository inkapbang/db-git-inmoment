CREATE TABLE [databus].[_DatabusOrganizationTagSettingsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationTagSettingsCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationTagSettingsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationTagSettingsCTCache] ([ctVersion], [ctSurrogateKey])

GO

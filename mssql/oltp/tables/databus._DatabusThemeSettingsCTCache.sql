CREATE TABLE [databus].[_DatabusThemeSettingsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusThemeSettingsCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusThemeSettingsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusThemeSettingsCTCache] ([ctVersion], [ctSurrogateKey])

GO

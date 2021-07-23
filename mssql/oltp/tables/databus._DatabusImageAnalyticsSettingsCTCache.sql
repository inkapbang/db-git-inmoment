CREATE TABLE [databus].[_DatabusImageAnalyticsSettingsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusImageAnalyticsSettingsCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusImageAnalyticsSettingsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusImageAnalyticsSettingsCTCache] ([ctVersion], [ctSurrogateKey])

GO

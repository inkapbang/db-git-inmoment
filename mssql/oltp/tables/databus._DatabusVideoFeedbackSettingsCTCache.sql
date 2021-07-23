CREATE TABLE [databus].[_DatabusVideoFeedbackSettingsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusVideoFeedbackSettingsCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusVideoFeedbackSettingsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusVideoFeedbackSettingsCTCache] ([ctVersion], [ctSurrogateKey])

GO

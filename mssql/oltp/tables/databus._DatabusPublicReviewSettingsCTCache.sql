CREATE TABLE [databus].[_DatabusPublicReviewSettingsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPublicReviewSettingsCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPublicReviewSettingsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPublicReviewSettingsCTCache] ([ctVersion], [ctSurrogateKey])

GO

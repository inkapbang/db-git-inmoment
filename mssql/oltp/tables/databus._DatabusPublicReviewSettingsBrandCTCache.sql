CREATE TABLE [databus].[_DatabusPublicReviewSettingsBrandCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [publicReviewSettingsObjectId] [int] NOT NULL,
   [brandObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPublicReviewSettingsBrandCTCache_publicReviewSettingsObjectId_brandObjectId] PRIMARY KEY CLUSTERED ([publicReviewSettingsObjectId], [brandObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPublicReviewSettingsBrandCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPublicReviewSettingsBrandCTCache] ([ctVersion], [ctSurrogateKey])

GO

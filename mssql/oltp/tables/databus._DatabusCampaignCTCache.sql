CREATE TABLE [databus].[_DatabusCampaignCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusCampaignCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusCampaignCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusCampaignCTCache] ([ctVersion], [ctSurrogateKey])

GO

CREATE TABLE [databus].[_DatabusCampaignUnsubscribeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusCampaignUnsubscribeCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusCampaignUnsubscribeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusCampaignUnsubscribeCTCache] ([ctVersion], [ctSurrogateKey])

GO

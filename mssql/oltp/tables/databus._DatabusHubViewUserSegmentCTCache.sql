CREATE TABLE [databus].[_DatabusHubViewUserSegmentCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [hubViewObjectId] [int] NOT NULL,
   [segmentObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusHubViewUserSegmentCTCache_hubViewObjectId_segmentObjectId] PRIMARY KEY CLUSTERED ([hubViewObjectId], [segmentObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusHubViewUserSegmentCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusHubViewUserSegmentCTCache] ([ctVersion], [ctSurrogateKey])

GO

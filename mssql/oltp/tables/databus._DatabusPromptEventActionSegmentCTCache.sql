CREATE TABLE [databus].[_DatabusPromptEventActionSegmentCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventActionId] [int] NOT NULL,
   [segmentObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventActionSegmentCTCache_promptEventActionId_segmentObjectId] PRIMARY KEY CLUSTERED ([promptEventActionId], [segmentObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventActionSegmentCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventActionSegmentCTCache] ([ctVersion], [ctSurrogateKey])

GO

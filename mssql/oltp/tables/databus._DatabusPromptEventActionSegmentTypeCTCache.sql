CREATE TABLE [databus].[_DatabusPromptEventActionSegmentTypeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventActionObjectId] [int] NOT NULL,
   [segmentTypeObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventActionSegmentTypeCTCache_promptEventActionObjectId_segmentTypeObjectId] PRIMARY KEY CLUSTERED ([promptEventActionObjectId], [segmentTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventActionSegmentTypeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventActionSegmentTypeCTCache] ([ctVersion], [ctSurrogateKey])

GO

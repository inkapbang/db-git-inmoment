CREATE TABLE [databus].[_DatabusTranscriptionConfidenceLevelCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusTranscriptionConfidenceLevelCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusTranscriptionConfidenceLevelCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusTranscriptionConfidenceLevelCTCache] ([ctVersion], [ctSurrogateKey])

GO

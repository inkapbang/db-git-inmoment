CREATE TABLE [databus].[_DatabusDataFieldTranscriptionPromptCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [dataFieldObjectId] [int] NOT NULL,
   [promptObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDataFieldTranscriptionPromptCTCache_dataFieldObjectId_promptObjectId] PRIMARY KEY CLUSTERED ([dataFieldObjectId], [promptObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDataFieldTranscriptionPromptCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDataFieldTranscriptionPromptCTCache] ([ctVersion], [ctSurrogateKey])

GO

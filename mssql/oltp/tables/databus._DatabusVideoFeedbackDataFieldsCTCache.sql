CREATE TABLE [databus].[_DatabusVideoFeedbackDataFieldsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [videoFeedbackPromptObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusVideoFeedbackDataFieldsCTCache_videoFeedbackPromptObjectId_dataFieldObjectId] PRIMARY KEY CLUSTERED ([videoFeedbackPromptObjectId], [dataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusVideoFeedbackDataFieldsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusVideoFeedbackDataFieldsCTCache] ([ctVersion], [ctSurrogateKey])

GO

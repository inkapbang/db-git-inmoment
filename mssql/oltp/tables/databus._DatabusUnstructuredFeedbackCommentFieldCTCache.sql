CREATE TABLE [databus].[_DatabusUnstructuredFeedbackCommentFieldCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [dataFieldObjectId] [int] NOT NULL,
   [unstructuredFeedbackModelObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUnstructuredFeedbackCommentFieldCTCache_dataFieldObjectId_unstructuredFeedbackModelObjectId_sequence] PRIMARY KEY CLUSTERED ([dataFieldObjectId], [unstructuredFeedbackModelObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUnstructuredFeedbackCommentFieldCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUnstructuredFeedbackCommentFieldCTCache] ([ctVersion], [ctSurrogateKey])

GO

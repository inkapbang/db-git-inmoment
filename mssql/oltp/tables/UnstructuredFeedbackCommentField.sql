CREATE TABLE [dbo].[UnstructuredFeedbackCommentField] (
   [dataFieldObjectId] [int] NOT NULL,
   [unstructuredFeedbackModelObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_UnstructuredFeedbackComment] PRIMARY KEY CLUSTERED ([dataFieldObjectId], [unstructuredFeedbackModelObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX_UnstructuredFeedbackCommentField_unstructuredFeedbackModelObjectId] ON [dbo].[UnstructuredFeedbackCommentField] ([unstructuredFeedbackModelObjectId])

GO

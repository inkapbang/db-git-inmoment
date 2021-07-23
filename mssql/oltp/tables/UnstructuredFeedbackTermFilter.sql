CREATE TABLE [dbo].[UnstructuredFeedbackTermFilter] (
   [unstructuredFeedbackModelObjectId] [int] NOT NULL,
   [termFilterObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_UnstructuredFeedbackTermFilter] PRIMARY KEY CLUSTERED ([unstructuredFeedbackModelObjectId], [termFilterObjectId])
)

CREATE NONCLUSTERED INDEX [IX_UnstructuredFeedbackTermFilter_termFilterObjectId] ON [dbo].[UnstructuredFeedbackTermFilter] ([termFilterObjectId])

GO

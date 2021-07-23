CREATE TABLE [dbo].[FeedbackChannelResponseFilterDataField] (
   [feedbackChannelObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_FeedbackChannelResponseFilterDataField] PRIMARY KEY CLUSTERED ([feedbackChannelObjectId], [dataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_FeedbackChannelResponseFilterDataField_DataField] ON [dbo].[FeedbackChannelResponseFilterDataField] ([dataFieldObjectId])

GO

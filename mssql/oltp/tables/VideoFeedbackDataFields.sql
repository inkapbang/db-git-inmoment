CREATE TABLE [dbo].[VideoFeedbackDataFields] (
   [videoFeedbackPromptObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL

   ,CONSTRAINT [PK__VideoFee__EBA1F6E13CD0DE62] PRIMARY KEY CLUSTERED ([videoFeedbackPromptObjectId], [dataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_VideoFeedbackDataFields_dataFieldObjectId] ON [dbo].[VideoFeedbackDataFields] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_VideoFeedbackDataFields_videoFeedbackPromptObjectId] ON [dbo].[VideoFeedbackDataFields] ([videoFeedbackPromptObjectId])

GO

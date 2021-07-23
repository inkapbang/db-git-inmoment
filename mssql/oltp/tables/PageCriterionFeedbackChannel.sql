CREATE TABLE [dbo].[PageCriterionFeedbackChannel] (
   [pageCriterionObjectId] [int] NOT NULL,
   [feedbackChannelObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_ReportCriterionFeedbackChannel] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [feedbackChannelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionFeedbackChannel_feedbackChannelObjectId] ON [dbo].[PageCriterionFeedbackChannel] ([feedbackChannelObjectId])

GO

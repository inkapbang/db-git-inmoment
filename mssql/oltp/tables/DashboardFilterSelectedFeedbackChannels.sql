CREATE TABLE [dbo].[DashboardFilterSelectedFeedbackChannels] (
   [dashboardFilterId] [int] NOT NULL,
   [feedbackChannelId] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardFilterSelectedFeedbackChannels] PRIMARY KEY CLUSTERED ([dashboardFilterId], [feedbackChannelId])
)

CREATE NONCLUSTERED INDEX [IX_DFSFeedbackChannels_DashboardFilterId] ON [dbo].[DashboardFilterSelectedFeedbackChannels] ([dashboardFilterId])
CREATE NONCLUSTERED INDEX [IX_DFSFeedbackChannels_FeedbackChannelId] ON [dbo].[DashboardFilterSelectedFeedbackChannels] ([feedbackChannelId])

GO

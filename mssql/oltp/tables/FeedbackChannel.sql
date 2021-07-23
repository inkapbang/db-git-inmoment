CREATE TABLE [dbo].[FeedbackChannel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [labelObjectId] [int] NOT NULL,
   [description] [varchar](2000) NULL,
   [feedbackChannelTypeObjectId] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [partOfDayFieldObjectId] [int] NULL,
   [defaultUpliftModelObjectId] [int] NULL,
   [defaultUnstructuredFeedbackModelObjectId] [int] NULL,
   [responseRateGoal] [real] NULL,
   [transactionCountFieldObjectId] [int] NULL,
   [groupFocusUpliftModels] [tinyint] NULL

   ,CONSTRAINT [PK_FeedbackChannel] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_FeedbackChannel_Name_Organization] UNIQUE NONCLUSTERED ([name], [organizationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_FeedbackChannel_FeedbackChannelType] ON [dbo].[FeedbackChannel] ([feedbackChannelTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_FeedbackChannel_LocalizedString] ON [dbo].[FeedbackChannel] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_FeedbackChannel_organizationObjectId] ON [dbo].[FeedbackChannel] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_FeedbackChannel_PartOfDayField] ON [dbo].[FeedbackChannel] ([partOfDayFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_FeedbackChannel_transactionCountField] ON [dbo].[FeedbackChannel] ([transactionCountFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_FeedbackChannel_UnstructuredFeedbackModel] ON [dbo].[FeedbackChannel] ([defaultUnstructuredFeedbackModelObjectId])
CREATE NONCLUSTERED INDEX [IX_FeedbackChannel_UpliftModel] ON [dbo].[FeedbackChannel] ([defaultUpliftModelObjectId])

GO

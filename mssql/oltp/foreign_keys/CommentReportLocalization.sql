ALTER TABLE [dbo].[CommentReportLocalization] WITH CHECK ADD CONSTRAINT [FK_CommentReportLocalization_noOpportunity_LocalizedString]
   FOREIGN KEY([noOpportunityObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[CommentReportLocalization] WITH CHECK ADD CONSTRAINT [FK_CommentReportLocalization_noOutstanding_LocalizedString]
   FOREIGN KEY([noOutstandingObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[CommentReportLocalization] WITH CHECK ADD CONSTRAINT [FK_CommentReportLocalization_opportunities_LocalizedString]
   FOREIGN KEY([opportunitiesObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[CommentReportLocalization] WITH CHECK ADD CONSTRAINT [FK_CommentReportLocalization_opportunityComments_LocalizedString]
   FOREIGN KEY([opportunityCommentsObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[CommentReportLocalization] WITH CHECK ADD CONSTRAINT [FK_CommentReportLocalization_outstandingComments_LocalizedString]
   FOREIGN KEY([outstandingCommentsObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[CommentReportLocalization] WITH CHECK ADD CONSTRAINT [FK_CommentReportLocalization_outstanding_LocalizedString]
   FOREIGN KEY([outstandingObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[CommentReportLocalization] WITH CHECK ADD CONSTRAINT [FK_CommentReportLocalization_pageObjectId_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO

ALTER TABLE [dbo].[UnstructuredFeedbackTermFilter] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackTermFilter_TermFilter]
   FOREIGN KEY([termFilterObjectId]) REFERENCES [dbo].[TermFilter] ([objectId])

GO
ALTER TABLE [dbo].[UnstructuredFeedbackTermFilter] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackTermFilter_UnstructuredFeedbackModel]
   FOREIGN KEY([unstructuredFeedbackModelObjectId]) REFERENCES [dbo].[UnstructuredFeedbackModel] ([objectId])

GO

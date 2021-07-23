ALTER TABLE [dbo].[UnstructuredFeedbackCommentField] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackCommentField_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[UnstructuredFeedbackCommentField] WITH CHECK ADD CONSTRAINT [FK_UnstructuredFeedbackCommentField_UnstructuredFeedbackModel]
   FOREIGN KEY([unstructuredFeedbackModelObjectId]) REFERENCES [dbo].[UnstructuredFeedbackModel] ([objectId])

GO

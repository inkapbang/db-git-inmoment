ALTER TABLE [dbo].[PearModel] WITH CHECK ADD CONSTRAINT [FK_PearModel_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[PearModel] WITH CHECK ADD CONSTRAINT [FK_PearModel_Pear]
   FOREIGN KEY([pearObjectId]) REFERENCES [dbo].[Pear] ([objectId])

GO

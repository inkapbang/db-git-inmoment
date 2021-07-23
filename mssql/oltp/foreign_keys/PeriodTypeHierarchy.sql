ALTER TABLE [dbo].[PeriodTypeHierarchy] WITH CHECK ADD CONSTRAINT [FK_PeriodTypeHierarchy_label_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[PeriodTypeHierarchy] WITH CHECK ADD CONSTRAINT [FK_PeriodTypeHierarchy_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO

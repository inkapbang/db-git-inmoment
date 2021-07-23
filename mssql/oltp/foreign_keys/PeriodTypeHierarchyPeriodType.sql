ALTER TABLE [dbo].[PeriodTypeHierarchyPeriodType] WITH CHECK ADD CONSTRAINT [FK_PeriodTypeHierarchyPeriodType_PeriodTypeHierarchy]
   FOREIGN KEY([periodTypeHierarchyObjectId]) REFERENCES [dbo].[PeriodTypeHierarchy] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[PeriodTypeHierarchyPeriodType] WITH CHECK ADD CONSTRAINT [FK_PeriodTypeHierarchyPeriodType_PeriodType]
   FOREIGN KEY([periodTypeObjectId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO

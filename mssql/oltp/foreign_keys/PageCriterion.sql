ALTER TABLE [dbo].[PageCriterion] WITH CHECK ADD CONSTRAINT [FK_PageCriterion_LocationAttributeGroup]
   FOREIGN KEY([attributeGroupObjectId]) REFERENCES [dbo].[LocationAttributeGroup] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterion] WITH CHECK ADD CONSTRAINT [FK__PageCrite__dataF__54146837]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterion] WITH CHECK ADD CONSTRAINT [FK_PageCriterion_Label_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterion] WITH CHECK ADD CONSTRAINT [FK_PageCriterion_LocationCategory]
   FOREIGN KEY([locationCategoryObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterion] WITH CHECK ADD CONSTRAINT [FK_PageCriterion_PearModel]
   FOREIGN KEY([pearModelObjectId]) REFERENCES [dbo].[PearModel] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterion] WITH CHECK ADD CONSTRAINT [FK_PageCriterion_Period]
   FOREIGN KEY([periodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterion] WITH CHECK ADD CONSTRAINT [FK_PageCriterion_PeriodTypeHierarchy]
   FOREIGN KEY([periodTypeHierarchyObjectId]) REFERENCES [dbo].[PeriodTypeHierarchy] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterion] WITH CHECK ADD CONSTRAINT [FK_PageCriterion_PeriodType]
   FOREIGN KEY([relativePeriodTypeObjectId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterion] WITH CHECK ADD CONSTRAINT [FK_PageCriterion_SubPeriodType]
   FOREIGN KEY([relativeSubPeriodTypeObjectId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterion] WITH CHECK ADD CONSTRAINT [FK_PageCriterion_relativeSubTotalPeriodTypeObjectId]
   FOREIGN KEY([relativeSubTotalPeriodTypeObjectId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO

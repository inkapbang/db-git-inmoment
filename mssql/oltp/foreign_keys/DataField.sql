ALTER TABLE [dbo].[DataField] WITH CHECK ADD CONSTRAINT [FK_DataField_Goal]
   FOREIGN KEY([defaultGoalObjectId]) REFERENCES [dbo].[Goal] ([objectId])

GO
ALTER TABLE [dbo].[DataField] WITH CHECK ADD CONSTRAINT [FK_DataField_Label_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[DataField] WITH CHECK ADD CONSTRAINT [FK_DataField_LocationCategoryType]
   FOREIGN KEY([locationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[DataField] WITH CHECK ADD CONSTRAINT [FK_DataField_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[DataField] WITH CHECK ADD CONSTRAINT [FK_DataField_Period]
   FOREIGN KEY([periodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[DataField] WITH CHECK ADD CONSTRAINT [FK_DataField_ReportHierarchyMap]
   FOREIGN KEY([reportHierarchyMapObjectId]) REFERENCES [dbo].[ReportHierarchyMap] ([objectId])

GO
ALTER TABLE [dbo].[DataField] WITH CHECK ADD CONSTRAINT [FK_DataField_SegmentType]
   FOREIGN KEY([segmentTypeObjectId]) REFERENCES [dbo].[SegmentType] ([objectId])

GO
ALTER TABLE [dbo].[DataField] WITH CHECK ADD CONSTRAINT [FK_DataField_SurveyDataField]
   FOREIGN KEY([surveyDataFieldId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[DataField] WITH CHECK ADD CONSTRAINT [FK_DataField_Text_LocalizedString]
   FOREIGN KEY([textObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[DataField] WITH CHECK ADD CONSTRAINT [FK_DataField_UpliftModel]
   FOREIGN KEY([upliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO

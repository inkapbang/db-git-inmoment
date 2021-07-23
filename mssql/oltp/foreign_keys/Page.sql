ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_Brand]
   FOREIGN KEY([brandObjectId]) REFERENCES [dbo].[Brand] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_CrossTab]
   FOREIGN KEY([crossTabIndyFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_DashboardDefinintion]
   FOREIGN KEY([dashboardDefinitionId]) REFERENCES [dbo].[DashboardDefinition] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_Dashboard]
   FOREIGN KEY([dashboardObjectId]) REFERENCES [dbo].[Dashboard] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_Description_LocalizedString]
   FOREIGN KEY([descriptionObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_EditableContent_LocalizedString]
   FOREIGN KEY([editableContentObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_Blob]
   FOREIGN KEY([excelTemplateObjectId]) REFERENCES [dbo].[Blob] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_Folder]
   FOREIGN KEY([folderObjectId]) REFERENCES [dbo].[Folder] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_JasperReportDefinition]
   FOREIGN KEY([jasperReportDefinitionObjectId]) REFERENCES [dbo].[JasperReportDefinition] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_Name_LocalizedString]
   FOREIGN KEY([nameObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_Period]
   FOREIGN KEY([periodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_LocalizedString_PeriodToDateColumnLabel]
   FOREIGN KEY([periodToDateColLabelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_PeriodType_PeriodToDateCutoffPeriodType]
   FOREIGN KEY([periodToDateCutoffPeriodTypeObjectId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_PeriodType_PeriodToDatePeriodType]
   FOREIGN KEY([periodToDatePeriodTypeObjectId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_TrendPeriod]
   FOREIGN KEY([trendPeriodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_UnstructuredFeedbackModel]
   FOREIGN KEY([unstructuredFeedbackObjectId]) REFERENCES [dbo].[UnstructuredFeedbackModel] ([objectId])

GO
ALTER TABLE [dbo].[Page] WITH CHECK ADD CONSTRAINT [FK_Page_UpliftModel]
   FOREIGN KEY([upliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO

ALTER TABLE [dbo].[JasperReportDefinition] WITH CHECK ADD CONSTRAINT [FK_JasperReportDefinition_Blob_compiled]
   FOREIGN KEY([compiledObjectId]) REFERENCES [dbo].[Blob] ([objectId])

GO
ALTER TABLE [dbo].[JasperReportDefinition] WITH CHECK ADD CONSTRAINT [FK_JasperReportDefinition_Blob_design]
   FOREIGN KEY([designObjectId]) REFERENCES [dbo].[Blob] ([objectId])

GO
ALTER TABLE [dbo].[JasperReportDefinition] WITH CHECK ADD CONSTRAINT [FK_JasperReportDefinition_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[JasperReportDefinition] WITH CHECK ADD CONSTRAINT [FK_JasperReportDefinition_ParentDefinition]
   FOREIGN KEY([parentDefinitionObjectId]) REFERENCES [dbo].[JasperReportDefinition] ([objectId])

GO

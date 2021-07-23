CREATE TABLE [dbo].[JasperReportDefinition] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](255) NOT NULL,
   [organizationObjectId] [int] NULL,
   [designObjectId] [int] NOT NULL,
   [compiledObjectId] [int] NOT NULL,
   [parentDefinitionObjectId] [int] NULL

   ,CONSTRAINT [PK_JasperReportDefinition] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_JasperReportDefinition_by_CompiledBinaryContentObjectid] ON [dbo].[JasperReportDefinition] ([compiledObjectId])
CREATE NONCLUSTERED INDEX [IX_JasperReportDefinition_by_DesignBinaryContentObjectid] ON [dbo].[JasperReportDefinition] ([designObjectId])
CREATE NONCLUSTERED INDEX [IX_JasperReportDefinition_organizationObjectId] ON [dbo].[JasperReportDefinition] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_JasperReportDefinition_parentDefinitionObjectId] ON [dbo].[JasperReportDefinition] ([parentDefinitionObjectId])

GO

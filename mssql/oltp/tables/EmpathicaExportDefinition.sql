CREATE TABLE [dbo].[EmpathicaExportDefinition] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NULL,
   [ftpFolder] [int] NULL

   ,CONSTRAINT [PK_EmpathicaExportDefinition] PRIMARY KEY NONCLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_EmpathicaExportDefinition_Organization] ON [dbo].[EmpathicaExportDefinition] ([organizationObjectId])

GO

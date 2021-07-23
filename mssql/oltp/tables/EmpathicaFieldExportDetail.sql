CREATE TABLE [dbo].[EmpathicaFieldExportDetail] (
   [objectId] [int] NOT NULL
      IDENTITY (100,1),
   [exportDefinitionObjectId] [int] NULL,
   [version] [int] NOT NULL,
   [dataFieldObjectId] [int] NULL,
   [name] [varchar](200) NULL,
   [formatter] [int] NULL,
   [dateFormat] [varchar](100) NULL,
   [empathicaType] [int] NULL,
   [sequence] [int] NULL,
   [required] [bit] NOT NULL,
   [valueFilter] [int] NULL

   ,CONSTRAINT [PK__Empathic__5243E26B3EFB1C67] PRIMARY KEY NONCLUSTERED ([objectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_EmpathicaFieldExportDetail_by_EmpathicaExportDefinition_id] ON [dbo].[EmpathicaFieldExportDetail] ([exportDefinitionObjectId], [objectId]) INCLUDE ([dataFieldObjectId], [formatter], [sequence], [name], [version], [dateFormat], [empathicaType], [required])

GO

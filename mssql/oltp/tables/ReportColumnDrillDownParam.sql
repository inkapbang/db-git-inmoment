CREATE TABLE [dbo].[ReportColumnDrillDownParam] (
   [columnObjectId] [int] NOT NULL,
   [paramCriterionObjectId] [int] NOT NULL,
   [valueColumnObjectId] [int] NOT NULL,
   [originalValueColumnObjectId] [int] NULL

   ,CONSTRAINT [PK_ReportColumnDrillDownParam] PRIMARY KEY CLUSTERED ([columnObjectId], [paramCriterionObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ReportColumnDrillDownParam_paramCriterionObjectId] ON [dbo].[ReportColumnDrillDownParam] ([paramCriterionObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportColumnDrillDownParam_valueColumnObjectId] ON [dbo].[ReportColumnDrillDownParam] ([valueColumnObjectId])

GO

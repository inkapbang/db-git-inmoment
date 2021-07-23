CREATE TABLE [dbo].[UpliftModelPerformanceAttributeDiagnosticField] (
   [performanceAttributeObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_UpliftModelPerformanceAttributeDiagnosticField] PRIMARY KEY CLUSTERED ([performanceAttributeObjectId], [dataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_UpliftModelPerformanceAttributeDiagnosticField_DataField] ON [dbo].[UpliftModelPerformanceAttributeDiagnosticField] ([dataFieldObjectId])

GO

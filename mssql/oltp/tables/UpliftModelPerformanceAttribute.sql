CREATE TABLE [dbo].[UpliftModelPerformanceAttribute] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [modelObjectId] [int] NOT NULL,
   [diagnosticFieldObjectId] [int] NULL,
   [sequence] [int] NOT NULL,
   [version] [int] NOT NULL,
   [fieldObjectId] [int] NOT NULL,
   [attributeRole] [int] NOT NULL,
   [goalObjectId] [int] NULL,
   [tagCategoryObjectId] [int] NULL,
   [ordinalModelObjectId] [int] NULL,
   [useTagsForDiagnostics] [bit] NULL,
   [aggregateFunction] [tinyint] NOT NULL
      CONSTRAINT [DF_UpliftModelPerformanceAttribute_aggregateFunction] DEFAULT ((0)),
   [auditFieldObjectId] [int] NULL,
   [priorityThreshold] [float] NULL,
   [showDiagnostics] [bit] NULL
      CONSTRAINT [DF_UpliftModelPerformanceAttribute_showDiagnostics] DEFAULT ((1)),
   [criticalThreshold] [float] NULL

   ,CONSTRAINT [PK_UpliftModelPerformanceAttribute] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UN_UpliftModelPerformanceAttribute_Model_Field] UNIQUE NONCLUSTERED ([modelObjectId], [fieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_UpliftModelPerformanceAttribute_AuditField] ON [dbo].[UpliftModelPerformanceAttribute] ([auditFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModelPerformanceAttribute_diagnosticFieldObjectId] ON [dbo].[UpliftModelPerformanceAttribute] ([diagnosticFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModelPerformanceAttribute_fieldObjectId] ON [dbo].[UpliftModelPerformanceAttribute] ([fieldObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModelPerformanceAttribute_Goal] ON [dbo].[UpliftModelPerformanceAttribute] ([goalObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModelPerformanceAttribute_TagCategory] ON [dbo].[UpliftModelPerformanceAttribute] ([tagCategoryObjectId])

GO

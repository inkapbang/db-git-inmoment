CREATE TABLE [dbo].[_UpliftModelPerformanceAttribute] (
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
   [aggregateFunction] [tinyint] NOT NULL,
   [auditFieldObjectId] [int] NULL,
   [priorityThreshold] [float] NULL,
   [showDiagnostics] [bit] NULL,
   [criticalThreshold] [float] NULL
)


GO

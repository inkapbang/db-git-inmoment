CREATE TABLE [dbo].[HierarchyTransformRule] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [hierarchyTransformRuleSetObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [conditional] [bit] NOT NULL,
   [conditionalBindingObjectId] [int] NULL,
   [conditionalOperator] [int] NULL,
   [conditionalValue] [nvarchar](max) NULL,
   [delimeters] [nvarchar](max) NULL,
   [testLine] [nvarchar](max) NULL,
   [conditionalIgnoreCase] [bit] NOT NULL,
   [inputBindingObjectId] [int] NULL

   ,CONSTRAINT [PK_HierarchyTransformRule] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HierarchyTransformRule_ConditionalBindingObjectId] ON [dbo].[HierarchyTransformRule] ([conditionalBindingObjectId])
CREATE NONCLUSTERED INDEX [IX_HierarchyTransformRule_HierarchyTransformRuleSetObjectId] ON [dbo].[HierarchyTransformRule] ([hierarchyTransformRuleSetObjectId])
CREATE NONCLUSTERED INDEX [IX_HierarchyTransformRule_InputBindingObjectId] ON [dbo].[HierarchyTransformRule] ([inputBindingObjectId])

GO

CREATE TABLE [dbo].[HierarchyTransformOutputMapping] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [hierarchyTransformRuleSetObjectId] [int] NOT NULL,
   [entity] [int] NOT NULL,
   [entityField] [int] NOT NULL,
   [expression] [nvarchar](4000) NOT NULL,
   [sequence] [int] NOT NULL
      CONSTRAINT [DF_sequence] DEFAULT ((0))

   ,CONSTRAINT [PK_HierarchyTransformOutputMapping] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HierarchyTransformOutputMapping_HierarchyTransformRuleSetObjectId] ON [dbo].[HierarchyTransformOutputMapping] ([hierarchyTransformRuleSetObjectId])

GO

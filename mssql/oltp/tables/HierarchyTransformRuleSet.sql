CREATE TABLE [dbo].[HierarchyTransformRuleSet] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [hierarchyTransformObjectId] [int] NULL,
   [filePattern] [varchar](256) NULL,
   [testLine] [nvarchar](max) NULL,
   [skipFirstLine] [bit] NOT NULL

   ,CONSTRAINT [PK_HierarchyTransformRuleSet] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HierarchyTransformRuleSet_HierarchyTransformObjectId] ON [dbo].[HierarchyTransformRuleSet] ([hierarchyTransformObjectId])

GO

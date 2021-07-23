CREATE TABLE [dbo].[HierarchyTransformBinding] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [hierarchyTransformRuleObjectId] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [startAt] [int] NOT NULL,
   [position] [int] NULL,
   [defaultValue] [nvarchar](512) NULL,
   [repeating] [bit] NOT NULL,
   [repeatCount] [int] NULL,
   [repeatOffset] [int] NULL,
   [maxColumns] [int] NULL,
   [sequence] [int] NOT NULL
      CONSTRAINT [DF_sequence_binding] DEFAULT ((0))

   ,CONSTRAINT [PK_HierarchyTransformBinding] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HierarchyTransformBinding_HierarchyTransformRuleObjectId] ON [dbo].[HierarchyTransformBinding] ([hierarchyTransformRuleObjectId])

GO

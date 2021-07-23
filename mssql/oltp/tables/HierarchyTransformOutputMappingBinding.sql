CREATE TABLE [dbo].[HierarchyTransformOutputMappingBinding] (
   [hierarchyTransformOutputMappingObjectId] [int] NOT NULL,
   [hierarchyTransformBindingObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_HierarchyTransformOutputMappingBinding] PRIMARY KEY CLUSTERED ([hierarchyTransformOutputMappingObjectId], [hierarchyTransformBindingObjectId])
)

CREATE NONCLUSTERED INDEX [IX_HierarchyTransformOutputMappingBinding_BindingObjectId] ON [dbo].[HierarchyTransformOutputMappingBinding] ([hierarchyTransformBindingObjectId])
CREATE NONCLUSTERED INDEX [IX_HierarchyTransformOutputMappingBinding_OutputMappingObjectId] ON [dbo].[HierarchyTransformOutputMappingBinding] ([hierarchyTransformOutputMappingObjectId])

GO

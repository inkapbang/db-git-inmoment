CREATE TABLE [dbo].[PromptHierarchyMap] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [hierarchyObjectId] [int] NOT NULL,
   [locationWebText] [nvarchar](max) NULL,
   [locationPlaceholderText] [nvarchar](max) NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_PromptHierarchyMap] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptHierarchyMap_hierarchyObjectId] ON [dbo].[PromptHierarchyMap] ([hierarchyObjectId])

GO

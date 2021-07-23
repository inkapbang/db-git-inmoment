CREATE TABLE [dbo].[PromptHierarchyMapValue] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [promptHierarchyMapObjectId] [int] NOT NULL,
   [levelObjectId] [int] NOT NULL,
   [visibleOnPrompt] [bit] NOT NULL,
   [locationCategoryObjectId] [int] NULL,
   [webText] [nvarchar](max) NULL,
   [placeholderText] [nvarchar](max) NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_PromptHierarchyMapValue] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_PromptHierarchyMapValue_PromptHierarchyMapLocationCategory] UNIQUE NONCLUSTERED ([promptHierarchyMapObjectId], [levelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptHierarchyMapValue_LocationCategory] ON [dbo].[PromptHierarchyMapValue] ([locationCategoryObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptHierarchyMapValue_LocationCategoryType] ON [dbo].[PromptHierarchyMapValue] ([levelObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptHierarchyMapValue_PromptHierarchyMap] ON [dbo].[PromptHierarchyMapValue] ([promptHierarchyMapObjectId])

GO

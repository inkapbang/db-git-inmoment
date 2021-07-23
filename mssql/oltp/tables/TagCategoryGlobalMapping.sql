CREATE TABLE [dbo].[TagCategoryGlobalMapping] (
   [orgTagCategoryObjectId] [int] NOT NULL,
   [globalTagCategoryObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_TagCategoryGlobalMapping] PRIMARY KEY CLUSTERED ([orgTagCategoryObjectId], [globalTagCategoryObjectId])
)

CREATE NONCLUSTERED INDEX [IX_TagCategoryGlobalMapping_globalCat] ON [dbo].[TagCategoryGlobalMapping] ([globalTagCategoryObjectId])

GO

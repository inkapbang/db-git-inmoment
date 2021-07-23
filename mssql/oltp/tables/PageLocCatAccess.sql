CREATE TABLE [dbo].[PageLocCatAccess] (
   [pageObjectId] [int] NOT NULL,
   [locationCategoryObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageLocCatAccess] PRIMARY KEY CLUSTERED ([pageObjectId], [locationCategoryObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageLocCatAccess_locationCategoryObjectId] ON [dbo].[PageLocCatAccess] ([locationCategoryObjectId])

GO

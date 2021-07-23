CREATE TABLE [dbo].[PageWebAccess] (
   [pageObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageWebAccess] PRIMARY KEY CLUSTERED ([pageObjectId], [locationCategoryTypeObjectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_PageWebAccess_LocationCategoryType_Page] ON [dbo].[PageWebAccess] ([locationCategoryTypeObjectId], [pageObjectId])
CREATE NONCLUSTERED INDEX [IX_PageWebAccess_locationCategoryTypeObjectId] ON [dbo].[PageWebAccess] ([locationCategoryTypeObjectId])

GO

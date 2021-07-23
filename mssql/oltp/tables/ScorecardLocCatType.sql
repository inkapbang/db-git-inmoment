CREATE TABLE [dbo].[ScorecardLocCatType] (
   [pageObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_ScorecardLocCatType] PRIMARY KEY CLUSTERED ([pageObjectId], [locationCategoryTypeObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX_ScorecardLocCatType_locationCategoryTypeObjectId] ON [dbo].[ScorecardLocCatType] ([locationCategoryTypeObjectId])

GO

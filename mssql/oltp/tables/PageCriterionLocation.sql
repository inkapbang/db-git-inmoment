CREATE TABLE [dbo].[PageCriterionLocation] (
   [pageCriterionObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionLocation] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [locationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionLocation_locationObjectId] ON [dbo].[PageCriterionLocation] ([locationObjectId])

GO

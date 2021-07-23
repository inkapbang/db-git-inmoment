CREATE TABLE [dbo].[PageCriterionRecommendation] (
   [pageCriterionObjectId] [int] NOT NULL,
   [performanceAttributeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionRecommendation] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [performanceAttributeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionRecommendation_PerformanceAttribute] ON [dbo].[PageCriterionRecommendation] ([performanceAttributeObjectId])

GO

CREATE TABLE [dbo].[PageCriterionSatisfactionType] (
   [pageCriterionObjectId] [int] NOT NULL,
   [satisfactionType] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionSatisfactionType] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [satisfactionType])
)


GO

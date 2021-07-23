CREATE TABLE [dbo].[PageCriterionMode] (
   [pageCriterionObjectId] [int] NOT NULL,
   [modeType] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionMode] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [modeType])
)


GO

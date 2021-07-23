CREATE TABLE [dbo].[PageCriterionState] (
   [pageCriterionObjectId] [int] NOT NULL,
   [stateType] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionState] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [stateType])
)


GO

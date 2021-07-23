CREATE TABLE [dbo].[PageCriterionExclusionReason] (
   [pageCriterionObjectId] [int] NOT NULL,
   [exclusionReason] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionExclusionReason] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [exclusionReason])
)


GO

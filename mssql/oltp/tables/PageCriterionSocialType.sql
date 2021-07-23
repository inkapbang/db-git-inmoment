CREATE TABLE [dbo].[PageCriterionSocialType] (
   [pageCriterionObjectId] [int] NOT NULL,
   [socialType] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionSocialType] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [socialType])
)


GO

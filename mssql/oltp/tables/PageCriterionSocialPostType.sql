CREATE TABLE [dbo].[PageCriterionSocialPostType] (
   [pageCriterionObjectId] [int] NOT NULL,
   [socialPostType] [smallint] NOT NULL

   ,CONSTRAINT [PK_PageCriterionSocialPostType] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [socialPostType])
)


GO

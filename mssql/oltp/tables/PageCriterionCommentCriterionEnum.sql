CREATE TABLE [dbo].[PageCriterionCommentCriterionEnum] (
   [pageCriterionObjectId] [int] NOT NULL,
   [CommentCriterionEnum] [tinyint] NOT NULL

   ,CONSTRAINT [PK_PageCriterionCommentCriterionEnum] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [CommentCriterionEnum])
)


GO

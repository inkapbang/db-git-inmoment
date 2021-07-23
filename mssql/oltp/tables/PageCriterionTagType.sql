CREATE TABLE [dbo].[PageCriterionTagType] (
   [pageCriterionObjectId] [int] NOT NULL,
   [tagType] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionTagType] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [tagType])
)


GO

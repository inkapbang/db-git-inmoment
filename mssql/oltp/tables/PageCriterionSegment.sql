CREATE TABLE [dbo].[PageCriterionSegment] (
   [pageCriterionObjectId] [int] NOT NULL,
   [segmentObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionSegment] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [segmentObjectId])
)


GO

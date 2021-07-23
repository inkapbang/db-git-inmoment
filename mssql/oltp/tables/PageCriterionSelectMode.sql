CREATE TABLE [dbo].[PageCriterionSelectMode] (
   [pageCriterionObjectId] [int] NOT NULL,
   [selectMode] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK__PageCrit__2464484E5622A35E] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [selectMode])
)


GO

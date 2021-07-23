CREATE TABLE [dbo].[PageCriterionResponseSource] (
   [pageCriterionObjectId] [int] NOT NULL,
   [responseSourceObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionResponseSource] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [responseSourceObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionResponseSource_ResponseSource] ON [dbo].[PageCriterionResponseSource] ([responseSourceObjectId])

GO

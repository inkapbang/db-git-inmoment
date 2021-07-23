CREATE TABLE [dbo].[PageCriterionTag] (
   [pageCriterionObjectId] [int] NOT NULL,
   [tagObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionTag] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [tagObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionTag_tagObjectId] ON [dbo].[PageCriterionTag] ([tagObjectId])

GO

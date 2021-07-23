CREATE TABLE [dbo].[PageCriterionUserAccount] (
   [pageCriterionObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionUserAccount] PRIMARY KEY CLUSTERED ([pageCriterionObjectId] DESC, [userAccountObjectId] DESC)
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionUserAccount_userAccountObjectId] ON [dbo].[PageCriterionUserAccount] ([userAccountObjectId])

GO

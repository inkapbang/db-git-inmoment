CREATE TABLE [dbo].[PageCriterionLanguage] (
   [pageCriterionObjectId] [int] NOT NULL,
   [language] [smallint] NOT NULL

   ,CONSTRAINT [PK_PageCriterionLanguage] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [language])
)


GO

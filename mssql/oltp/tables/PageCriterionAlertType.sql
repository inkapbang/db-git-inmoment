CREATE TABLE [dbo].[PageCriterionAlertType] (
   [pageCriterionObjectId] [int] NOT NULL,
   [alertType] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionAlertType] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [alertType])
)


GO

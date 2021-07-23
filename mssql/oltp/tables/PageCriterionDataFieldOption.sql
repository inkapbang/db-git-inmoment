CREATE TABLE [dbo].[PageCriterionDataFieldOption] (
   [pageCriterionObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionDataFieldOption] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [dataFieldOptionObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionDataFieldOption_dataFieldOptionObjectId] ON [dbo].[PageCriterionDataFieldOption] ([dataFieldOptionObjectId])

GO

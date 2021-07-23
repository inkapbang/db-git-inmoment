CREATE TABLE [dbo].[PageCriteriaSet] (
   [pageObjectId] [int] NOT NULL,
   [pageCriterionObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriteriaSet] PRIMARY KEY CLUSTERED ([pageObjectId], [pageCriterionObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX_PageCriteriaSet_pageCriterionObjectId] ON [dbo].[PageCriteriaSet] ([pageCriterionObjectId])

GO

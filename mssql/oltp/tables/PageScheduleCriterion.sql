CREATE TABLE [dbo].[PageScheduleCriterion] (
   [pageScheduleObjectId] [int] NOT NULL,
   [pageCriterionObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_PageScheduleCriterion] PRIMARY KEY CLUSTERED ([pageScheduleObjectId], [pageCriterionObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageScheduleCriterion_pageCriterionObjectId] ON [dbo].[PageScheduleCriterion] ([pageCriterionObjectId])

GO

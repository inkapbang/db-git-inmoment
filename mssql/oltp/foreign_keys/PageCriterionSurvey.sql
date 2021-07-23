ALTER TABLE [dbo].[PageCriterionSurvey] WITH CHECK ADD CONSTRAINT [FK_PageCriterionSurvey_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionSurvey] WITH CHECK ADD CONSTRAINT [FK_PageCriterionSurvey_Survey]
   FOREIGN KEY([surveyObjectId]) REFERENCES [dbo].[Survey] ([objectId])

GO

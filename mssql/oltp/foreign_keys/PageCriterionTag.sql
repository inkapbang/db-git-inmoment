ALTER TABLE [dbo].[PageCriterionTag] WITH CHECK ADD CONSTRAINT [FK_PageCriterionTag_Criterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionTag] WITH CHECK ADD CONSTRAINT [FK_PageCriterionTag_Tag]
   FOREIGN KEY([tagObjectId]) REFERENCES [dbo].[Tag] ([objectId])

GO

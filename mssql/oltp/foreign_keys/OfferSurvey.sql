ALTER TABLE [dbo].[OfferSurvey] WITH CHECK ADD CONSTRAINT [FK_OfferSurvey_AudioOption]
   FOREIGN KEY([audioOptionObjectId]) REFERENCES [dbo].[AudioOption] ([objectId])

GO
ALTER TABLE [dbo].[OfferSurvey] WITH CHECK ADD CONSTRAINT [FK_OfferSurvey_Offer]
   FOREIGN KEY([offerObjectId]) REFERENCES [dbo].[Offer] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[OfferSurvey] WITH CHECK ADD CONSTRAINT [FK_OfferSurvey_Survey]
   FOREIGN KEY([surveyObjectId]) REFERENCES [dbo].[Survey] ([objectId])

GO

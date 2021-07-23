ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_Address]
   FOREIGN KEY([addressObjectId]) REFERENCES [dbo].[Address] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_ContactInfo]
   FOREIGN KEY([contactInfoObjectId]) REFERENCES [dbo].[ContactInfo] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_Default_Brand]
   FOREIGN KEY([defaultBrandObjectId]) REFERENCES [dbo].[Brand] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_OOVList]
   FOREIGN KEY([defaultOovListObjectId]) REFERENCES [dbo].[OOVList] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_WebSurveyStyle]
   FOREIGN KEY([defaultWebSurveyStyleObjectId]) REFERENCES [dbo].[WebSurveyStyle] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_Survey]
   FOREIGN KEY([disabledSurveyObjectId]) REFERENCES [dbo].[Survey] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_PlatformFeedbackChannel]
   FOREIGN KEY([feedbackChannelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_PeriodType]
   FOREIGN KEY([focusCyclePeriodTypeId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_PeriodRange]
   FOREIGN KEY([focusCycleStartPeriodRangeId]) REFERENCES [dbo].[PeriodRange] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_FocusCycleType]
   FOREIGN KEY([focusCycleTypeId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_Locale]
   FOREIGN KEY([localeKey]) REFERENCES [dbo].[Locale] ([localeKey])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_messagePhoneNumber_LocalizedString]
   FOREIGN KEY([messagePhoneNumberObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_FeedbackChannel]
   FOREIGN KEY([reviewFeedbackChannelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_Hierarchy_reviewHierarchy]
   FOREIGN KEY([reviewHierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_LocalizedString_reviewResponseText]
   FOREIGN KEY([reviewResponseTextObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_reviewUnstructuredFeedbackModelObjectId_UnstructuredFeedbackModel]
   FOREIGN KEY([reviewUnstructuredFeedbackModelObjectId]) REFERENCES [dbo].[UnstructuredFeedbackModel] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_reviewUpliftModelObjectId_UpliftModel]
   FOREIGN KEY([reviewUpliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK__Organizat__sales__57899CD7]
   FOREIGN KEY([salesRepObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_FeedbackChannel_Social]
   FOREIGN KEY([socialFeedbackChannelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[Organization] WITH CHECK ADD CONSTRAINT [FK_Organization_Offer]
   FOREIGN KEY([socialOfferObjectId]) REFERENCES [dbo].[Offer] ([objectId])

GO

ALTER TABLE [dbo].[PromptEventLocationCategoryType] WITH CHECK ADD CONSTRAINT [FK_PromptEventLocationCategoryType_LocationCategoryType]
   FOREIGN KEY([locationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[PromptEventLocationCategoryType] WITH CHECK ADD CONSTRAINT [FK_PromptEventLocationCategoryType_PromptEvent]
   FOREIGN KEY([promptEventObjectId]) REFERENCES [dbo].[PromptEvent] ([objectId])

GO

ALTER TABLE [dbo].[PromptEventTrigger] WITH CHECK ADD CONSTRAINT [FK__PromptEve__dataF__0CFBAAF0]
   FOREIGN KEY([dataFieldOptionObjectId]) REFERENCES [dbo].[DataFieldOption] ([objectId])

GO

ALTER TABLE [dbo].[PromptEventAction] WITH CHECK ADD CONSTRAINT [FK_PromptEventAction_Campaign]
   FOREIGN KEY([campaignObjectId]) REFERENCES [dbo].[Campaign] ([objectId])

GO
ALTER TABLE [dbo].[PromptEventAction] WITH CHECK ADD CONSTRAINT [FK_Action_Field]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO

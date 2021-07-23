ALTER TABLE [dbo].[Action] WITH CHECK ADD CONSTRAINT [FK_Action_ActionGroup]
   FOREIGN KEY([actionGroupObjectId]) REFERENCES [dbo].[ActionGroup] ([objectId])

GO
ALTER TABLE [dbo].[Action] WITH CHECK ADD CONSTRAINT [FK_Action_Label]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Action] WITH CHECK ADD CONSTRAINT [FK_Action_User]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
ALTER TABLE [dbo].[Action] WITH CHECK ADD CONSTRAINT [FK_Action_Unit]
   FOREIGN KEY([visibilityUnitObjectId]) REFERENCES [dbo].[OrganizationalUnit] ([objectId])

GO

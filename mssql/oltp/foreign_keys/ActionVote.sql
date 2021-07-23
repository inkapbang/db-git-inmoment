ALTER TABLE [dbo].[ActionVote] WITH NOCHECK ADD CONSTRAINT [FK_ActionVote_Action]
   FOREIGN KEY([actionObjectId]) REFERENCES [dbo].[Action] ([objectId])
   ALTER TABLE [dbo].[ActionVote] NOCHECK CONSTRAINT [FK_ActionVote_Action]

GO
ALTER TABLE [dbo].[ActionVote] WITH NOCHECK ADD CONSTRAINT [FK_ActionVote_Unit]
   FOREIGN KEY([unitObjectId]) REFERENCES [dbo].[OrganizationalUnit] ([objectId])
   ALTER TABLE [dbo].[ActionVote] NOCHECK CONSTRAINT [FK_ActionVote_Unit]

GO
ALTER TABLE [dbo].[ActionVote] WITH NOCHECK ADD CONSTRAINT [FK_ActionVote_User]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])
   ALTER TABLE [dbo].[ActionVote] NOCHECK CONSTRAINT [FK_ActionVote_User]

GO

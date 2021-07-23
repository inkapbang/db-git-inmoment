ALTER TABLE [dbo].[ActionActionRole] WITH CHECK ADD CONSTRAINT [FK_ActionActionRole_Action]
   FOREIGN KEY([actionObjectId]) REFERENCES [dbo].[Action] ([objectId])

GO
ALTER TABLE [dbo].[ActionActionRole] WITH CHECK ADD CONSTRAINT [FK_ActionActionRole_ActionRole]
   FOREIGN KEY([actionRoleObjectId]) REFERENCES [dbo].[ActionRole] ([objectId])

GO

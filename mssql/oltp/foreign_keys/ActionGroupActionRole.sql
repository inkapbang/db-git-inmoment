ALTER TABLE [dbo].[ActionGroupActionRole] WITH CHECK ADD CONSTRAINT [FK_ActionGroupActionRole_ActionGroup]
   FOREIGN KEY([actionGroupObjectId]) REFERENCES [dbo].[ActionGroup] ([objectId])

GO
ALTER TABLE [dbo].[ActionGroupActionRole] WITH CHECK ADD CONSTRAINT [FK_ActionGroupActionRole_ActionRole]
   FOREIGN KEY([actionRoleObjectId]) REFERENCES [dbo].[ActionRole] ([objectId])

GO

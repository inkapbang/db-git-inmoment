ALTER TABLE [dbo].[ActionRole] WITH CHECK ADD CONSTRAINT [FK_ActionRole_Label]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[ActionRole] WITH CHECK ADD CONSTRAINT [FK_ActionRole_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO

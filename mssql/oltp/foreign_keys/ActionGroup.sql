ALTER TABLE [dbo].[ActionGroup] WITH CHECK ADD CONSTRAINT [FK_ActionGroup_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[ActionGroup] WITH CHECK ADD CONSTRAINT [FK_ActionGroup_DataFieldOption]
   FOREIGN KEY([dataFieldOptionObjectId]) REFERENCES [dbo].[DataFieldOption] ([objectId])

GO
ALTER TABLE [dbo].[ActionGroup] WITH CHECK ADD CONSTRAINT [FK_ActionGroup_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO

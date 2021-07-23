ALTER TABLE [dbo].[LoginTheme] WITH CHECK ADD CONSTRAINT [FK_LoginTheme_Brand]
   FOREIGN KEY([brandObjectId]) REFERENCES [dbo].[Brand] ([objectId])

GO
ALTER TABLE [dbo].[LoginTheme] WITH CHECK ADD CONSTRAINT [FK_LoginTheme_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO

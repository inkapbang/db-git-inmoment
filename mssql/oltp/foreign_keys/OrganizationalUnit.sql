ALTER TABLE [dbo].[OrganizationalUnit] WITH CHECK ADD CONSTRAINT [FK_OrganizationalUnit_LocationCategory]
   FOREIGN KEY([locationCategoryObjectId]) REFERENCES [dbo].[LocationCategory] ([objectId])

GO
ALTER TABLE [dbo].[OrganizationalUnit] WITH CHECK ADD CONSTRAINT [FK_OrganizationalUnit_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO

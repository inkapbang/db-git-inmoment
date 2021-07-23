ALTER TABLE [dbo].[OrganizationApiLimit] WITH CHECK ADD CONSTRAINT [FK_OrganizationApiLimit_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO

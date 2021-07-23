ALTER TABLE [dbo].[ApiLimit] WITH CHECK ADD CONSTRAINT [FK_ApiLimit_OrganizationApiLimit]
   FOREIGN KEY([orgApiLimitObjectId]) REFERENCES [dbo].[OrganizationApiLimit] ([objectId])

GO

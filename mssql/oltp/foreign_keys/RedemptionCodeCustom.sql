ALTER TABLE [dbo].[RedemptionCodeCustom] WITH CHECK ADD CONSTRAINT [FK_Redemption_organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO

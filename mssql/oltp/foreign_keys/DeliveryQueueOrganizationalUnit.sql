ALTER TABLE [dbo].[DeliveryQueueOrganizationalUnit] WITH CHECK ADD CONSTRAINT [FK_DeliveryQueueOrganizationalUnit_DeliveryQueue]
   FOREIGN KEY([deliveryQueueObjectId]) REFERENCES [dbo].[DeliveryQueue] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DeliveryQueueOrganizationalUnit] WITH CHECK ADD CONSTRAINT [FK_DeliveryQueueOrganizationalUnit_OrganizationalUnit]
   FOREIGN KEY([organizationalUnitObjectId]) REFERENCES [dbo].[OrganizationalUnit] ([objectId])
   ON DELETE CASCADE

GO

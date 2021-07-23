CREATE TABLE [dbo].[DeliveryQueueOrganizationalUnit] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [deliveryQueueObjectId] [int] NOT NULL,
   [organizationalUnitObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_DeliveryQueueOrganizationalUnit] PRIMARY KEY CLUSTERED ([deliveryQueueObjectId], [organizationalUnitObjectId])
)

CREATE NONCLUSTERED INDEX [IX_DeliveryQueueOrganizationalUnit_DeliveryQueue_Organization] ON [dbo].[DeliveryQueueOrganizationalUnit] ([deliveryQueueObjectId], [organizationalUnitObjectId])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueueOrganizationalUnit_Organization_DeliveryQueue] ON [dbo].[DeliveryQueueOrganizationalUnit] ([organizationalUnitObjectId], [deliveryQueueObjectId])

GO

CREATE TABLE [dbo].[LocationAttributeLocation] (
   [locationObjectId] [int] NOT NULL,
   [attributeObjectId] [int] NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK__Location__42E7EED166812E17] PRIMARY KEY CLUSTERED ([locationObjectId], [attributeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_LocationAttributeLocation_attributeObjectId] ON [dbo].[LocationAttributeLocation] ([attributeObjectId])

GO

CREATE TABLE [databus].[_DatabusLocationAttributeGroupAttributeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [attributeGroupObjectId] [int] NOT NULL,
   [attributeObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusLocationAttributeGroupAttributeCTCache_attributeGroupObjectId_attributeObjectId] PRIMARY KEY CLUSTERED ([attributeGroupObjectId], [attributeObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusLocationAttributeGroupAttributeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusLocationAttributeGroupAttributeCTCache] ([ctVersion], [ctSurrogateKey])

GO

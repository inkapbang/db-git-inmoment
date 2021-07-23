CREATE TABLE [databus].[_DatabusLocationAttributeGroupCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusLocationAttributeGroupCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusLocationAttributeGroupCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusLocationAttributeGroupCTCache] ([ctVersion], [ctSurrogateKey])

GO

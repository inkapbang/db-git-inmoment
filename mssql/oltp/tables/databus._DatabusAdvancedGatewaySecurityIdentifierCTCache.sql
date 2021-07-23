CREATE TABLE [databus].[_DatabusAdvancedGatewaySecurityIdentifierCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusAdvancedGatewaySecurityIdentifierCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusAdvancedGatewaySecurityIdentifierCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusAdvancedGatewaySecurityIdentifierCTCache] ([ctVersion], [ctSurrogateKey])

GO

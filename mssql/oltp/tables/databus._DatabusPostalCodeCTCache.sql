CREATE TABLE [databus].[_DatabusPostalCodeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPostalCodeCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPostalCodeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPostalCodeCTCache] ([ctVersion], [ctSurrogateKey])

GO

CREATE TABLE [databus].[_DatabusDataFieldOrdinalModelCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDataFieldOrdinalModelCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDataFieldOrdinalModelCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDataFieldOrdinalModelCTCache] ([ctVersion], [ctSurrogateKey])

GO

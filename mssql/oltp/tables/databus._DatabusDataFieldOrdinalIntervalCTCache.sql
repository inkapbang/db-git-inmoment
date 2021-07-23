CREATE TABLE [databus].[_DatabusDataFieldOrdinalIntervalCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDataFieldOrdinalIntervalCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDataFieldOrdinalIntervalCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDataFieldOrdinalIntervalCTCache] ([ctVersion], [ctSurrogateKey])

GO

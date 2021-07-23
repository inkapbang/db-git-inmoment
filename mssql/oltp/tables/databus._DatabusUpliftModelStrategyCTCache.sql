CREATE TABLE [databus].[_DatabusUpliftModelStrategyCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUpliftModelStrategyCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUpliftModelStrategyCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUpliftModelStrategyCTCache] ([ctVersion], [ctSurrogateKey])

GO

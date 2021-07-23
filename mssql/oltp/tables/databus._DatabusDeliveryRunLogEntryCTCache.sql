CREATE TABLE [databus].[_DatabusDeliveryRunLogEntryCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDeliveryRunLogEntryCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDeliveryRunLogEntryCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDeliveryRunLogEntryCTCache] ([ctVersion], [ctSurrogateKey])

GO

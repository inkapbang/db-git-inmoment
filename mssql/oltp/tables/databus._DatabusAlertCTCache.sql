CREATE TABLE [databus].[_DatabusAlertCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusAlertCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusAlertCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusAlertCTCache] ([ctVersion], [ctSurrogateKey])

GO

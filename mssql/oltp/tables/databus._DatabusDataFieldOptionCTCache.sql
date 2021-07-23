CREATE TABLE [databus].[_DatabusDataFieldOptionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDataFieldOptionCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDataFieldOptionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDataFieldOptionCTCache] ([ctVersion], [ctSurrogateKey])

GO

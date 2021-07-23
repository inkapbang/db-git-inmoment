CREATE TABLE [databus].[_DatabusPageLogEntryCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPageLogEntryCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPageLogEntryCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPageLogEntryCTCache] ([ctVersion], [ctSurrogateKey])

GO

CREATE TABLE [databus].[_DatabusStoredFileCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusStoredFileCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusStoredFileCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusStoredFileCTCache] ([ctVersion], [ctSurrogateKey])

GO

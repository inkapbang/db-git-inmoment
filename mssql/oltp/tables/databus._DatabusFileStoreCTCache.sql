CREATE TABLE [databus].[_DatabusFileStoreCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusFileStoreCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusFileStoreCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusFileStoreCTCache] ([ctVersion], [ctSurrogateKey])

GO

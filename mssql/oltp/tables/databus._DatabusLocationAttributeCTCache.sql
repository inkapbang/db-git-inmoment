CREATE TABLE [databus].[_DatabusLocationAttributeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusLocationAttributeCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusLocationAttributeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusLocationAttributeCTCache] ([ctVersion], [ctSurrogateKey])

GO

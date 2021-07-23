CREATE TABLE [databus].[_DatabusPageScheduleCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPageScheduleCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPageScheduleCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPageScheduleCTCache] ([ctVersion], [ctSurrogateKey])

GO

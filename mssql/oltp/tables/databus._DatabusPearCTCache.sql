CREATE TABLE [databus].[_DatabusPearCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPearCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPearCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPearCTCache] ([ctVersion], [ctSurrogateKey])

GO

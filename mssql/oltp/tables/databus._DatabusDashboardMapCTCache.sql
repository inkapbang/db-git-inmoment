CREATE TABLE [databus].[_DatabusDashboardMapCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDashboardMapCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDashboardMapCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDashboardMapCTCache] ([ctVersion], [ctSurrogateKey])

GO

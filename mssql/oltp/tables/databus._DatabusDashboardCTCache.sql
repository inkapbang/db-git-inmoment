CREATE TABLE [databus].[_DatabusDashboardCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDashboardCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDashboardCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDashboardCTCache] ([ctVersion], [ctSurrogateKey])

GO

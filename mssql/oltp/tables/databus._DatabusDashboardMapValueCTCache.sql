CREATE TABLE [databus].[_DatabusDashboardMapValueCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [dashboardMapObjectId] [int] NOT NULL,
   [levelObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDashboardMapValueCTCache_dashboardMapObjectId_levelObjectId] PRIMARY KEY CLUSTERED ([dashboardMapObjectId], [levelObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDashboardMapValueCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDashboardMapValueCTCache] ([ctVersion], [ctSurrogateKey])

GO

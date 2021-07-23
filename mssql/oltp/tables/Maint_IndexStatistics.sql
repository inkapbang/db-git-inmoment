CREATE TABLE [dbo].[Maint_IndexStatistics] (
   [tableName] [varchar](256) NOT NULL,
   [LOBPresent] [bit] NOT NULL,
   [numRows] [bigint] NOT NULL,
   [indexName] [varchar](512) NOT NULL,
   [indexId] [int] NOT NULL,
   [avg_fragmentation_in_percent] [float] NULL,
   [completeFlag] [bit] NULL
       DEFAULT ((0))

)

CREATE NONCLUSTERED INDEX [IX_IS_tableName] ON [dbo].[Maint_IndexStatistics] ([tableName])

GO

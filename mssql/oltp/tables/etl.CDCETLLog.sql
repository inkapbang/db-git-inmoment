CREATE TABLE [etl].[CDCETLLog] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [tableName] [nvarchar](50) NOT NULL,
   [lastObjectId] [bigint] NULL,
   [fileNumber] [int] NULL,
   [rundate] [datetime] NULL,
   [destination] [smallint] NULL
       DEFAULT ((1))

)

CREATE NONCLUSTERED INDEX [IX_CDCETLLog_tableName_destination] ON [etl].[CDCETLLog] ([tableName], [destination]) INCLUDE ([fileNumber])
CREATE NONCLUSTERED INDEX [IX_CDCETLLog_tableName_destination_includes] ON [etl].[CDCETLLog] ([tableName], [destination]) INCLUDE ([lastObjectId], [fileNumber])

GO

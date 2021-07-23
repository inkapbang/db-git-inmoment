CREATE TABLE [etl].[CDCETLLog_back2] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [tableName] [nvarchar](50) NOT NULL,
   [lastObjectId] [bigint] NULL,
   [fileNumber] [int] NULL,
   [rundate] [datetime] NULL,
   [destination] [smallint] NULL
)


GO

CREATE TABLE [etl].[CDCETLTablesback] (
   [tableName] [varchar](200) NOT NULL,
   [selectText] [varchar](4000) NOT NULL,
   [needsConvert] [bit] NOT NULL,
   [destinationTableName] [varchar](200) NULL,
   [ID] [varchar](200) NULL,
   [tableVersion] [int] NOT NULL,
   [isBigTable] [bit] NULL
)


GO

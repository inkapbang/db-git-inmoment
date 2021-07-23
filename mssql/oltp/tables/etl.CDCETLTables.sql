CREATE TABLE [etl].[CDCETLTables] (
   [tableName] [varchar](200) NOT NULL,
   [selectText] [varchar](4000) NOT NULL,
   [needsConvert] [bit] NOT NULL,
   [destinationTableName] [varchar](200) NULL,
   [ID] [varchar](200) NULL,
   [tableVersion] [int] NOT NULL
       DEFAULT ((1)),
   [isBigTable] [bit] NULL

   ,CONSTRAINT [PK__CDCETLTa__93F7AC695A50615C] PRIMARY KEY CLUSTERED ([tableName])
)


GO

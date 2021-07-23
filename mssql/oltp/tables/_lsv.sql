CREATE TABLE [dbo].[_lsv] (
   [localizedStringObjectId] [int] NOT NULL,
   [localeKey] [varchar](25) NOT NULL,
   [value] [nvarchar](max) NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)
)


GO

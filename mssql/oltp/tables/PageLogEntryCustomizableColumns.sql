CREATE TABLE [dbo].[PageLogEntryCustomizableColumns] (
   [pageLogEntryObjectId] [int] NOT NULL,
   [customizableColumns] [varchar](max) NULL

   ,CONSTRAINT [PK_PageLogEntryCustomizableColumns] PRIMARY KEY CLUSTERED ([pageLogEntryObjectId])
)


GO

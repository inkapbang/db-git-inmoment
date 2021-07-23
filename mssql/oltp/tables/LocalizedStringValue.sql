CREATE TABLE [dbo].[LocalizedStringValue] (
   [localizedStringObjectId] [int] NOT NULL,
   [localeKey] [varchar](25) NOT NULL,
   [value] [nvarchar](max) NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK__Localize__248AAE3F62B09D33] PRIMARY KEY CLUSTERED ([localizedStringObjectId], [localeKey])
)

CREATE NONCLUSTERED INDEX [ix_Localizedstringvalue_insertorder] ON [dbo].[LocalizedStringValue] ([insertOrder])
CREATE NONCLUSTERED INDEX [IX_LocalizedStringValue_Locale] ON [dbo].[LocalizedStringValue] ([localeKey])

GO

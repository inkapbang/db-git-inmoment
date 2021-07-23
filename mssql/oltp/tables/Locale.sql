CREATE TABLE [dbo].[Locale] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [localeKey] [varchar](25) NOT NULL,
   [sortOrder] [int] NOT NULL,
   [fontName] [varchar](100) NULL,
   [fontFileName] [varchar](100) NULL

   ,CONSTRAINT [PK_Locale] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_Locale_LocaleKey] UNIQUE NONCLUSTERED ([localeKey])
   ,CONSTRAINT [UK_Locale_SortOrder] UNIQUE NONCLUSTERED ([sortOrder])
)


GO

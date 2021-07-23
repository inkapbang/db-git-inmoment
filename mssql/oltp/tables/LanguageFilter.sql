CREATE TABLE [dbo].[LanguageFilter] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [language] [smallint] NOT NULL,
   [dirtyWord] [nvarchar](200) NOT NULL,
   [matchType] [smallint] NOT NULL

   ,CONSTRAINT [PK_LanguageFilter] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UQ_language_filter] UNIQUE NONCLUSTERED ([language], [dirtyWord], [matchType])
)


GO

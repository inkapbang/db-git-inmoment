CREATE TABLE [dbo].[SurveyMessage] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [key] [varchar](255) NOT NULL,
   [locale] [varchar](100) NOT NULL,
   [value] [nvarchar](max) NOT NULL

   ,CONSTRAINT [PK_SurveyMessages] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_SurveyMessage_key_locale] ON [dbo].[SurveyMessage] ([key], [locale]) INCLUDE ([value])
CREATE NONCLUSTERED INDEX [IX_SurveyMessage_locale] ON [dbo].[SurveyMessage] ([locale]) INCLUDE ([key], [value])

GO

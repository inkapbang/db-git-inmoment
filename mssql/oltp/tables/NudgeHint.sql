CREATE TABLE [dbo].[NudgeHint] (
   [trigger] [nvarchar](400) NOT NULL,
   [locale] [varchar](20) NOT NULL,
   [hint] [nvarchar](2000) NOT NULL

   ,CONSTRAINT [PK_NudgeHint] PRIMARY KEY CLUSTERED ([trigger], [locale])
)


GO

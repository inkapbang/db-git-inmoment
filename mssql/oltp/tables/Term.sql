CREATE TABLE [dbo].[Term] (
   [objectId] [bigint] NOT NULL
      IDENTITY (1,1),
   [text] [nvarchar](200) NOT NULL,
   [wordCount] [int] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_Term] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Term_text] ON [dbo].[Term] ([text])
CREATE NONCLUSTERED INDEX [ix_term_text_incl] ON [dbo].[Term] ([text]) INCLUDE ([objectId], [wordCount], [version])

GO

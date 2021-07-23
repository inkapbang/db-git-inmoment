CREATE TABLE [dbo].[AudioOption] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](50) NOT NULL,
   [description] [varchar](2000) NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [language] [int] NULL,
   [gender] [int] NULL

   ,CONSTRAINT [PK_AudioOption] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_AudioOption_language] ON [dbo].[AudioOption] ([language])

GO

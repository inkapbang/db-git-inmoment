CREATE TABLE [dbo].[TranslatorAudioOption] (
   [userAccountObjectId] [int] NOT NULL,
   [audioOptionObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_TranslatorAudioOption] PRIMARY KEY CLUSTERED ([userAccountObjectId], [audioOptionObjectId])
)

CREATE NONCLUSTERED INDEX [IX_TranslatorAudioOption_audioOptionObjectId] ON [dbo].[TranslatorAudioOption] ([audioOptionObjectId])

GO

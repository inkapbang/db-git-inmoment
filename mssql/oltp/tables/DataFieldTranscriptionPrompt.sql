CREATE TABLE [dbo].[DataFieldTranscriptionPrompt] (
   [dataFieldObjectId] [int] NOT NULL,
   [promptObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_DataFieldTranscriptionPrompt] PRIMARY KEY CLUSTERED ([dataFieldObjectId], [promptObjectId])
)

CREATE NONCLUSTERED INDEX [IX_DataFieldTranscriptionPrompt_promptObjectId] ON [dbo].[DataFieldTranscriptionPrompt] ([promptObjectId])

GO

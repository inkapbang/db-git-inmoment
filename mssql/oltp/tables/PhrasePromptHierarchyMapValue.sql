CREATE TABLE [dbo].[PhrasePromptHierarchyMapValue] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [phraseObjectId] [int] NOT NULL,
   [promptHierarchyMapValueObjectId] [int] NOT NULL,
   [webText] [nvarchar](max) NULL,
   [placeholderText] [nvarchar](max) NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_PromptPhrasePromptHierarchyMapValue] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PhrasePromptHierarchyMapValue_Phrase] ON [dbo].[PhrasePromptHierarchyMapValue] ([phraseObjectId])
CREATE NONCLUSTERED INDEX [IX_PhrasePromptHierarchyMapValue_PromptHierarchyMapValue] ON [dbo].[PhrasePromptHierarchyMapValue] ([promptHierarchyMapValueObjectId])

GO

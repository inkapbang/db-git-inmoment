CREATE TABLE [dbo].[CombinedTextPromptMapping] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [promptObjectId] [int] NULL,
   [sequence] [int] NULL,
   [dataFieldObjectId] [int] NULL,
   [maxLength] [int] NOT NULL,
   [padNullValues] [bit] NOT NULL,
   [paddingOption] [int] NOT NULL,
   [paddingCharacter] [varchar](15) NULL,
   [version] [int] NOT NULL,
   [formatterId] [int] NULL

   ,CONSTRAINT [PK__Combined__5243E26A5025A869] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_CombinedTextPromptMapping_dataFieldObjectId] ON [dbo].[CombinedTextPromptMapping] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_CombinedTextPromptMapping_promptObjectId] ON [dbo].[CombinedTextPromptMapping] ([promptObjectId])

GO

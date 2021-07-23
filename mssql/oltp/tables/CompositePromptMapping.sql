CREATE TABLE [dbo].[CompositePromptMapping] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [promptObjectId] [int] NULL,
   [sequence] [int] NULL,
   [dataFieldObjectId] [int] NULL,
   [length] [int] NOT NULL,
   [version] [int] NOT NULL,
   [maxLength] [int] NULL,
   [indices] [varchar](300) NULL

   ,CONSTRAINT [PK_CompositePromptMapping] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_CompositePromptMapping_dataFieldObjectId] ON [dbo].[CompositePromptMapping] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_CompositePromptMapping_promptObjectId] ON [dbo].[CompositePromptMapping] ([promptObjectId])

GO

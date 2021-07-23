CREATE TABLE [dbo].[ResponseCriterion] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [feedbackChannelObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [sequence] [int] NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_ResponseCriterion] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_ResponseCriterion_DataField] UNIQUE NONCLUSTERED ([feedbackChannelObjectId], [dataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ResponseCriterion_dataFieldObjectId] ON [dbo].[ResponseCriterion] ([dataFieldObjectId])

GO

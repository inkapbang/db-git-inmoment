CREATE TABLE [dbo].[FeedbackChannelType] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [labelObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL

   ,CONSTRAINT [PK_FeedbackChannelType] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_FeedbackChannelType_Name] UNIQUE NONCLUSTERED ([name])
)

CREATE NONCLUSTERED INDEX [IX_FeedbackChannelType_LocalizedString] ON [dbo].[FeedbackChannelType] ([labelObjectId])

GO

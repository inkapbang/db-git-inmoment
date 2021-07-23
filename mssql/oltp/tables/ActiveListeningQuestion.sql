CREATE TABLE [dbo].[ActiveListeningQuestion] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [tagObjectId] [int] NULL,
   [mappingObjectId] [int] NULL,
   [language] [int] NOT NULL,
   [question] [nvarchar](1000) NOT NULL

   ,CONSTRAINT [PK_ActiveListeningQuestion] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ActiveListeningQuestion_mappingObjectId_language] ON [dbo].[ActiveListeningQuestion] ([mappingObjectId], [language])
CREATE NONCLUSTERED INDEX [IX_ActiveListeningQuestion_tagObjectId_language] ON [dbo].[ActiveListeningQuestion] ([tagObjectId], [language])

GO

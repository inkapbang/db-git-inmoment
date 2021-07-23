CREATE TABLE [dbo].[ResponseTag] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [responseObjectId] [int] NOT NULL,
   [tagObjectId] [int] NOT NULL,
   [sourceType] [int] NOT NULL,
   [userAccountObjectId] [int] NULL,
   [timestamp] [datetime] NOT NULL,
   [transcriptionConfidence] [float] NULL,
   [transcriptionConfidenceLevel] [tinyint] NULL,
   [tagVersion] [int] NULL,
   [pearSource] [int] NULL,
   [pearModelObjectId] [int] NULL

   ,CONSTRAINT [PK_ResponseTag] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_ResponseTag_ResponseTag] UNIQUE NONCLUSTERED ([responseObjectId], [tagObjectId], [pearModelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ResponseTag_pearModelObjectId] ON [dbo].[ResponseTag] ([pearModelObjectId])
CREATE NONCLUSTERED INDEX [IX_ResponseTag_responseObjectId] ON [dbo].[ResponseTag] ([responseObjectId])
CREATE NONCLUSTERED INDEX [IX_ResponseTag_Tag_Response] ON [dbo].[ResponseTag] ([tagObjectId], [responseObjectId])
CREATE NONCLUSTERED INDEX [IX_ResponseTag_UserAccount] ON [dbo].[ResponseTag] ([userAccountObjectId])

GO

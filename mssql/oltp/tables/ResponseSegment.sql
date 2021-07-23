CREATE TABLE [dbo].[ResponseSegment] (
   [responseObjectId] [int] NOT NULL,
   [segmentObjectId] [int] NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_ResponseSegment] PRIMARY KEY CLUSTERED ([responseObjectId], [segmentObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ResponseSegment_by_Segment_UserAccount] ON [dbo].[ResponseSegment] ([segmentObjectId], [responseObjectId])
CREATE NONCLUSTERED INDEX [IX_ResponseSegment_by_UserAccount_Segment] ON [dbo].[ResponseSegment] ([responseObjectId], [segmentObjectId])

GO

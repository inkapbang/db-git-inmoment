CREATE TABLE [dbo].[UserAccountSegment] (
   [userAccountObjectId] [int] NOT NULL,
   [segmentObjectId] [int] NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_UserAccountSegment] PRIMARY KEY CLUSTERED ([userAccountObjectId], [segmentObjectId])
)

CREATE NONCLUSTERED INDEX [IX_UserAccountSegment_by_Segment_UserAccount] ON [dbo].[UserAccountSegment] ([segmentObjectId], [userAccountObjectId])
CREATE NONCLUSTERED INDEX [IX_UserAccountSegment_by_UserAccount_Segment] ON [dbo].[UserAccountSegment] ([userAccountObjectId], [segmentObjectId])

GO

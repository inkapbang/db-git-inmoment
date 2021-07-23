CREATE TABLE [dbo].[UserAccountSegmentType] (
   [userAccountObjectId] [int] NOT NULL,
   [segmentTypeObjectId] [int] NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_UserAccountSegmentType] PRIMARY KEY CLUSTERED ([userAccountObjectId], [segmentTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_UserAccountSegmentType_by_SegmentType_UserAccount] ON [dbo].[UserAccountSegmentType] ([segmentTypeObjectId], [userAccountObjectId])
CREATE NONCLUSTERED INDEX [IX_UserAccountSegmentType_by_UserAccount_SegmentType] ON [dbo].[UserAccountSegmentType] ([userAccountObjectId], [segmentTypeObjectId])

GO

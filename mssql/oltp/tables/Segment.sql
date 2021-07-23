CREATE TABLE [dbo].[Segment] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [nameObjectId] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [segmentTypeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_Segment] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Segment_by_Name] ON [dbo].[Segment] ([nameObjectId])
CREATE NONCLUSTERED INDEX [IX_Segment_by_Organization] ON [dbo].[Segment] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_Segment_by_SegmentType] ON [dbo].[Segment] ([segmentTypeObjectId])

GO

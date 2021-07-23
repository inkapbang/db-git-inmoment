CREATE TABLE [dbo].[SegmentType] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [nameObjectId] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [implicitResponseFilter] [bit] NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_SegmentType] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SegmentType_by_Name] ON [dbo].[SegmentType] ([nameObjectId])
CREATE NONCLUSTERED INDEX [IX_SegmentType_by_Organization] ON [dbo].[SegmentType] ([organizationObjectId])

GO

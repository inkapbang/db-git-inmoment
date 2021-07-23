CREATE TABLE [dbo].[HubViewUserSegment] (
   [hubViewObjectId] [int] NOT NULL,
   [segmentObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_HubViewUserSegment] PRIMARY KEY CLUSTERED ([hubViewObjectId], [segmentObjectId])
)


GO

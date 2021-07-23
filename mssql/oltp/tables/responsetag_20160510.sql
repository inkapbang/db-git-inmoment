CREATE TABLE [dbo].[responsetag_20160510] (
   [objectId] [int] NOT NULL,
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

)

CREATE CLUSTERED INDEX [idx] ON [dbo].[responsetag_20160510] ([objectId])

GO

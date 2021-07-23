CREATE TABLE [dbo].[_UserAssignedFocusArea2] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [performanceAttributeObjectId] [int] NOT NULL,
   [beginDate] [datetime] NOT NULL,
   [endDate] [datetime] NOT NULL
)


GO

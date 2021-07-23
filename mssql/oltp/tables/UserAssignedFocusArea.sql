CREATE TABLE [dbo].[UserAssignedFocusArea] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [performanceAttributeObjectId] [int] NOT NULL,
   [beginDate] [datetime] NOT NULL,
   [endDate] [datetime] NOT NULL

   ,CONSTRAINT [PK_UserAssignedFocusArea] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_UserAssignedFocusArea_locationObjectId] ON [dbo].[UserAssignedFocusArea] ([locationObjectId])
CREATE NONCLUSTERED INDEX [IX_UserAssignedFocusArea_performanceAttributeObjectId] ON [dbo].[UserAssignedFocusArea] ([performanceAttributeObjectId])

GO

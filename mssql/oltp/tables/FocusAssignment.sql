CREATE TABLE [dbo].[FocusAssignment] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [performanceAttributeObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [focusCycleObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NULL,
   [focusAssigner] [int] NOT NULL,
   [assignmentDate] [datetime] NOT NULL
       DEFAULT (getdate()),
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_FocusAssignment] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UN_FocusAssignment_PerfAttr_Location_Cycle] UNIQUE NONCLUSTERED ([performanceAttributeObjectId], [locationObjectId], [focusCycleObjectId])
)

CREATE NONCLUSTERED INDEX [IX_FocusAssignment_FocusCycle] ON [dbo].[FocusAssignment] ([focusCycleObjectId])
CREATE NONCLUSTERED INDEX [IX_FocusAssignment_Location] ON [dbo].[FocusAssignment] ([locationObjectId])
CREATE NONCLUSTERED INDEX [IX_FocusAssignment_UserAccount] ON [dbo].[FocusAssignment] ([userAccountObjectId])

GO

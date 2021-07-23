ALTER TABLE [dbo].[FocusAssignment] WITH CHECK ADD CONSTRAINT [FK_FocusAssignment_FocusCycle]
   FOREIGN KEY([focusCycleObjectId]) REFERENCES [dbo].[FocusCycle] ([objectId])

GO
ALTER TABLE [dbo].[FocusAssignment] WITH CHECK ADD CONSTRAINT [FK_FocusAssignment_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[FocusAssignment] WITH CHECK ADD CONSTRAINT [FK_FocusAssignment_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO

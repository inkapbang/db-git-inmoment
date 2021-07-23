ALTER TABLE [dbo].[DashboardFilterSelectedTags] WITH CHECK ADD CONSTRAINT [FK_DFSTags_DashboardFilter]
   FOREIGN KEY([dashboardFilterId]) REFERENCES [dbo].[DashboardFilter] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardFilterSelectedTags] WITH CHECK ADD CONSTRAINT [FK_DFSTags_LocationAttribute]
   FOREIGN KEY([tagId]) REFERENCES [dbo].[Tag] ([objectId])
   ON DELETE CASCADE

GO

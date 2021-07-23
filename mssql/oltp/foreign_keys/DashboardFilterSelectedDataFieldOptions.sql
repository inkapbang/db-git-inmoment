ALTER TABLE [dbo].[DashboardFilterSelectedDataFieldOptions] WITH CHECK ADD CONSTRAINT [FK_DFSDataFieldOptions_DashboardFilter]
   FOREIGN KEY([dashboardFilterId]) REFERENCES [dbo].[DashboardFilter] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardFilterSelectedDataFieldOptions] WITH CHECK ADD CONSTRAINT [FK_DFSDataFieldOptions_DataFieldOption]
   FOREIGN KEY([dataFieldOptionId]) REFERENCES [dbo].[DataFieldOption] ([objectId])
   ON DELETE CASCADE

GO

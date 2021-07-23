ALTER TABLE [dbo].[ComponentDataFields] WITH CHECK ADD CONSTRAINT [FK_ComponentDataFields_DashboardComponent]
   FOREIGN KEY([componentID]) REFERENCES [dbo].[DashboardComponent] ([objectId])

GO
ALTER TABLE [dbo].[ComponentDataFields] WITH CHECK ADD CONSTRAINT [FK_ComponentDataFields_DataField]
   FOREIGN KEY([dataFieldID]) REFERENCES [dbo].[DataField] ([objectId])

GO

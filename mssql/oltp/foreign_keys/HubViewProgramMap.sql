ALTER TABLE [dbo].[HubViewProgramMap] WITH CHECK ADD CONSTRAINT [FK_HubViewProgramMap_HubViewID]
   FOREIGN KEY([hubViewObjectId]) REFERENCES [dbo].[HubView] ([objectId])
   ON DELETE CASCADE

GO

ALTER TABLE [dbo].[PearModelModelMapSet] WITH CHECK ADD CONSTRAINT [FK_PearModelModelMapSet_ModelMap]
   FOREIGN KEY([childPearModelObjectId]) REFERENCES [dbo].[PearModel] ([objectId])

GO
ALTER TABLE [dbo].[PearModelModelMapSet] WITH CHECK ADD CONSTRAINT [FK_PearModelModelMapSet_PearModel]
   FOREIGN KEY([pearModelObjectId]) REFERENCES [dbo].[PearModel] ([objectId])

GO

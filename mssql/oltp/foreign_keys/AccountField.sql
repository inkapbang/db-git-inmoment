ALTER TABLE [dbo].[AccountField] WITH CHECK ADD CONSTRAINT [FK_AccountField_Account]
   FOREIGN KEY([accountObjectId]) REFERENCES [dbo].[Account] ([objectId])

GO
ALTER TABLE [dbo].[AccountField] WITH CHECK ADD CONSTRAINT [FK_AccountField_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO

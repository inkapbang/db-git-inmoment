ALTER TABLE [dbo].[CrosstabField] WITH CHECK ADD CONSTRAINT [FK_CrosstabField_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[CrosstabField] WITH CHECK ADD CONSTRAINT [FK_CrosstabField_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[CrosstabField] WITH CHECK ADD CONSTRAINT [FK_CrosstabField_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO

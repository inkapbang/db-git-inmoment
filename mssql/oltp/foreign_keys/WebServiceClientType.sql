ALTER TABLE [dbo].[WebServiceClientType] WITH CHECK ADD CONSTRAINT [FK_WebServiceClientType_WebServiceClient]
   FOREIGN KEY([webServiceClientObjectId]) REFERENCES [dbo].[WebServiceClient] ([objectId])

GO

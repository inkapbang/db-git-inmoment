ALTER TABLE [dbo].[WebServiceClientVersion] WITH CHECK ADD CONSTRAINT [FK_WebServiceClientVersion_WebServiceClient]
   FOREIGN KEY([webServiceClientObjectId]) REFERENCES [dbo].[WebServiceClient] ([objectId])

GO

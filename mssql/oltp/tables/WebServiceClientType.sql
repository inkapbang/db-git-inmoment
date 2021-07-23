CREATE TABLE [dbo].[WebServiceClientType] (
   [webServiceClientObjectId] [int] NOT NULL,
   [clientType] [int] NOT NULL

   ,CONSTRAINT [PK_WebServiceClientType] PRIMARY KEY CLUSTERED ([webServiceClientObjectId], [clientType])
)


GO

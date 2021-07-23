CREATE TABLE [dbo].[WebServiceClient] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [clientName] [nvarchar](100) NOT NULL,
   [clientSecret] [nvarchar](100) NOT NULL,
   [webServerRedirectUri] [nvarchar](max) NULL,
   [organizationObjectId] [int] NULL,
   [enabled] [bit] NOT NULL,
   [technicalContactEmail] [nvarchar](100) NULL

   ,CONSTRAINT [PK_WebServiceClient] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_WebServiceClient_Organization] ON [dbo].[WebServiceClient] ([organizationObjectId])

GO

CREATE TABLE [dbo].[WebServiceClientVersion] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [webServiceClientObjectId] [int] NOT NULL,
   [clientId] [nvarchar](100) NOT NULL,
   [majorVersion] [int] NOT NULL,
   [minorVersion] [int] NOT NULL,
   [revision] [int] NOT NULL,
   [enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_WebServiceClientVersion] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_WebServiceClientVersion_client_majorVersion_minorVersion_revision] UNIQUE NONCLUSTERED ([webServiceClientObjectId], [majorVersion], [minorVersion], [revision])
   ,CONSTRAINT [UK_WebServiceClientVersion_clientId] UNIQUE NONCLUSTERED ([clientId])
)


GO

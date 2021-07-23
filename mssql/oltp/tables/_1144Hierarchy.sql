CREATE TABLE [dbo].[_1144Hierarchy] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](100) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [singletonLocations] [bit] NOT NULL,
   [version] [int] NOT NULL,
   [branded] [bit] NOT NULL,
   [externalId] [varchar](255) NULL
)


GO

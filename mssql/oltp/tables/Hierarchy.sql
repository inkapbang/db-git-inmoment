CREATE TABLE [dbo].[Hierarchy] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](100) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [singletonLocations] [bit] NOT NULL,
   [version] [int] NOT NULL,
   [branded] [bit] NOT NULL
       DEFAULT ((0)),
   [externalId] [varchar](255) NULL

   ,CONSTRAINT [PK_Hierarchy] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Hierarchy_Organization] ON [dbo].[Hierarchy] ([organizationObjectId])

GO

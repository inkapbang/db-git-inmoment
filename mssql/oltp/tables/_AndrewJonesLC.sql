CREATE TABLE [dbo].[_AndrewJonesLC] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [nvarchar](100) NULL,
   [organizationObjectId] [int] NOT NULL,
   [parentObjectId] [int] NULL,
   [depth] [tinyint] NOT NULL,
   [lineage] [varchar](255) NULL,
   [LocationCategoryTypeObjectId] [int] NULL,
   [lineageSort] [varchar](265) NULL,
   [version] [int] NOT NULL,
   [timeZone] [varchar](50) NOT NULL,
   [externalId] [varchar](255) NULL,
   [rootObjectId] [int] NULL,
   [leftExtent] [int] NULL,
   [rightExtent] [int] NULL,
   [reviewOptIn] [bit] NULL,
   [reviewAggregate] [bit] NULL,
   [reviewUrl] [varchar](100) NULL,
   [brandObjectId] [int] NOT NULL
)


GO

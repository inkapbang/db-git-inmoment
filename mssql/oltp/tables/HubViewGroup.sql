CREATE TABLE [dbo].[HubViewGroup] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [viewGroupType] [int] NOT NULL,
   [name] [nvarchar](100) NOT NULL,
   [labelObjectId] [int] NULL,
   [organizationObjectId] [int] NOT NULL,
   [iconClass] [nvarchar](50) NULL,
   [rightIconImgUrlKey] [nvarchar](50) NULL,
   [sequence] [int] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_HubViewGroup] PRIMARY KEY CLUSTERED ([objectId])
)


GO

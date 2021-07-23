CREATE TABLE [dbo].[SocialLocation] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [locationObjectId] [int] NOT NULL,
   [socialType] [int] NOT NULL,
   [platformId] [varchar](800) NULL,
   [name] [varchar](100) NULL,
   [lastMax] [varchar](100) NULL,
   [pageId] [varchar](500) NULL,
   [lastPullTime] [bigint] NULL,
   [actionText] [nvarchar](max) NULL,
   [actionUrl] [varchar](500) NULL,
   [actionImageId] [int] NULL,
   [headerImageId] [int] NULL,
   [socialVocStatus] [int] NOT NULL
       DEFAULT ((0)),
   [apiPulled] [bit] NULL,
   [address] [varchar](500) NULL,
   [phoneNumber] [varchar](50) NULL,
   [yelpId] [varchar](32) NULL,
   [invalidPageId] [bit] NULL,
   [yelpSubscribed] [bit] NULL

   ,CONSTRAINT [PK_SocialLocation] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_SocialLocation] UNIQUE NONCLUSTERED ([locationObjectId], [socialType])
)

CREATE NONCLUSTERED INDEX [IX_SocialLocation_actionImageId] ON [dbo].[SocialLocation] ([actionImageId])
CREATE NONCLUSTERED INDEX [IX_SocialLocation_headerImageId] ON [dbo].[SocialLocation] ([headerImageId])
CREATE NONCLUSTERED INDEX [IX_SocialLocation_yelpId] ON [dbo].[SocialLocation] ([invalidPageId], [yelpId], [yelpSubscribed]) WHERE ([socialType]=(3))

GO

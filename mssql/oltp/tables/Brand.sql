CREATE TABLE [dbo].[Brand] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [name] [varchar](200) NOT NULL,
   [logoObjectId] [int] NULL,
   [bannerObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [reviewBannerObjectId] [int] NULL,
   [reviewDefaultLocationObjectId] [int] NULL,
   [parentObjectId] [int] NULL,
   [logotypeObjectId] [int] NULL,
   [accentColor] [varchar](50) NULL

   ,CONSTRAINT [IX_Brand_UniqueName] UNIQUE NONCLUSTERED ([organizationObjectId], [name])
   ,CONSTRAINT [PK__Brand__04D20FF1] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Brand_by_BannerObjectid] ON [dbo].[Brand] ([bannerObjectId])
CREATE NONCLUSTERED INDEX [IX_Brand_by_LogoObjectid] ON [dbo].[Brand] ([logoObjectId])
CREATE NONCLUSTERED INDEX [IX_Brand_by_logotypeObjectId] ON [dbo].[Brand] ([logotypeObjectId])
CREATE NONCLUSTERED INDEX [IX_Brand_Image_ReviewBanner] ON [dbo].[Brand] ([reviewBannerObjectId])
CREATE NONCLUSTERED INDEX [IX_Brand_Image_ReviewDefaultLocation] ON [dbo].[Brand] ([reviewDefaultLocationObjectId])
CREATE NONCLUSTERED INDEX [IX_Brand_parentObjectId] ON [dbo].[Brand] ([parentObjectId])

GO

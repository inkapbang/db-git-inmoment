CREATE TABLE [dbo].[Location] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [nvarchar](100) NULL,
   [addressObjectId] [int] NULL,
   [contactInfoObjectId] [int] NULL,
   [organizationObjectId] [int] NOT NULL,
   [locationNumber] [varchar](50) NULL,
   [hidden] [bit] NOT NULL
       DEFAULT (0),
   [startDate] [datetime] NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [enabled] [bit] NOT NULL
       DEFAULT (1),
   [nameInSurvey] [nvarchar](100) NULL,
   [vxml] [varchar](500) NULL,
   [timeZone] [varchar](50) NOT NULL
       DEFAULT ('America/Denver'),
   [logoObjectId] [int] NULL,
   [reviewOptIn] [bit] NULL,
   [url] [varchar](1000) NULL,
   [description] [varchar](4000) NULL,
   [reviewUrl] [varchar](100) NULL,
   [facebook] [varchar](500) NULL,
   [google] [varchar](500) NULL,
   [yelp] [varchar](500) NULL,
   [tripAdvisor] [varchar](500) NULL,
   [twitterHashtagHandle] [varchar](500) NULL,
   [facebookPage] [varchar](500) NULL,
   [googlePage] [varchar](500) NULL,
   [yelpPage] [varchar](500) NULL,
   [tripAdvisorPage] [varchar](500) NULL,
   [twitterHandle] [varchar](500) NULL,
   [searchedSocialLocations] [bit] NULL,
   [unitCode] [varchar](50) NULL,
   [socialIntegrationEnabled] [bit] NOT NULL
       DEFAULT ((0)),
   [exemptFromAutoDisable] [bit] NULL
      CONSTRAINT [DF_Location_ExemptFromAutoDisable] DEFAULT ((0)),
   [brandObjectId] [int] NULL

   ,CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [ix_IndexName] ON [dbo].[Location] ([organizationObjectId]) INCLUDE ([objectId], [name], [addressObjectId], [contactInfoObjectId], [locationNumber], [hidden], [startDate], [version], [enabled], [nameInSurvey], [vxml], [timeZone], [logoObjectId], [reviewOptIn], [url], [description])
CREATE NONCLUSTERED INDEX [IX_Location_addressObjectId] ON [dbo].[Location] ([addressObjectId])
CREATE NONCLUSTERED INDEX [IX_Location_by_Organization] ON [dbo].[Location] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_Location_by_Organization_and_number] ON [dbo].[Location] ([organizationObjectId], [locationNumber])
CREATE NONCLUSTERED INDEX [IX_Location_contactInfoObjectId] ON [dbo].[Location] ([contactInfoObjectId])
CREATE NONCLUSTERED INDEX [IX_Location_enabled] ON [dbo].[Location] ([enabled]) INCLUDE ([objectId], [name], [addressObjectId])
CREATE NONCLUSTERED INDEX [IX_Location_FK_BrandObjectId_Brand] ON [dbo].[Location] ([brandObjectId])
CREATE NONCLUSTERED INDEX [IX_Location_Image_logo] ON [dbo].[Location] ([logoObjectId])
CREATE NONCLUSTERED INDEX [IX_Location_organizationObjectId] ON [dbo].[Location] ([organizationObjectId]) INCLUDE ([objectId], [name], [addressObjectId], [contactInfoObjectId], [locationNumber], [hidden], [startDate], [version], [enabled], [nameInSurvey], [vxml], [timeZone], [logoObjectId], [reviewOptIn], [url], [description], [reviewUrl], [facebookPage], [googlePage], [yelpPage], [tripAdvisorPage], [twitterHandle])
CREATE NONCLUSTERED INDEX [IX_Location_organizationObjectId_enabled_objectId] ON [dbo].[Location] ([organizationObjectId], [enabled], [objectId]) INCLUDE ([locationNumber])
CREATE NONCLUSTERED INDEX [IX_Location_organizationObjectId_enabled_objectId2] ON [dbo].[Location] ([organizationObjectId], [enabled], [objectId]) INCLUDE ([unitCode])
CREATE NONCLUSTERED INDEX [ix_Location_organizationobjectidinclude] ON [dbo].[Location] ([organizationObjectId]) INCLUDE ([objectId], [name], [addressObjectId], [contactInfoObjectId], [locationNumber], [hidden], [startDate], [version], [enabled], [nameInSurvey], [vxml], [timeZone], [logoObjectId], [reviewOptIn], [url], [description], [reviewUrl], [facebookPage], [googlePage], [yelpPage], [tripAdvisorPage], [twitterHandle])
CREATE NONCLUSTERED INDEX [ix_location_Orgid] ON [dbo].[Location] ([organizationObjectId]) INCLUDE ([objectId], [name], [addressObjectId], [contactInfoObjectId], [locationNumber], [hidden], [startDate], [version], [enabled], [nameInSurvey], [vxml], [timeZone], [logoObjectId], [reviewOptIn], [url], [description], [reviewUrl], [facebook], [google], [yelp], [tripAdvisor], [twitterHashtagHandle])
CREATE UNIQUE NONCLUSTERED INDEX [IX_Location_UnitCode_OrganizationId] ON [dbo].[Location] ([unitCode], [organizationObjectId]) WHERE ([unitCode] IS NOT NULL AND [enabled]=(1))

GO

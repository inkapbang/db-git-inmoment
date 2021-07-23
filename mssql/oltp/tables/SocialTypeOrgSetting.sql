CREATE TABLE [dbo].[SocialTypeOrgSetting] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [socialType] [int] NOT NULL,
   [typeId] [varchar](500) NULL,
   [frequencyMinutes] [int] NOT NULL,
   [ratingFieldObjectId] [int] NULL,
   [categoryString] [varchar](500) NULL,
   [recommendsFieldObjectId] [int] NULL

   ,CONSTRAINT [PK_SocialTypeOrgSetting] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SocialTypeOrgSetting_by_org_socialType] ON [dbo].[SocialTypeOrgSetting] ([organizationObjectId], [socialType]) INCLUDE ([typeId], [frequencyMinutes])
CREATE NONCLUSTERED INDEX [IX_SocialTypeOrgSetting_by_ratingField] ON [dbo].[SocialTypeOrgSetting] ([ratingFieldObjectId])

GO

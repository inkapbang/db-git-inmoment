CREATE TABLE [dbo].[PublicReviewSettingsBrand] (
   [publicReviewSettingsObjectId] [int] NOT NULL,
   [brandObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PublicReviewSettingsBrand] PRIMARY KEY CLUSTERED ([publicReviewSettingsObjectId], [brandObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PublicReviewSettingsBrand_brandObjectId] ON [dbo].[PublicReviewSettingsBrand] ([brandObjectId])

GO

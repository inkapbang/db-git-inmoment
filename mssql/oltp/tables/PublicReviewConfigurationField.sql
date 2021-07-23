CREATE TABLE [dbo].[PublicReviewConfigurationField] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NULL,
   [sequence] [int] NOT NULL,
   [type] [int] NOT NULL,
   [expand] [bit] NOT NULL
       DEFAULT ((0)),
   [publicReviewSettingsObjectId] [int] NULL

   ,CONSTRAINT [PK_PublicReviewConfigurationField] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PublicReviewConfigurationField_Organization] ON [dbo].[PublicReviewConfigurationField] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_PublicReviewConfigurationField_publicReviewSettingsObjectId] ON [dbo].[PublicReviewConfigurationField] ([publicReviewSettingsObjectId])

GO

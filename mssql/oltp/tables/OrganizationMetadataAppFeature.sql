CREATE TABLE [dbo].[OrganizationMetadataAppFeature] (
   [metadataObjectId] [int] NOT NULL,
   [appFeatureObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_OrganizationMetadataAppFeature] PRIMARY KEY CLUSTERED ([metadataObjectId], [appFeatureObjectId])
)


GO

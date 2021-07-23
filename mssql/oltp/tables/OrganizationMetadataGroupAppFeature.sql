CREATE TABLE [dbo].[OrganizationMetadataGroupAppFeature] (
   [metadataGroupObjectId] [int] NOT NULL,
   [appFeatureOrdinalId] [int] NOT NULL

   ,CONSTRAINT [PK_OrganizationMetadataGroupAppFeature] PRIMARY KEY CLUSTERED ([metadataGroupObjectId], [appFeatureOrdinalId])
)


GO

CREATE TABLE [dbo].[HierarchyDownloadJobConfig] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [fileNamePattern] [nvarchar](100) NOT NULL,
   [ftpProfileObjectId] [int] NOT NULL,
   [ftpDirectory] [nvarchar](500) NULL,
   [hierarchyFileVersion] [int] NOT NULL,
   [timeUnit] [int] NOT NULL,
   [timeUnitCount] [int] NOT NULL,
   [changedThreshold] [float] NOT NULL,
   [missingThreshold] [float] NOT NULL,
   [errorsThreshold] [float] NOT NULL,
   [enabled] [bit] NOT NULL,
   [version] [int] NOT NULL,
   [offerCodePolicyObjectId] [int] NULL,
   [reportMissingItems] [bit] NOT NULL,
   [startDate] [datetime] NOT NULL,
   [hierarchyTransformObjectid] [int] NULL,
   [autoDisableMissingItems] [bit] NOT NULL
      CONSTRAINT [DF_HierarchyDownloadJobConfig_AutoDisableMissingItems] DEFAULT ((0))

   ,CONSTRAINT [PK_HierarchyDownloadJobConfig] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HierarchyDownloadJobConfig_FtpProfile] ON [dbo].[HierarchyDownloadJobConfig] ([ftpProfileObjectId])
CREATE NONCLUSTERED INDEX [IX_HierarchyDownloadJobConfig_HierarchyTransform] ON [dbo].[HierarchyDownloadJobConfig] ([hierarchyTransformObjectid])
CREATE NONCLUSTERED INDEX [IX_HierarchyDownloadJobConfig_OfferCodePolicy] ON [dbo].[HierarchyDownloadJobConfig] ([offerCodePolicyObjectId])
CREATE NONCLUSTERED INDEX [IX_HierarchyDownloadJobConfig_Organization] ON [dbo].[HierarchyDownloadJobConfig] ([organizationObjectId])

GO

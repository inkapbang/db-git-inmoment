CREATE TABLE [dbo].[PublicReviewSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](200) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [reviewConfiguration] [int] NULL,
   [upliftModelObjectId] [int] NULL,
   [unstructuredFeedbackModelObjectId] [int] NULL,
   [responseTextObjectId] [int] NULL,
   [rootCategoryObjectId] [int] NULL,
   [hierarchyObjectId] [int] NULL,
   [disableLocationPages] [bit] NULL,
   [enableIndexing] [bit] NULL,
   [reviewUrl] [varchar](100) NULL,
   [reviewGoogleAnalytics] [varchar](20) NULL,
   [description] [nvarchar](4000) NULL

   ,CONSTRAINT [PK_PublicReviewSettings] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PublicReviewSettings_by_RootReviewCategory] ON [dbo].[PublicReviewSettings] ([rootCategoryObjectId])
CREATE NONCLUSTERED INDEX [IX_PublicReviewSettings_Hierarchy] ON [dbo].[PublicReviewSettings] ([hierarchyObjectId])
CREATE NONCLUSTERED INDEX [IX_PublicReviewSettings_organizationObjectId] ON [dbo].[PublicReviewSettings] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_PublicReviewSettings_responseTextObjectId] ON [dbo].[PublicReviewSettings] ([responseTextObjectId])
CREATE NONCLUSTERED INDEX [IX_PublicReviewSettings_unstructuredFeedbackModelObjectId] ON [dbo].[PublicReviewSettings] ([unstructuredFeedbackModelObjectId])
CREATE NONCLUSTERED INDEX [IX_PublicReviewSettings_upliftModelObjectId] ON [dbo].[PublicReviewSettings] ([upliftModelObjectId])

GO

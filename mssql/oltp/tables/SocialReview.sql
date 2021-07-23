CREATE TABLE [dbo].[SocialReview] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [socialType] [int] NOT NULL,
   [pageId] [varchar](400) NULL,
   [postId] [varchar](300) NULL,
   [authorId] [varchar](400) NULL,
   [authorName] [varchar](200) NULL,
   [version] [int] NULL,
   [surveyResponseObjectId] [int] NOT NULL,
   [socialPostType] [int] NULL,
   [orgId] [int] NOT NULL,
   [respondUrl] [varchar](2000) NULL,
   [businessUrl] [varchar](2000) NULL

   ,CONSTRAINT [PK_SocialReview] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [uq_postId_orgId] UNIQUE NONCLUSTERED ([postId], [orgId])
)

CREATE NONCLUSTERED INDEX [IX_SocialReview_PostIdAndSocialType] ON [dbo].[SocialReview] ([postId], [socialType])
CREATE NONCLUSTERED INDEX [IX_SocialReview_PostIdOrgIdSocialType] ON [dbo].[SocialReview] ([postId], [socialType], [orgId])
CREATE NONCLUSTERED INDEX [IX_SocialReview_socialType] ON [dbo].[SocialReview] ([socialType]) INCLUDE ([surveyResponseObjectId])
CREATE NONCLUSTERED INDEX [IX_SocialReview_sridIncludes] ON [dbo].[SocialReview] ([surveyResponseObjectId]) INCLUDE ([objectId], [socialType], [pageId], [postId], [authorId], [authorName], [version])

GO

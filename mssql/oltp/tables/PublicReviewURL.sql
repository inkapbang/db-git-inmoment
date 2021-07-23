CREATE TABLE [dbo].[PublicReviewURL] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NULL,
   [url] [varchar](200) NOT NULL,
   [locationCategoryObjectId] [int] NULL,
   [locationObjectId] [int] NULL,
   [active] [bit] NOT NULL

   ,CONSTRAINT [PK_PublicReviewURL] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PublicReviewURL_locationCategoryObjectId] ON [dbo].[PublicReviewURL] ([locationCategoryObjectId])
CREATE NONCLUSTERED INDEX [IX_PublicReviewURL_locationObjectId] ON [dbo].[PublicReviewURL] ([locationObjectId])

GO

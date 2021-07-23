CREATE TABLE [dbo].[PublicReviewCategory] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NULL,
   [label] [varchar](100) NOT NULL,
   [url] [varchar](100) NOT NULL,
   [parentObjectId] [int] NULL,
   [collapseChildren] [bit] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_PublicReviewCategory] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PublicReviewCategory_parentObjectId] ON [dbo].[PublicReviewCategory] ([parentObjectId])

GO

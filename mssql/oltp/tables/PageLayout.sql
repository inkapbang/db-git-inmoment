CREATE TABLE [dbo].[PageLayout] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [pageObjectId] [int] NOT NULL,
   [orientation] [int] NULL,
   [defaultSize] [int] NULL

   ,CONSTRAINT [PK_PageLayout] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PageLayout_pageObjectId] ON [dbo].[PageLayout] ([pageObjectId])

GO

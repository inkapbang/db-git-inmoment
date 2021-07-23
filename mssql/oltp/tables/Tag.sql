CREATE TABLE [dbo].[Tag] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NULL,
   [nameObjectId] [int] NULL,
   [enabled] [bit] NOT NULL
       DEFAULT ((1)),
   [labelObjectId] [int] NULL,
   [sequence] [int] NULL
       DEFAULT ((0)),
   [tagCategoryObjectId] [int] NULL
       DEFAULT ((0)),
   [visibleInInbox] [bit] NOT NULL
       DEFAULT ((1)),
   [name] [varchar](100) NOT NULL,
   [weight] [tinyint] NOT NULL
      CONSTRAINT [DF_Tag_Weight] DEFAULT ((0)),
   [custom] [bit] NULL,
   [annotationBestMatch] [nvarchar](500) NULL,
   [suggestedTagCategoryObjectId] [int] NULL,
   [primaryUse] [int] NULL,
   [adHocUse] [int] NULL,
   [activeListeningAnnotationType] [int] NULL,
   [activeListeningAnnotationCategory] [int] NULL,
   [dictionaryTerms] [nvarchar](max) NULL,
   [smartCommentQuestion] [nvarchar](250) NULL,
   [accountId] [varchar](32) NULL,
   [programId] [varchar](32) NULL,
   [deleted] [bit] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Tag_AccountId_deleted_programId] ON [dbo].[Tag] ([accountId], [deleted], [programId]) INCLUDE ([objectId])
CREATE NONCLUSTERED INDEX [IX_Tag_name_LocalizedString] ON [dbo].[Tag] ([nameObjectId])
CREATE NONCLUSTERED INDEX [IX_Tag_Organization] ON [dbo].[Tag] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_Tag_programId_deleted] ON [dbo].[Tag] ([programId], [deleted]) INCLUDE ([objectId])
CREATE NONCLUSTERED INDEX [ix_Tag_visibleinbox] ON [dbo].[Tag] ([visibleInInbox]) INCLUDE ([objectId])
CREATE NONCLUSTERED INDEX [IX_TagCategoryObjectId] ON [dbo].[Tag] ([tagCategoryObjectId], [visibleInInbox]) INCLUDE ([objectId])

GO

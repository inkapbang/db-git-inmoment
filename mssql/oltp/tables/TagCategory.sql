CREATE TABLE [dbo].[TagCategory] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [creationDate] [datetime] NOT NULL
       DEFAULT (getdate()),
   [version] [int] NOT NULL
       DEFAULT ((1)),
   [organizationObjectId] [int] NULL,
   [nameObjectId] [int] NULL,
   [enabled] [bit] NOT NULL
       DEFAULT ((1)),
   [originalTagObjectId] [int] NOT NULL
       DEFAULT ((0)),
   [labelObjectId] [int] NOT NULL,
   [sequence] [int] NULL
       DEFAULT ((0)),
   [visibleInInbox] [bit] NOT NULL
       DEFAULT ((1)),
   [name] [varchar](100) NOT NULL,
   [custom] [bit] NULL,
   [adHocUse] [int] NULL

   ,CONSTRAINT [PK_TagCategory] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_TagCategory_labelObjectId] ON [dbo].[TagCategory] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_TagCategory_nameObjectId] ON [dbo].[TagCategory] ([nameObjectId])
CREATE NONCLUSTERED INDEX [IX_TagCategory_Organization] ON [dbo].[TagCategory] ([organizationObjectId])

GO

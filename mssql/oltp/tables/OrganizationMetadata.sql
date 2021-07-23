CREATE TABLE [dbo].[OrganizationMetadata] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [groupObjectId] [int] NULL,
   [name] [varchar](100) NOT NULL,
   [labelObjectId] [int] NOT NULL,
   [description] [varchar](1000) NULL,
   [sequence] [int] NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_OrganizationMetadata] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationMetadata_by_Sequence] ON [dbo].[OrganizationMetadata] ([sequence])
CREATE NONCLUSTERED INDEX [IX_OrganizationMetadata_LocalizedString] ON [dbo].[OrganizationMetadata] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_OrganizationMetadata_OrganizationMetadataGroup] ON [dbo].[OrganizationMetadata] ([groupObjectId])

GO

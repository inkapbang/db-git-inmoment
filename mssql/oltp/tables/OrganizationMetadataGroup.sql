CREATE TABLE [dbo].[OrganizationMetadataGroup] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [required] [bit] NOT NULL
       DEFAULT ((0)),
   [exclusive] [bit] NOT NULL
       DEFAULT ((0)),
   [sequence] [int] NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_OrganizationMetadataGroup] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationMetadataGroup_by_Sequence] ON [dbo].[OrganizationMetadataGroup] ([sequence])

GO

CREATE TABLE [dbo].[LocationAttribute] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [sequence] [int] NULL,
   [organizationObjectId] [int] NULL,
   [nameObjectId] [int] NOT NULL,
   [description] [nvarchar](1000) NULL,
   [version] [int] NOT NULL,
   [externalId] [varchar](50) NULL

   ,CONSTRAINT [PK_LocationAttribute] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_LocationAttribute_nameObjectId] ON [dbo].[LocationAttribute] ([nameObjectId])
CREATE NONCLUSTERED INDEX [IX_LocationAttribute_organizationObjectId] ON [dbo].[LocationAttribute] ([organizationObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [UK_LocationAttribute_organizationObjectId_externalId] ON [dbo].[LocationAttribute] ([organizationObjectId], [externalId]) WHERE ([externalId] IS NOT NULL)

GO

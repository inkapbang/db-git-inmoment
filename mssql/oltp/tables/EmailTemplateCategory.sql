CREATE TABLE [dbo].[EmailTemplateCategory] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [labelObjectId] [int] NOT NULL,
   [name] [nvarchar](100) NOT NULL

   ,CONSTRAINT [PK_EmailTemplateCategory] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_EmailTemplateCategory_LocalizedString] ON [dbo].[EmailTemplateCategory] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailTemplateCategory_Organization] ON [dbo].[EmailTemplateCategory] ([organizationObjectId])

GO

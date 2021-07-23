CREATE TABLE [dbo].[EmailTemplate] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [subjectObjectId] [int] NOT NULL,
   [noteObjectId] [int] NOT NULL,
   [nextState] [int] NOT NULL,
   [hidden] [bit] NOT NULL
      CONSTRAINT [DF_EmailTemplate_hidden] DEFAULT ((0)),
   [emailTemplateCategoryObjectId] [int] NULL,
   [organizationObjectId] [int] NOT NULL,
   [name] [nvarchar](100) NOT NULL,
   [labelObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_EmailTemplate] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_EmailTemplate_EmailTemplateCategory] ON [dbo].[EmailTemplate] ([emailTemplateCategoryObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailTemplate_LocalizedString] ON [dbo].[EmailTemplate] ([subjectObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailTemplate_LocalizedString1] ON [dbo].[EmailTemplate] ([noteObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailTemplate_LocalizedString2] ON [dbo].[EmailTemplate] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailTemplate_Organization] ON [dbo].[EmailTemplate] ([organizationObjectId])

GO

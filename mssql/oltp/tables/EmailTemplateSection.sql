CREATE TABLE [dbo].[EmailTemplateSection] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [emailTemplateObjectId] [int] NOT NULL,
   [editable] [bit] NOT NULL
      CONSTRAINT [DF_EmailTemplateSection_editable] DEFAULT ((1)),
   [textObjectId] [int] NOT NULL,
   [type] [int] NULL
      CONSTRAINT [DF__EmailTempl__Section__type] DEFAULT ((0)),
   [mandatory] [tinyint] NULL,
   [widthObjectId] [int] NULL,
   [heightObjectId] [int] NULL,
   [imgSrcObjectId] [int] NULL

   ,CONSTRAINT [PK_EmailTemplateSection] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_EmailTemplateSection_EmailTemplate] ON [dbo].[EmailTemplateSection] ([emailTemplateObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailTemplateSection_FK_EmlTmpSct_LocalizedString_Height] ON [dbo].[EmailTemplateSection] ([heightObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailTemplateSection_FK_EmlTmpSct_LocalizedString_Imgsrc] ON [dbo].[EmailTemplateSection] ([imgSrcObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailTemplateSection_FK_EmlTmpSct_LocalizedString_Width] ON [dbo].[EmailTemplateSection] ([widthObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailTemplateSection_LocalizedString] ON [dbo].[EmailTemplateSection] ([textObjectId])

GO

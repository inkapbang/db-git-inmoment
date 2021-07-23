CREATE TABLE [dbo].[ContactSettingsMatchRule] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [contactSettingsObjectId] [int] NULL,
   [sequence] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_ContactSettingsMatchRule] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ContactSettingsMatchRule_contactSettingsObjectId] ON [dbo].[ContactSettingsMatchRule] ([contactSettingsObjectId])

GO

CREATE TABLE [dbo].[ContactSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [createContact] [bit] NOT NULL,
   [dataCenter] [char](2) NOT NULL

   ,CONSTRAINT [PK_ContactSettings] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ContactSettings_organizationObjectId] ON [dbo].[ContactSettings] ([organizationObjectId])

GO

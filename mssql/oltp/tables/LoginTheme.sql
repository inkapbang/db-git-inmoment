CREATE TABLE [dbo].[LoginTheme] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [subdomain] [nvarchar](100) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [brandObjectId] [int] NOT NULL,
   [passwordReset] [tinyint] NOT NULL

   ,CONSTRAINT [PK_LoginTheme] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_LoginTheme_Brand] ON [dbo].[LoginTheme] ([brandObjectId])
CREATE NONCLUSTERED INDEX [IX_LoginTheme_Organization] ON [dbo].[LoginTheme] ([organizationObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [IX_LoginTheme_subdomain] ON [dbo].[LoginTheme] ([subdomain])

GO

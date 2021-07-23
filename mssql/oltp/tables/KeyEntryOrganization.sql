CREATE TABLE [dbo].[KeyEntryOrganization] (
   [keyEntryObjectId] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_KeyEntryOrganization] PRIMARY KEY CLUSTERED ([keyEntryObjectId], [organizationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_KeyEntryOrganization_Organization] ON [dbo].[KeyEntryOrganization] ([organizationObjectId])

GO

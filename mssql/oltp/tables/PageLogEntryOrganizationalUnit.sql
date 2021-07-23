CREATE TABLE [dbo].[PageLogEntryOrganizationalUnit] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [pageLogEntryObjectId] [int] NOT NULL,
   [organizationalUnitObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageLogEntryOrganizationalUnit] PRIMARY KEY CLUSTERED ([pageLogEntryObjectId], [organizationalUnitObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageLogEntryOrganizationalUnit_PageLogEntry] ON [dbo].[PageLogEntryOrganizationalUnit] ([pageLogEntryObjectId])

GO

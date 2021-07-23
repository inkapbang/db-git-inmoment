CREATE TABLE [dbo].[PageLogEntryUserAccount] (
   [pageLogEntryObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageLogEntryUserAccount] PRIMARY KEY CLUSTERED ([userAccountObjectId], [pageLogEntryObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageLogEntryUserAccount_PageLogEntry] ON [dbo].[PageLogEntryUserAccount] ([pageLogEntryObjectId])
CREATE NONCLUSTERED INDEX [IX_PageLogEntryUserAccount_UserAccount] ON [dbo].[PageLogEntryUserAccount] ([userAccountObjectId]) INCLUDE ([pageLogEntryObjectId])

GO

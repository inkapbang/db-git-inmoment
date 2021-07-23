CREATE TABLE [dbo].[SystemIssueStacktraceHash] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [systemIssueObjectId] [int] NOT NULL,
   [stacktraceHash] [int] NOT NULL

   ,CONSTRAINT [PK__SystemIs__4695324D54719551] PRIMARY KEY CLUSTERED ([systemIssueObjectId], [stacktraceHash])
)


GO

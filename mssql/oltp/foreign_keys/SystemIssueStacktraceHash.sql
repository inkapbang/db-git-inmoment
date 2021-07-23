ALTER TABLE [dbo].[SystemIssueStacktraceHash] WITH CHECK ADD CONSTRAINT [FK_SystemIssueStacktraceHash_SystemIssue]
   FOREIGN KEY([systemIssueObjectId]) REFERENCES [dbo].[SystemIssue] ([objectId])

GO

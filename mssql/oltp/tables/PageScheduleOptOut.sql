CREATE TABLE [dbo].[PageScheduleOptOut] (
   [pageScheduleObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageScheduleOptOut] PRIMARY KEY CLUSTERED ([pageScheduleObjectId], [userAccountObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageScheduleOptOut_userAccountObjectId] ON [dbo].[PageScheduleOptOut] ([userAccountObjectId])

GO

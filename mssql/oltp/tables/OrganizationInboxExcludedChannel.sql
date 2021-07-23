CREATE TABLE [dbo].[OrganizationInboxExcludedChannel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [feedbackChannelObjectId] [int] NOT NULL

   ,CONSTRAINT [PK__Organiza__0243B37D677E0F0D] PRIMARY KEY CLUSTERED ([organizationObjectId], [feedbackChannelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationInboxExcludedChannel_FK_OIEC_FeedbackChannel] ON [dbo].[OrganizationInboxExcludedChannel] ([feedbackChannelObjectId])

GO

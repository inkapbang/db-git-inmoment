CREATE TABLE [dbo].[ChannelMetaData] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [name] [nvarchar](100) NOT NULL,
   [channelObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_ChannelMetaData] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ChannelMetaData_FeedbackChannel] ON [dbo].[ChannelMetaData] ([channelObjectId])
CREATE NONCLUSTERED INDEX [IX_ChannelMetaData_Organization] ON [dbo].[ChannelMetaData] ([organizationObjectId])

GO

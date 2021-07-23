CREATE TABLE [dbo].[ResponseSource] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [labelObjectId] [int] NOT NULL,
   [socialType] [int] NULL,
   [iconType] [int] NOT NULL,
   [visible] [bit] NOT NULL,
   [enabled] [bit] NOT NULL,
   [version] [int] NOT NULL,
   [primaryRatingFieldObjectId] [int] NULL

   ,CONSTRAINT [PK_ResponseSource] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ResponseSource_labelObjectId] ON [dbo].[ResponseSource] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_ResponseSource_organizationObjectId] ON [dbo].[ResponseSource] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_ResponseSource_primaryRatingFieldObjectId] ON [dbo].[ResponseSource] ([primaryRatingFieldObjectId])

GO

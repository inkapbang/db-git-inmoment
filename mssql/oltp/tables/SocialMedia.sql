CREATE TABLE [dbo].[SocialMedia] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [contentObjectId] [int] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK__SocialMedia__4A706432] PRIMARY KEY CLUSTERED ([objectId])
)


GO

CREATE TABLE [dbo].[LocalizedString] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_LocalizedString] PRIMARY KEY CLUSTERED ([objectId])
)


GO

CREATE TABLE [dbo].[Account] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [locationObjectId] [int] NOT NULL,
   [name] [nvarchar](128) NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Account_Location] ON [dbo].[Account] ([locationObjectId])

GO

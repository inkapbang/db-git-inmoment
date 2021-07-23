CREATE TABLE [dbo].[ReleaseNote] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](200) NOT NULL,
   [releaseVersion] [varchar](200) NOT NULL,
   [description] [varchar](max) NOT NULL,
   [releaseDate] [datetime] NOT NULL,
   [live] [bit] NOT NULL

   ,CONSTRAINT [PK_ReleaseNote] PRIMARY KEY CLUSTERED ([objectId])
)


GO

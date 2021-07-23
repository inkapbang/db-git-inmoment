CREATE TABLE [dbo].[DnisNamedPool] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [did] [bit] NULL,
   [defaultPool] [bit] NOT NULL
       DEFAULT ((0)),
   [dnisExpirationSeconds] [int] NOT NULL,
   [creationTime] [datetime] NOT NULL
       DEFAULT (getdate())

   ,CONSTRAINT [PK_DnisNamedPool] PRIMARY KEY CLUSTERED ([objectId])
)


GO

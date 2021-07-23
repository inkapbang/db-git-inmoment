CREATE TABLE [dbo].[PlumServer] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [hostName] [nvarchar](100) NOT NULL,
   [ipStr] [nvarchar](100) NOT NULL,
   [channelsAvailable] [int] NOT NULL,
   [platformType] [int] NOT NULL,
   [enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_PlumServer] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_PlumServer_hostName] UNIQUE NONCLUSTERED ([hostName])
   ,CONSTRAINT [UK_PlumServer_ipStr] UNIQUE NONCLUSTERED ([ipStr])
)


GO

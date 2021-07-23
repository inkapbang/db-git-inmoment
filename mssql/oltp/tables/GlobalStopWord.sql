CREATE TABLE [dbo].[GlobalStopWord] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [word] [nvarchar](50) NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_GlobalStopWord] PRIMARY KEY CLUSTERED ([objectId])
)


GO

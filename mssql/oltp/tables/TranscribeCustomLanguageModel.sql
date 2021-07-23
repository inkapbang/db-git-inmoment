CREATE TABLE [dbo].[TranscribeCustomLanguageModel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [nvarchar](60) NOT NULL,
   [displayName] [nvarchar](60) NOT NULL

   ,CONSTRAINT [PK_TranscribeCustomLanguageModel] PRIMARY KEY CLUSTERED ([objectId])
)


GO

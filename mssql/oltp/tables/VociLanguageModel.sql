CREATE TABLE [dbo].[VociLanguageModel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [name] [varchar](50) NOT NULL,
   [displayName] [varchar](50) NOT NULL,
   [overrideUrl] [varchar](50) NULL,
   [fireAndForget] [tinyint] NOT NULL

   ,CONSTRAINT [PK__VociLang__5243E26A350CFB70] PRIMARY KEY CLUSTERED ([objectId])
)


GO

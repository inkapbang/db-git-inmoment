CREATE TABLE [dbo].[Pear] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](128) NOT NULL,
   [version] [int] NOT NULL,
   [pearType] [tinyint] NOT NULL
       DEFAULT ((0)),
   [humanReadableName] [varchar](200) NULL,
   [fileVersion] [int] NULL,
   [description] [varchar](500) NULL,
   [abbreviation] [varchar](50) NULL

   ,CONSTRAINT [PK_Pear] PRIMARY KEY CLUSTERED ([objectId])
)


GO

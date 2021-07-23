CREATE TABLE [dbo].[tmp_ikpbang_PAT] (
   [pearModelObjectId] [int] NOT NULL,
   [annotation] [varchar](200) NOT NULL,
   [tagObjectId] [int] NOT NULL,
   [objectId] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_tmp_ikpbang_PAT] PRIMARY KEY CLUSTERED ([pearModelObjectId], [annotation], [tagObjectId])
)


GO

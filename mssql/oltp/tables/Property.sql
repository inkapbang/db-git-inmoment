CREATE TABLE [dbo].[Property] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [key] [varchar](5000) NOT NULL,
   [value] [varchar](5000) NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_Property] PRIMARY KEY CLUSTERED ([objectId])
)


GO

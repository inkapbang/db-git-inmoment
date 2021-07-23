CREATE TABLE [dbo].[ContactDatacenterConfig] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [password] [nvarchar](300) NOT NULL,
   [username] [varchar](100) NOT NULL,
   [url] [varchar](300) NOT NULL

   ,CONSTRAINT [PK_ContactDatacenterConfig] PRIMARY KEY CLUSTERED ([objectId])
)


GO

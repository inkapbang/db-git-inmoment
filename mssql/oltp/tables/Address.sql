CREATE TABLE [dbo].[Address] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [line1] [varchar](200) NULL,
   [line2] [varchar](200) NULL,
   [city] [varchar](100) NULL,
   [state] [varchar](50) NULL,
   [country] [varchar](100) NULL,
   [postalCode] [varchar](25) NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [latitude] [float] NULL,
   [longitude] [float] NULL

   ,CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED ([objectId])
)


GO

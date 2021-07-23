CREATE TABLE [dbo].[Holidays] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [beginDate] [datetime] NULL,
   [name] [varchar](150) NULL

   ,CONSTRAINT [PK__Holidays__5243E26A1AC2E38F] PRIMARY KEY CLUSTERED ([objectId])
)


GO

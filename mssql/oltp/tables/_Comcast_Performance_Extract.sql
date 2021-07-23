CREATE TABLE [dbo].[_Comcast_Performance_Extract] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [Survey_Group] [varchar](50) NULL,
   [SurveyId] [varchar](50) NULL,
   [Account_Number] [varchar](50) NULL,
   [First_Bounce_Date] [varchar](50) NULL,
   [First_Open_Date] [varchar](50) NULL,
   [First_Click_Date] [varchar](50) NULL,
   [ts] [datetime] NOT NULL
       DEFAULT (getdate()),
   [fileName] [varchar](255) NULL

   ,CONSTRAINT [PK___Comcast__5243E26A726845A3] PRIMARY KEY CLUSTERED ([objectId])
)


GO

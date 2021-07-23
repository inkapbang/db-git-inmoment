CREATE TABLE [dbo].[_Comcast_SendScrub_Extract] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [Survey_Group] [varchar](50) NULL,
   [SurveyId] [varchar](50) NULL,
   [Account_Number] [varchar](50) NULL,
   [Sent_Scrub_Reason] [varchar](50) NULL,
   [Send_Date] [varchar](50) NULL,
   [Email_Domain] [varchar](50) NULL,
   [ts] [datetime] NOT NULL
       DEFAULT (getdate()),
   [fileName] [varchar](255) NULL

   ,CONSTRAINT [PK___Comcast__5243E26A6DA39086] PRIMARY KEY CLUSTERED ([objectId])
)


GO

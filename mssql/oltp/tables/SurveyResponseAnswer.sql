CREATE TABLE [dbo].[SurveyResponseAnswer] (
   [objectId] [bigint] NOT NULL
      IDENTITY (1,1),
   [surveyResponseObjectId] [int] NULL,
   [binaryContentObjectId] [int] NULL,
   [sequence] [int] NULL,
   [numericValue] [float] NULL,
   [textValue] [nvarchar](2000) NULL,
   [dateValue] [datetime] NULL,
   [booleanValue] [bit] NULL,
   [version] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NULL,
   [encrypted] [bit] NULL,
   [encryptiontype] [tinyint] NULL

   ,CONSTRAINT [PK_SurveyresponseAnswer] PRIMARY KEY CLUSTERED ([objectId])
)


GO

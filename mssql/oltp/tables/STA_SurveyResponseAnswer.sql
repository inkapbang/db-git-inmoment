CREATE TABLE [dbo].[STA_SurveyResponseAnswer] (
   [objectId] [bigint] NOT NULL,
   [surveyResponseObjectId] [int] NOT NULL,
   [msrepl_tran_version] [uniqueidentifier] NOT NULL,
   [binaryContentObjectId] [int] NULL,
   [sequence] [int] NULL,
   [numericValue] [float] NULL,
   [textValue] [nvarchar](2000) NULL,
   [dateValue] [datetime] NULL,
   [booleanValue] [bit] NULL,
   [version] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NULL,
   [encrypted] [bit] NULL

   ,CONSTRAINT [PK_STA_SurveyResponseAnswer] PRIMARY KEY NONCLUSTERED ([objectId])
)


GO

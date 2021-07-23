CREATE TABLE [dbo].[_Caesars_SurveyResponseAnswer] (
   [surveyResponseObjectId] [int] NOT NULL,
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
   [encryptiontype] [tinyint] NULL,
   [NewResponseObjectId] [bigint] NULL,
   [objectid] [bigint] NOT NULL

)

CREATE CLUSTERED INDEX [idxx] ON [dbo].[_Caesars_SurveyResponseAnswer] ([surveyResponseObjectId])

GO

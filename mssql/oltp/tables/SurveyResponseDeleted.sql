CREATE TABLE [dbo].[SurveyResponseDeleted] (
   [objectId] [int] NOT NULL,
   [deletedDateTime] [datetime] NOT NULL
      CONSTRAINT [DF_SurveyResponseDeleted_deletedDateTime] DEFAULT (getutcdate())

   ,CONSTRAINT [PK_SurveyResponseDeleted] PRIMARY KEY CLUSTERED ([objectId])
)


GO

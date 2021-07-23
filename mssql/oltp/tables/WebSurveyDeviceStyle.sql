CREATE TABLE [dbo].[WebSurveyDeviceStyle] (
   [objectId] [int] NOT NULL,
   [webSurveyDeviceType] [varchar](100) NOT NULL,
   [parentWebSurveyStyleObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_WebSurveyStyleDevice] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_WebSurveyDeviceStyle_parentWebSurveyDeviceStyleObjectId_webSurveyDeviceType] ON [dbo].[WebSurveyDeviceStyle] ([parentWebSurveyStyleObjectId], [webSurveyDeviceType])
CREATE NONCLUSTERED INDEX [IX_WebSurveyDeviceStyle_webSurveyDeviceType_parentWebSurveyStyle] ON [dbo].[WebSurveyDeviceStyle] ([webSurveyDeviceType], [parentWebSurveyStyleObjectId])

GO

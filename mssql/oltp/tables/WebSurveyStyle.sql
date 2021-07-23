CREATE TABLE [dbo].[WebSurveyStyle] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [windowBackgroundColor] [varchar](6) NULL,
   [lineColor] [varchar](6) NULL,
   [bannerBackgroundColor] [varchar](6) NULL,
   [bannerObjectId] [int] NULL,
   [bannerAlignment] [int] NOT NULL,
   [questionBackgroundColor] [varchar](6) NULL,
   [questionFontFamily] [varchar](100) NULL,
   [questionFontColor] [varchar](6) NULL,
   [answerBackgroundColor] [varchar](6) NULL,
   [answerFontFamily] [varchar](100) NULL,
   [answerFontColor] [varchar](6) NULL,
   [copyrightFontColor] [varchar](6) NULL,
   [progressBackgroundColor] [varchar](6) NULL,
   [progressBarColor] [varchar](6) NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [titleBackgroundColor] [varchar](6) NULL,
   [titleFontColor] [varchar](6) NULL,
   [titleFontFamily] [varchar](100) NULL,
   [sidebarBackgroundColor] [varchar](6) NULL,
   [sidebarImageObjectId] [int] NULL,
   [backArrowObjectId] [int] NULL,
   [nextArrowObjectId] [int] NULL,
   [css] [varchar](max) NULL,
   [topFooter] [nvarchar](max) NULL,
   [bottomFooter] [nvarchar](max) NULL,
   [organizationObjectId] [int] NOT NULL,
   [name] [nvarchar](100) NULL,
   [windowTitle] [nvarchar](100) NULL,
   [categoricalGroupColumnWidth] [nvarchar](50) NULL,
   [overflowCategoricalGroupLabels] [bit] NOT NULL

   ,CONSTRAINT [PK_WebSurveyStyle] PRIMARY KEY NONCLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Websurveystyle_by_BackArrowObjectId] ON [dbo].[WebSurveyStyle] ([backArrowObjectId])
CREATE NONCLUSTERED INDEX [IX_Websurveystyle_by_bannerObjectId] ON [dbo].[WebSurveyStyle] ([bannerObjectId])
CREATE NONCLUSTERED INDEX [IX_Websurveystyle_by_nextArrowObjectId] ON [dbo].[WebSurveyStyle] ([nextArrowObjectId])
CREATE NONCLUSTERED INDEX [IX_Websurveystyle_by_sidebarImageObjectId] ON [dbo].[WebSurveyStyle] ([sidebarImageObjectId])
CREATE NONCLUSTERED INDEX [IX_WebSurveyStyle_Organization] ON [dbo].[WebSurveyStyle] ([organizationObjectId])

GO

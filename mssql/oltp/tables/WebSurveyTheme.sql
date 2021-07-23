CREATE TABLE [dbo].[WebSurveyTheme] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [nvarchar](100) NULL,
   [organizationObjectId] [int] NOT NULL,
   [template] [int] NOT NULL,
   [font] [int] NOT NULL,
   [backgroundImageObjectId] [int] NULL,
   [organizationImageObjectid] [int] NULL,
   [nextArrowObjectId] [int] NULL,
   [backArrowObjectId] [int] NULL,
   [customLess] [varchar](max) NULL,
   [script] [varchar](max) NULL,
   [compiledCss] [varchar](max) NULL,
   [headerHtml] [nvarchar](max) NULL,
   [footerHtml] [nvarchar](max) NULL,
   [googleAnalyticsEnabled] [bit] NOT NULL
       DEFAULT ((0)),
   [clientGoogleKey] [varchar](100) NULL,
   [pageBackgroundColor] [varchar](100) NULL,
   [questionBackgroundColor] [varchar](100) NULL,
   [textColor] [varchar](100) NULL,
   [selectedColor] [varchar](100) NULL,
   [buttonColor] [varchar](100) NULL,
   [progressBarColor] [varchar](100) NULL,
   [windowTitle] [nvarchar](100) NULL,
   [descriptionSEO] [varchar](500) NULL,
   [faviconImageObjectId] [int] NULL,
   [enabledForIntercept] [bit] NULL,
   [orgLogoAltText] [nvarchar](100) NULL,
   [themeSettingsObjectId] [int] NULL,
   [enabledThemeSettings] [bit] NULL
      CONSTRAINT [DF_WebSurveyTheme_enabledThemeSettings] DEFAULT ((0))

   ,CONSTRAINT [PK_WebSurveyTheme] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Websurvetheme_by_backArrowObjectId] ON [dbo].[WebSurveyTheme] ([backArrowObjectId])
CREATE NONCLUSTERED INDEX [IX_Websurvetheme_by_backgroundImageObjectId] ON [dbo].[WebSurveyTheme] ([backgroundImageObjectId])
CREATE NONCLUSTERED INDEX [IX_Websurvetheme_by_nextArrowObjectId] ON [dbo].[WebSurveyTheme] ([nextArrowObjectId])
CREATE NONCLUSTERED INDEX [IX_Websurvetheme_by_organizationImageObjectId] ON [dbo].[WebSurveyTheme] ([organizationImageObjectid])
CREATE NONCLUSTERED INDEX [IX_Websurvetheme_by_themeSettingsObjectId] ON [dbo].[WebSurveyTheme] ([themeSettingsObjectId])
CREATE NONCLUSTERED INDEX [IX_WebSurveyTheme_Image_faviconImage] ON [dbo].[WebSurveyTheme] ([faviconImageObjectId])
CREATE NONCLUSTERED INDEX [IX_WebSurveyTheme_organizationObjectId] ON [dbo].[WebSurveyTheme] ([organizationObjectId])

GO

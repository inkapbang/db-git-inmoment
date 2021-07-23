CREATE TABLE [dbo].[SurveyResponse] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [surveyGatewayObjectId] [int] NOT NULL,
   [ani] [varchar](25) NULL,
   [beginDate] [datetime] NOT NULL,
   [complete] [bit] NOT NULL,
   [surveyObjectId] [int] NULL,
   [dateOfService] [datetime] NULL,
   [redemptionCode] [int] NULL,
   [employeeCode] [varchar](25) NULL,
   [oldEmployeeCode] [varchar](10) NULL,
   [beginTime] [datetime] NULL,
   [minutes] [float] NULL,
   [instantAlertSent] [bit] NULL,
   [version] [int] NOT NULL,
   [modeType] [int] NULL,
   [loyaltyNumber] [varchar](400) NULL,
   [cookieUID] [varchar](40) NULL,
   [externalId] [varchar](30) NULL,
   [externalCallRecordingId] [varchar](30) NULL,
   [IPAddress] [varchar](39) NULL,
   [assignedUserAccountObjectId] [int] NULL,
   [isRead] [bit] NOT NULL,
   [beginDateUTC] [datetime] NOT NULL,
   [exclusionReason] [int] NOT NULL,
   [locationObjectId] [int] NULL,
   [offerObjectId] [int] NULL,
   [offerCode] [varchar](50) NULL,
   [lastModTime] [datetime] NULL,
   [reviewOptIn] [bit] NULL,
   [uuid] [varchar](100) NULL,
   [fingerprint] [varchar](255) NULL,
   [deviceType] [varchar](255) NULL,
   [deviceTypeValue] [int] NULL,
   [redemptionCodeVal] [varchar](255) NULL,
   [language] [smallint] NULL,
   [responseSourceObjectId] [int] NULL,
   [contactId] [varchar](44) NULL,
   [requestId] [varchar](100) NULL

   ,CONSTRAINT [PK_Surveyresponse] PRIMARY KEY CLUSTERED ([objectId])
)


GO

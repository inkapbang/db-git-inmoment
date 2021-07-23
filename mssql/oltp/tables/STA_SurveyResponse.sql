CREATE TABLE [dbo].[STA_SurveyResponse] (
   [objectId] [int] NOT NULL,
   [surveyGatewayObjectId] [int] NOT NULL,
   [ani] [varchar](25) NULL,
   [beginDate] [datetime] NOT NULL,
   [complete] [bit] NOT NULL,
   [surveyObjectId] [int] NULL,
   [dateOfService] [datetime] NULL,
   [offerCodeObjectId] [int] NULL,
   [redemptionCode] [int] NULL,
   [employeeCode] [varchar](25) NULL,
   [msrepl_tran_version] [uniqueidentifier] NOT NULL,
   [oldEmployeeCode] [varchar](10) NULL,
   [beginTime] [datetime] NULL,
   [minutes] [float] NULL,
   [instantAlertSent] [bit] NULL,
   [version] [int] NOT NULL,
   [modeType] [int] NULL,
   [loyaltyNumber] [varchar](40) NULL,
   [cookieUID] [varchar](40) NULL,
   [externalId] [varchar](30) NULL,
   [externalCallRecordingId] [varchar](30) NULL,
   [IPAddress] [varchar](39) NULL,
   [assignedUserAccountObjectId] [int] NULL,
   [isRead] [bit] NOT NULL,
   [beginDateUTC] [datetime] NOT NULL,
   [exclusionReason] [int] NOT NULL

   ,CONSTRAINT [PK_STA_SurveyResponse] PRIMARY KEY NONCLUSTERED ([objectId])
)


GO

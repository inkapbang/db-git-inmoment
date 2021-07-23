CREATE TABLE [dbo].[HertzScrubs] (
   [sobjectid] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [description] [varchar](1000) NULL,
   [organizationObjectId] [int] NULL,
   [sversion] [int] NOT NULL,
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
   [IPAddress] [varchar](15) NULL,
   [assignedUserAccountObjectId] [int] NULL,
   [isRead] [bit] NOT NULL
)


GO

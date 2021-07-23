CREATE TABLE [dbo].[BeaconAction] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [name] [nvarchar](100) NOT NULL,
   [launchMessageObjectId] [int] NULL,
   [launchAction] [int] NOT NULL,
   [setParameterVariable] [bit] NULL
       DEFAULT ((0)),
   [parameterName] [nvarchar](max) NULL,
   [parameterValue] [nvarchar](max) NULL,
   [url] [nvarchar](max) NULL,
   [surveyGatewayObjectId] [int] NULL,
   [surveyOfferCodeObjectId] [int] NULL

   ,CONSTRAINT [PK_BeaconAction] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_BeaconAction_LaunchMessage] ON [dbo].[BeaconAction] ([launchMessageObjectId])
CREATE NONCLUSTERED INDEX [IX_BeaconAction_Organization] ON [dbo].[BeaconAction] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_BeaconAction_SurveyGateway] ON [dbo].[BeaconAction] ([surveyGatewayObjectId])
CREATE NONCLUSTERED INDEX [IX_BeaconAction_SurveyOffer] ON [dbo].[BeaconAction] ([surveyOfferCodeObjectId])

GO

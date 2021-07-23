CREATE TABLE [dbo].[AdvancedGatewaySecurityIdentifier] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [gatewayObjectId] [int] NOT NULL,
   [advancedGatewaySecurity] [int] NOT NULL

   ,CONSTRAINT [PK_AdvancedGatewaySecurityIdentifier] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_AdvancedGatewaySecurityIdentifier_SurveyGateway] ON [dbo].[AdvancedGatewaySecurityIdentifier] ([gatewayObjectId])

GO

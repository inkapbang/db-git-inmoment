CREATE TABLE [dbo].[_gatewayparameterdupe] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [sequence] [int] NULL,
   [alias] [varchar](25) NOT NULL,
   [surveyGatewayObjectId] [int] NULL,
   [promptObjectId] [int] NOT NULL,
   [sourceType] [int] NOT NULL,
   [version] [int] NOT NULL,
   [defaultValue] [varchar](2000) NULL,
   [required] [bit] NULL
)


GO

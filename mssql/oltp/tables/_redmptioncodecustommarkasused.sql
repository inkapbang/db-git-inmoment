CREATE TABLE [dbo].[_redmptioncodecustommarkasused] (
   [organizationObjectId] [int] NOT NULL,
   [redemptionCode] [varchar](50) NOT NULL,
   [market] [varchar](50) NOT NULL,
   [loadedDate] [datetime] NOT NULL,
   [activationDate] [datetime] NULL,
   [responseId] [bigint] NULL
)


GO

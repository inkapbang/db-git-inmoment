CREATE TABLE [dbo].[_RedemptionCodeCustom_Staging] (
   [OrganizationObjectId] [int] NULL,
   [RedemptionCode] [varchar](2000) NULL,
   [Market] [varchar](2000) NULL,
   [usableStartDate] [datetime] NULL,
   [usableEndDate] [datetime] NULL,
   [error] [varchar](500) NULL
)


GO

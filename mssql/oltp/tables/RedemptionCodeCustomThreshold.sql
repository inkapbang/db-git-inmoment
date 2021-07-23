CREATE TABLE [dbo].[RedemptionCodeCustomThreshold] (
   [market] [varchar](50) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [threshold] [int] NOT NULL

   ,CONSTRAINT [PK_RedemptionCodeCustomThreshold] PRIMARY KEY CLUSTERED ([organizationObjectId], [market])
)


GO

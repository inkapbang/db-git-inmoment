CREATE TABLE [dbo].[RedemptionCodeCustom] (
   [organizationObjectId] [int] NOT NULL,
   [redemptionCode] [varchar](50) NOT NULL,
   [market] [varchar](50) NOT NULL,
   [loadedDate] [datetime] NOT NULL,
   [activationDate] [datetime] NULL,
   [responseId] [bigint] NULL,
   [usableStartDate] [datetime] NULL,
   [usableEndDate] [datetime] NULL

   ,CONSTRAINT [PK__Redempti__FFD7A3F56E634422] PRIMARY KEY CLUSTERED ([redemptionCode], [organizationObjectId], [market])
)

CREATE NONCLUSTERED INDEX [IX_RedemptionCodeCustom_by_Org_Market_Date] ON [dbo].[RedemptionCodeCustom] ([organizationObjectId], [market], [activationDate]) INCLUDE ([redemptionCode])
CREATE NONCLUSTERED INDEX [IX_RedemptionCodeCustom_by_Org_Market_Dates] ON [dbo].[RedemptionCodeCustom] ([organizationObjectId], [market], [activationDate], [usableStartDate], [usableEndDate]) INCLUDE ([redemptionCode])
CREATE NONCLUSTERED INDEX [IX_RedemptionCodeCustom_New2] ON [dbo].[RedemptionCodeCustom] ([organizationObjectId], [market], [activationDate], [usableStartDate], [usableEndDate])
CREATE NONCLUSTERED INDEX [IX_RedemptionCodeCustom_Org_Dates] ON [dbo].[RedemptionCodeCustom] ([organizationObjectId], [activationDate], [usableStartDate], [usableEndDate]) INCLUDE ([market])
CREATE NONCLUSTERED INDEX [IX_RedemptionCodeCustom_Org_Market] ON [dbo].[RedemptionCodeCustom] ([organizationObjectId]) INCLUDE ([market])
CREATE NONCLUSTERED INDEX [IX_RedemptionCodeCustom_Test] ON [dbo].[RedemptionCodeCustom] ([organizationObjectId], [market], [activationDate], [usableStartDate], [usableEndDate]) WHERE ([activationDate] IS NULL)

GO

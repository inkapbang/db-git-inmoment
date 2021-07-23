CREATE TABLE [dbo].[_RedemptionCodeCustom] (
   [organizationObjectId] [int] NOT NULL,
   [redemptionCode] [varchar](50) NOT NULL,
   [market] [varchar](50) NOT NULL,
   [loadedDate] [datetime] NULL,
   [activationDate] [datetime] NULL,
   [responseId] [bigint] NULL,
   [usableStartDate] [datetime] NULL,
   [usableEndDate] [datetime] NULL

   ,CONSTRAINT [PK___Redempt__FFD7A3F528F50008] PRIMARY KEY CLUSTERED ([redemptionCode], [organizationObjectId], [market])
)


GO

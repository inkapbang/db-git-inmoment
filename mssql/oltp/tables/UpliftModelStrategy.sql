CREATE TABLE [dbo].[UpliftModelStrategy] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [strategyType] [int] NOT NULL,
   [minimumResponseCount] [int] NOT NULL,
   [importanceConsistencyPreferenceType] [int] NULL,
   [version] [int] NOT NULL,
   [slidingDateWindowMaxDays] [int] NULL,
   [slidingDateWindowMinResponseCount] [int] NULL,
   [aggregationType] [int] NULL,
   [privacyFilterEnabled] [tinyint] NULL,
   [thresholdType] [int] NULL,
   [auditWeightPercent] [int] NULL,
   [auditResponseSourceObjectId] [int] NULL,
   [VocRangePeriodObjectId] [int] NULL,
   [VocRangeNumOfAudits] [int] NULL,
   [auditParticipantAttributeObjectId] [int] NULL

   ,CONSTRAINT [PK_UpliftModelStrategy] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_UpliftModelStrategy_AuditParticipantAttribute] ON [dbo].[UpliftModelStrategy] ([auditParticipantAttributeObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModelStrategy_AuditResponseSource] ON [dbo].[UpliftModelStrategy] ([auditResponseSourceObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModelStrategy_Period] ON [dbo].[UpliftModelStrategy] ([VocRangePeriodObjectId])

GO

CREATE TABLE [dbo].[ManualRecommendation] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [performanceAttributeObjectId] [int] NOT NULL,
   [rank] [int] NOT NULL,
   [beginDate] [datetime] NOT NULL,
   [endDate] [datetime] NOT NULL,
   [assignmentType] [int] NOT NULL,
   [assignmentUserAccountObjectId] [int] NULL

   ,CONSTRAINT [PK_ManualRecommendation] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ManualRecommendation_AssignmentUserAccount] ON [dbo].[ManualRecommendation] ([assignmentUserAccountObjectId])
CREATE NONCLUSTERED INDEX [IX_ManualRecommendation_Location] ON [dbo].[ManualRecommendation] ([locationObjectId])
CREATE NONCLUSTERED INDEX [IX_ManualRecommendation_PerformanceAttribute] ON [dbo].[ManualRecommendation] ([performanceAttributeObjectId])

GO

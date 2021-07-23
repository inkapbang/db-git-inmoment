CREATE TABLE [dbo].[CommentReportLocalization] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [pageObjectId] [int] NOT NULL,
   [noOpportunityObjectId] [int] NOT NULL,
   [noOutstandingObjectId] [int] NOT NULL,
   [opportunitiesObjectId] [int] NOT NULL,
   [outstandingObjectId] [int] NOT NULL,
   [opportunityCommentsObjectId] [int] NOT NULL,
   [outstandingCommentsObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_CommentReportLocalization] PRIMARY KEY CLUSTERED ([objectId])
)


GO

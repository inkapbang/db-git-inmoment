SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_maint_reindextblsDaily_SurveyRequest]
as

--alter index PK_SurveyRequest on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index PK_SurveyRequest on surveyrequest reorganize;
----alter index IX_SurveyRequest_by_SurveyResponse on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
----alter index IX_SurveyRequest_expirationTime_state on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
--alter index IX_SurveyRequest_failureReason_scheduledTime on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyRequest_failureReason_scheduledTime on surveyrequest reorganize;
--alter index IX_SurveyRequest_purgeTime on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyRequest_purgeTime on surveyrequest  reorganize;
--alter index IX_SurveyRequest_state_SurveyGateway on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyRequest_state_SurveyGateway on surveyrequest reorganize;
--alter index IX_SurveyRequest_SurveyGateway_state on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyRequest_SurveyGateway_state on surveyrequest reorganize;
----alter index ix_Surveyrequest_SurveyGatewayTypeState on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
--alter index IX_SurveyRequest_uuid on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyRequest_uuid on surveyrequest reorganize;
--alter index ix_Surveyrequest_by_failureReason on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index ix_Surveyrequest_by_failureReason on surveyrequest reorganize;
--alter index ix_Surveyrequest_by_uniqueKey_state on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index ix_Surveyrequest_by_uniqueKey_state on surveyrequest reorganize;
----alter index all on pagelogentry rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
----2015.10.24 alter index PK_SurveyRequestParam on surveyrequestparam rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
--alter index IX_SurveyRequestParam_by_SurveyRequest on surveyrequestparam rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyRequestParam_by_SurveyRequest on surveyrequestparam reorganize;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

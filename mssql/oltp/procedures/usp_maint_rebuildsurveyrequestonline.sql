SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure dbo.usp_maint_rebuildsurveyrequestonline
as
alter index PK_SurveyRequest on surveyrequest rebuild with (sort_in_tempdb=on,online=on);
alter index Ix_SurveyRequest_by_SurveyResponse on surveyrequest rebuild with (sort_in_tempdb=on,online=on);
alter index IX_SurveyRequest_failureReason on surveyrequest rebuild with (sort_in_tempdb=on,online=on);
alter index IX_SurveyRequest_expirationTime_state on surveyrequest rebuild with (sort_in_tempdb=on,online=on);
alter index IX_SurveyRequest_purgeTime on surveyrequest rebuild with (sort_in_tempdb=on,online=on);
alter index IX_SurveyRequest_by_scheduledTime_state on surveyrequest rebuild with (sort_in_tempdb=on,online=on); 
alter index IX_SurveyRequest_by_failureReason on surveyrequest rebuild with (sort_in_tempdb=on,online=on); 
alter index IX_SurveyRequest_by_uniqueKey_state on surveyrequest rebuild with (sort_in_tempdb=on,online=on);
alter index IX_SurveyRequest_by_OriginatingRequest on surveyrequest rebuild with (sort_in_tempdb=on,online=on);

alter index PK_SurveyRequestParam on surveyrequestparam rebuild with (sort_in_tempdb=on,online=on);
alter index IX_SurveyRequestParam_by_SurveyRequest on surveyrequestparam rebuild with (sort_in_tempdb=on,online=on);
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

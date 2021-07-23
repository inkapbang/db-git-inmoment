SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_Maint_reindexsurveyresponseonline]
as
alter index PK_Surveyresponse on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
--dbcc show_statistics ('surveyresponse',IX_SurveyResponse_by_ani_complete_beginDate_offerCode)
--update statistics surveyresponse with fullscan
--sp_helpstats N'dbo.surveyresponse','all'
alter index IX_SurveyResponse_by_assignedUser_beginDate_location_exclusionReason_isRead_complete on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_by_ani_complete_beginDate_location on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_by_assignedUser_isRead_complete_location_id on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_by_cookieUID_location on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_by_loyalty_location on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_by_location_beginDate on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_by_location_beginDate_complete_exclusionReason on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_by_Survey on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_by_Survey_beginDate on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_by_Survey_beginDate_complete on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_by_Survey_beginTime on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_SurveyResponse_complete_beginDate_location_id on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)

alter index IX_SurveyResponse_offer on surveyresponse rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

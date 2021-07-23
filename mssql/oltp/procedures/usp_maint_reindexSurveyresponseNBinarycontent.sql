SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure [dbo].[usp_maint_reindexSurveyresponseNBinarycontent]
as

print 'SurveyResponse'
alter index PK_SurveyResponse on SurveyResponse reorganize-- with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_SurveyResponse_by_assignedUser_isRead_complete_location_id on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_SurveyResponse_complete_beginDate_location_id on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_SurveyResponse_by_loyalty_location on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_SurveyResponse_by_cookieUID_location on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_SurveyResponse_by_Survey on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_SurveyResponse_by_Survey_beginTime on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_SurveyResponse_by_Survey_beginDate on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_SurveyResponse_by_location_beginDate on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_SurveyResponse_by_Survey_beginDate_complete on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_SurveyResponse_by_ani_complete_beginDate_location on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)

alter index IX_SurveyResponse_offer on SurveyResponse rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)

print 'BinaryContent'
alter index PK_BinaryContent on BinaryContent reorganize-- with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_BinaryContent_by_Transcription on BinaryContent rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_BinaryContent_Transcription_contentType_id on BinaryContent rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_BinaryContent_contentType on BinaryContent rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
alter index IX_BinaryContent_length on BinaryContent rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

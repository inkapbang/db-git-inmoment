SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--Surveyresponseanswer
--sp_helpstats N'dbo.surveyresponseanswer','all'
CREATE procedure [dbo].[usp_maint_reindexSurveyresponseanswerOnline]
as
--sp_helpstats N'dbo.surveyresponseanswer','all'
alter index PK_Surveyresponseanswer on surveyresponseanswer rebuild with (sort_in_tempdb=on,online=on,maxDOP=10)
alter index IX_Surveyresponseanswer_by_Surveyresponse_ID on surveyresponseanswer rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index IX_Surveyresponseanswer_by_Surveyresponse_Binarycontent on surveyresponseanswer rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index IX_Surveyresponseanswer_by_field_binary_response on surveyresponseanswer rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index IX_Surveyresponseanswer_by_datafieldoption on surveyresponseanswer rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index IX_Surveyresponseanswer_by_datafieldobjectid on surveyresponseanswer rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index IX_Surveyresponseanswer_by_binarycontent_surveyresponse on surveyresponseanswer rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

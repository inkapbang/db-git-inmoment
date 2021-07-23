SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_maint_reindextblsDaily]
as
--/*
--Bob Luther 
--31 sec 081511

--select * from
--*/
--exec whosblocking
--sp_helpindex datafield
--drop index _dta_index_SurveyGateway_12_1327343793__K16_K1_K4 on surveygateway --with (online=on)
--exec dbo.usp_maint_reindextblsDaily
--exec sp_helpindex surveygateway
--sp_helpstats N'dbo.surveyresponse','all'
--dbcc show_statistics ('locationcategory',PK_locationcategory);
--alter INDEX [PK_Prompt] ON [dbo].[location]  rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
--alter index IX_SurveyResponse_UUID on surveyresponse rebuild with (sort_in_tempdb=on, online=on, maxdop=10)
alter index IX_SurveyResponse_UUID on surveyresponse reorganize;
alter index all on location rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index IX_Gateway_By_Dnis on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyGateway_alias on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyGateway_audioOptionObjectId on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyGateway_Campaign_Organization on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyGateway_defaultOfferCodeObjectId on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyGateway_disabledLocationSurveyObjectId on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyGateway_failurePromptObjectId on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyGateway_gatewayType on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
--alter index IX_SurveyGateway_Organization_Campaign on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_SurveyGateway_webSurveyStyleObjectId on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index PK_PhoneNumber on surveygateway rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
--alter index all on organizationalunit rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index all on baseaccesspolicy rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on locationcategory rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on locationcategorylocation rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on useraccount rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on useraccountlocation rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on useraccountlocationcategory rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
--alter index all on organization rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index IX_organization_objectid on organization reorganize;
-- 2015.10.21 update statistics organization IX_organization_objectid with fullscan;
alter index PK_Organization on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_addressObjectId on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_by_BannerObjectId on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_by_LogoObjectId on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_by_OOVList on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_contactInfoObjectId on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_defaultBrandObjectId on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_defaultWebSurveyStyleObjectId on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_localeKey on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_Name_ObjectId on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_reviewUnstructuredFeedbackModelObjectId on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_reviewUpliftModelObjectId on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);
alter index IX_Organization_salesRepObjectId on organization rebuild with (sort_in_tempdb=on,online=on,maxdop=10);

alter index all on organizationuseraccount rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on OrganizationAccountManagers rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on OrganizationalUnit rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on offercode rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
--alter index all on prompt rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter INDEX [PK_Prompt] ON [dbo].[Prompt]  rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter INDEX [IX_Prompt_by_outputdataFieldobjectid] ON [dbo].[Prompt]  rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter INDEX [IX_Prompt_by_Prompt_type] ON [dbo].[Prompt]  rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter INDEX [IX_Prompt_organization] ON [dbo].[Prompt]  rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter INDEX [IX_Prompt_by_dataField] ON [dbo].[Prompt]  rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter INDEX [IX_Prompt_by_OrgID_IncludeEverything] ON [dbo].[Prompt]  reorganize;
alter index all on promptchoice rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
--alter index all on promptevent rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on datafield rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on datafieldoption rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on page rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on period rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on reportcolumn rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on promptgroup rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on tag rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
--alter index ix_Localizedstringvalue_insertorder on localizedstringvalue rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
-- 2015.10.21 update statistics dbo.surveyresponse(PK_Surveyresponse)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_Surveyresponse_completeBegindateSurveygatewayidLocationidOfferidOffercode)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_Surveyresponse_Locationid_offerid)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_by_Survey_beginDate)
--update statistics dbo.surveyresponse(IX_SurveyResponse_by_Survey)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_complete_isRead_exclusionReason_locationObjectId)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_complete_exclusionReason_locationObjectId)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_complete_assignedUserAccountObjectId_exclusionReason)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_complete_assignedUserAccountObjectId_isRead_exclusionReason)
-- 2015.10.21 update statistics dbo.surveyresponse(ix_Surveyresponse_CompleteBegindateUTC)
-- 2015.10.21 update statistics dbo.surveyresponse(ix_sr_bycompleteIpOfferIDbegindate)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_UUID)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_complete_beginDate_location_id)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_by_fingerprint_location)
-- 2015.10.21 update statistics dbo.surveyresponse(ix_surveyresponse_offerobjectid)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_by_location_beginDate_complete_exclusionReason_offerObjectId_FIX)
--update statistics dbo.surveyresponse(IX_Surveyresponse_by_complete_isread_exclusionreason_locationobjectid_include_begindate)
-- 2015.10.21 update statistics dbo.surveyresponse(ix_Surveyresponse_completeExclusionReasonUUID)
-- 2015.10.21 update statistics dbo.surveyresponse(ix_Surveyresponse_SgSurveyIDExclusionreason)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_by_ani_complete_beginDate_location)
--update statistics dbo.surveyresponse(ix_sr_sgsidlocationobjectid)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_by_cookieUID_location)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_by_loyalty_location)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_by_location_beginDate)
-- 2015.10.21 update statistics dbo.surveyresponse(IX_SurveyResponse_by_location_beginDate_complete_exclusionReason)

-- 2015.10.21 update statistics dbo.surveyresponseanswer(PK_SurveyresponseAnswer)
-- 2015.10.21 update statistics dbo.surveyresponseanswer(IX_SurveyResponseAnswer_by_SurveyResponse_Id)
-- 2015.10.21 update statistics dbo.surveyresponseanswer(IX_SRA_dfidSrid)
-- 2015.10.21 update statistics dbo.surveyresponseanswer(IX_SurveyResponseAnswer_by_DataFieldOption)
-- 2015.10.21 update statistics dbo.surveyresponseanswer(IX_SurveyResponseAnswer_by_dataFieldObjectId)



-- 2015.10.24 alter index PK_SurveyRequest on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
--alter index IX_SurveyRequest_by_SurveyResponse on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
--alter index IX_SurveyRequest_expirationTime_state on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
-- 2015.10.24 alter index IX_SurveyRequest_failureReason_scheduledTime on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
-- 2015.10.24 alter index IX_SurveyRequest_purgeTime on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
-- 2015.10.24 alter index IX_SurveyRequest_state_SurveyGateway on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
-- 2015.10.24 alter index IX_SurveyRequest_SurveyGateway_state on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
--alter index ix_Surveyrequest_SurveyGatewayTypeState on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
-- 2015.10.24 alter index IX_SurveyRequest_uuid on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
-- 2015.10.24 alter index ix_Surveyrequest_by_failureReason on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
-- 2015.10.24 alter index ix_Surveyrequest_by_uniqueKey_state on surveyrequest rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
--alter index all on pagelogentry rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
-- 2015.10.24 alter index PK_SurveyRequestParam on surveyrequestparam rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
-- 2015.10.24 alter index IX_SurveyRequestParam_by_SurveyRequest on surveyrequestparam rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
-- 2015.10.21 update statistics pagelogentry;
-- 2015.10.21 update statistics promptevent;
--alter index all on pagelogentryuseraccount rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
-- 2015.10.21 update statistics pagelogentryuseraccount;
alter index all on pagedatafield rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
--alter index all on [password] rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on passwordhistory rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on localizedstring rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
--alter index all on localizedstringvalue rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
--alter index all on binarycontentannotation rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
-- 2015.10.21 update statistics localizedstringvalue;
--alter index all on transcription rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index all on commentannotation rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
-- 2015.10.21 update statistics   campaign with fullscan;
alter index IX_Campaign_staleRequestMinutes_campaignType on campaign rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_Campaign_Organizationclustered on campaign rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index IX_Campaign_campaignTypes_staleRequestMinutes on campaign rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
alter index ix_Commentannotation_commentid on Commentannotation rebuild with (sort_in_tempdb=on,online=on,maxdop=10)
--alter index all on campaign rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);

--alter index all on redemptioncode rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
-- 2015.10.21 update statistics redemptioncode;
--alter index all on DeliveryRunLogEntry rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
-- 2015.10.21 update statistics DeliveryRunLogEntry;
--select COUNT(*) from DeliveryRunLogEntry
--alter index all on DeliveryRunthreadLogEntry rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
--update statistics DeliveryRunthreadLogEntry;
--select COUNT(*) from DeliveryRunthreadLogEntry
--update statistics pagelogentry
--exec sp_helpindex surveyrequest
--/*
--SELECT name AS index_name, 
--    STATS_DATE(object_id, index_id) AS statistics_update_date
--FROM sys.indexes 
--WHERE object_id = OBJECT_ID('dbo.datafieldoption');
--GO

--*/
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

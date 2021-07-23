SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_maint_reindexSmallTblsOnline]
as
BEGIN
	print 'Reorganizing indices...'

	print 'BinaryContent'
	alter index all on BinaryContent reorganize;
	update statistics BinaryContent with fullscan;
	print 'PageLogEntry'
	alter index all on PageLogEntry reorganize;
	update statistics PageLogEntry with fullscan;
	print 'PageLogEntryOrganizationalUnit'
	alter index all on PageLogEntryOrganizationalUnit reorganize;
	update statistics PageLogEntryOrganizationalUnit with fullscan;

	print 'PageLogEntryUserAccount'
	alter index all on PageLogEntryUserAccount reorganize;
	update statistics PageLogEntryUserAccount with fullscan;	
	print 'SurveyResponse'
	alter index all on SurveyResponse reorganize;
	update statistics SurveyResponse with fullscan;
	print 'SurveyResponseAlert'
	alter index all on SurveyResponseAlert reorganize;
	update statistics SurveyResponseAlert with fullscan;
	print 'SurveyResponseNote'
	alter index all on SurveyResponseNote reorganize;
	update statistics SurveyResponseNote with fullscan;
	print 'SurveyResponseScore'
	alter index all on SurveyResponseScore reorganize;
	update statistics SurveyResponseScore with fullscan;
	print 'SurveyResponseTag'
	alter index all on SurveyResponseTag reorganize;
	update statistics SurveyResponseTag with fullscan;

alter index all on location reorganize
update statistics location with fullscan;

alter index all on offercode reorganize
update statistics offercode with fullscan;

alter index all on prompt rebuild with (sort_in_tempdb=on,online=on,maxDOP=2)


alter index all on SurveyRequestParam rebuild with (sort_in_tempdb=on,online=on,maxDOP=2)
--alter index PK_SurveyRequestParam on SurveyRequestParam rebuild with (sort_in_tempdb=on,online=on,maxDOP=2)
--alter index IX_SurveyRequestParam_by_SurveyRequest on SurveyRequestParam rebuild with (sort_in_tempdb=on,online=on,maxDOP=2)
update statistics SurveyRequestParam with fullscan;

alter index all on AccessEventLog rebuild with (sort_in_tempdb=on,online=on,maxDOP=2)
--alter index PK_AccessEventLog on AccessEventLog rebuild with (sort_in_tempdb=on,online=on,maxDOP=2)
--alter index IX_AccessEventLog_UseraccountObjectidTimestamp on AccessEventLog rebuild with (sort_in_tempdb=on,online=on,maxDOP=2)
--alter index IX_AccessEventLog_timestamp_eventType on AccessEventLog rebuild with (sort_in_tempdb=on,online=on,maxDOP=2)
--update statistics SurveyRequestParam with fullscan;

alter index all on Address rebuild with (sort_in_tempdb=on,online=on,maxDOP=2)

alter index all on Alert rebuild with (sort_in_tempdb=on,online=on,maxDOP=2)

alter index all on  Announcement rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  AudioOption rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  BinaryContentAccess rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  BinaryContentAnnotation rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  BlockedANI rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  brand rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  campaign reorganize
update statistics campaign with fullscan;

alter index all on  CategoricalTransformationRule rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  CommentTerm rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  CompositePromptMapping rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  ContactInfo rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  Dashboard rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DashboardDefinitionComponent rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DataField rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DataFieldoption rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DataFieldgroup rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DataFieldOptionRecommendation rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DataFieldOrdinalInterval rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DataFieldScoreComponent rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DataFieldScoreComponentPoints rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DataFieldTranscriptionPrompt rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DataFieldTransformationSource rebuild with (sort_in_tempdb=on,online=on,maxDOP=2);

alter index all on  DeliveryQueue reorganize;
update statistics deliveryqueue;

alter index PK_DeliveryRunLogEntry on  DeliveryRunLogEntry rebuild with (sort_in_tempdb=on,online=on);
alter index IX_DeliveryRunLogEntry_ContextDate on  DeliveryRunLogEntry rebuild with (sort_in_tempdb=on,online=on);
alter index PK_DeliveryRunThreadLogEntry on  DeliveryRunThreadLogEntry rebuild with (sort_in_tempdb=on,online=on);
--alter index pk_dtproperties on  dtproperties rebuild with (sort_in_tempdb=on,online=on)
alter index PK__EmailQueue__080E6F4F on  EmailQueue rebuild with (sort_in_tempdb=on,online=on);

alter index all on  Employee rebuild with (sort_in_tempdb=on,online=on,maxdop=2);

alter index all on  FeedbackChannel rebuild with (sort_in_tempdb=on,online=on,maxdop=2);

alter index all on  FeedbackChannelType rebuild with (sort_in_tempdb=on,online=on,maxdop=2);

alter index all on  Folder rebuild with (sort_in_tempdb=on,online=on,maxdop=2);

alter index all on  FtpProfile rebuild with (sort_in_tempdb=on,online=on);
alter index all on  GlobalSettings rebuild with (sort_in_tempdb=on,online=on);
alter index PK_GlobalStopWord on  GlobalStopWord rebuild with (sort_in_tempdb=on,online=on);
alter index PK_Goal on  Goal rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Goal_by_Organization on  Goal rebuild with (sort_in_tempdb=on,online=on);
alter index PK_IncidentManagementPreset on  IncidentManagementPreset rebuild with (sort_in_tempdb=on,online=on);
alter index PK_JasperReportDefinition on  JasperReportDefinition rebuild with (sort_in_tempdb=on,online=on);

alter index all on  KeyDriverRank rebuild with (sort_in_tempdb=on,online=on,maxdop=2);

alter index all on  KeyDriverRankings rebuild with (sort_in_tempdb=on,online=on,maxdop=2);
alter index PK__Language__2E5C9EBB on  Language rebuild with (sort_in_tempdb=on,online=on);

alter index all on  Locale rebuild with (sort_in_tempdb=on,online=on,maxdop=2);

alter index all on  LocalizedString rebuild with (sort_in_tempdb=on,online=on,maxdop=2);
alter index all on  LocalizedStringValue reorganize;
update statistics localizedstringvalue with fullscan;

alter index PK_LocationAttribute on  LocationAttribute rebuild with (sort_in_tempdb=on,online=on);
alter index PK_LocationAttributeLocation on  LocationAttributeLocation rebuild with (sort_in_tempdb=on,online=on);
update statistics LocationAttributeLocation with fullscan;

alter index all on  LocationCategory rebuild with (sort_in_tempdb=on,online=on,maxdop=2);

alter index all on  LocationCategoryLocation rebuild with (sort_in_tempdb=on,online=on,maxdop=2);

alter index all on  LocationCategoryType rebuild with (sort_in_tempdb=on,online=on);

alter index IX_LocationCategoryType_by_Org on  LocationCategoryType rebuild with (sort_in_tempdb=on,online=on);
alter index PK_LocationCategoryUpliftModelRegression on  LocationCategoryUpliftModelRegression rebuild with (sort_in_tempdb=on,online=on);
alter index PK_LocationUpliftModelRegression on  LocationUpliftModelRegression rebuild with (sort_in_tempdb=on,online=on);

alter index all on  Offer rebuild with (sort_in_tempdb=on,online=on,maxdop=2);

alter index IX_Offer_FeedbackChannel on  Offer rebuild with (sort_in_tempdb=on,online=on);
alter index PK_OfferAccessPolicy on  OfferAccessPolicy rebuild with (sort_in_tempdb=on,online=on);
alter index PK_OfferAttribute on  OfferAttribute rebuild with (sort_in_tempdb=on,online=on);
alter index IX_OfferAttribute_LocalizedString on  OfferAttribute rebuild with (sort_in_tempdb=on,online=on);
alter index IX_OfferAttribute_Organization on  OfferAttribute rebuild with (sort_in_tempdb=on,online=on);
alter index PK_OfferAttributeOffer on  OfferAttributeOffer rebuild with (sort_in_tempdb=on,online=on);
alter index PK_OfferCode on  OfferCode rebuild with (sort_in_tempdb=on,online=on);
alter index IX_OfferCode_By_offerCodeAndPhone on  OfferCode rebuild with (sort_in_tempdb=on,online=on);
alter index IX_OfferCode_by_Location on  OfferCode rebuild with (sort_in_tempdb=on,online=on);
alter index IX_OfferCode_by_PhoneNumber on  OfferCode rebuild with (sort_in_tempdb=on,online=on);
--alter index IX_OfferCode_by_GatewayAndCode on  OfferCode rebuild with (sort_in_tempdb=on,online=on);
alter index IX_OfferCode_by_offer on  OfferCode rebuild with (sort_in_tempdb=on,online=on);
alter index PK_OfferSurvey on  OfferSurvey rebuild with (sort_in_tempdb=on,online=on);
alter index IX_OfferSurvey_By_Offer on  OfferSurvey rebuild with (sort_in_tempdb=on,online=on);
alter index PK_OrdinalFieldRecommendation on  OrdinalFieldRecommendation rebuild with (sort_in_tempdb=on,online=on);
alter index UK_Organization_apiKey on  Organization rebuild with (sort_in_tempdb=on,online=on);
alter index PK_Organization on  Organization rebuild with (sort_in_tempdb=on,online=on);
alter index UK_Organization_messagePhoneNumber on  Organization rebuild with (sort_in_tempdb=on,online=on);
alter index PK_OrganizationAccountManagers on  OrganizationAccountManagers rebuild with (sort_in_tempdb=on,online=on);

alter index PK_OrganizationalUnit on  OrganizationalUnit rebuild with (sort_in_tempdb=on,online=on);
alter index IX_OrganizationalUnit_by_Location on  OrganizationalUnit rebuild with (sort_in_tempdb=on,online=on);
alter index IX_OrganizationalUnit_by_LocationCategory on  OrganizationalUnit rebuild with (sort_in_tempdb=on,online=on);
update statistics OrganizationalUnit with fullscan;

alter index IX_OrganizationLocale_by_Organization on  OrganizationLocale rebuild with (sort_in_tempdb=on,online=on);
alter index PK_OrganizationLocale on  OrganizationLocale rebuild with (sort_in_tempdb=on,online=on);
alter index PK_OrganizationUserAccount on  OrganizationUserAccount rebuild with (sort_in_tempdb=on,online=on);
alter index IX_OrganizationUserAccount_by_AcctAndOrg on  OrganizationUserAccount rebuild with (sort_in_tempdb=on,online=on);
alter index PK_Page on  Page rebuild with (sort_in_tempdb=on,online=on);
--alter index IX_Page_by_Organization on  Page rebuild with (sort_in_tempdb=on,online=on);
alter index UK_Page_Name on  Page rebuild with (sort_in_tempdb=on,online=on);
alter index UK_Page_Description on  Page rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriteriaSet on  PageCriteriaSet rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterion on  PageCriterion rebuild with (sort_in_tempdb=on,online=on);
alter index UK_PageCriterion_Label on  PageCriterion rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionDataFieldOption on  PageCriterionDataFieldOption rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionExclusionReason on  PageCriterionExclusionReason rebuild with (sort_in_tempdb=on,online=on);
alter index PK_ReportCriterionFeedbackChannel on  PageCriterionFeedbackChannel rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionLocation on  PageCriterionLocation rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionLocationAttribute on  PageCriterionLocationAttribute rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionLocationCategory on  PageCriterionLocationCategory rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionMode on  PageCriterionMode rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionOffer on  PageCriterionOffer rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionPeriod on  PageCriterionPeriod rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionSatisfactionType on  PageCriterionSatisfactionType rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionState on  PageCriterionState rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionSurvey on  PageCriterionSurvey rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionTag on  PageCriterionTag rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionTagCategory on  PageCriterionTagCategory rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionTagType on  PageCriterionTagType rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageCriterionUserAccount on  PageCriterionUserAccount rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageDataField on  PageDataField rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageLocCatAccess on  PageLocCatAccess rebuild with (sort_in_tempdb=on,online=on);
--alter index PK_PageLogEntry on  PageLogEntry rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_PageLogEntry_Page_CreationDateTime on  PageLogEntry rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_PageLogEntry_by_PageSchedule on  PageLogEntry rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_PageLogEntry_by_Page on  PageLogEntry rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_PageLogEntry_by_CreationDateTime on  PageLogEntry rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_PageLogEntry_DeliveryRunLogEntry_PageSchedule_Page on  PageLogEntry rebuild with (sort_in_tempdb=on,online=on)
--alter index PK_PageLogEntryOrganizationalUnit on  PageLogEntryOrganizationalUnit rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_PageLogEntryOrganizationalUnit_PageLogEntry on  PageLogEntryOrganizationalUnit rebuild with (sort_in_tempdb=on,online=on)
--alter index PK_PageLogEntryUserAccount on  PageLogEntryUserAccount rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_PageLogEntryUserAccount_PageLogEntry on  PageLogEntryUserAccount rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_PageLogEntryUserAccount_UserAccount on  PageLogEntryUserAccount rebuild with (sort_in_tempdb=on,online=on)
alter index IX_PageSchedule_by_Page on  PageSchedule rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PageSchedule_by_Active_Date on  PageSchedule rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageSchedule on  PageSchedule rebuild with (sort_in_tempdb=on,online=on);
alter index UK_PageSchedule_Title on  PageSchedule rebuild with (sort_in_tempdb=on,online=on);
alter index UK_PageSchedule_Instructions on  PageSchedule rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageScheduleCriterion on  PageScheduleCriterion rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageScheduleOptOut on  PageScheduleOptOut rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageScheduleSubscription on  PageScheduleSubscription rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PageWebAccess on  PageWebAccess rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PasswordHistory on  PasswordHistory rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PasswordHistory_UseraccountObjectidDate on  PasswordHistory rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PeerComparisonModel on  PeerComparisonModel rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PeerComparisonModel_upliftModelId on  PeerComparisonModel rebuild with (sort_in_tempdb=on,online=on);
alter index PK_Period on  Period rebuild with (sort_in_tempdb=on,online=on);
--alter index IX_Period_by_PeriodType on  Period rebuild with (sort_in_tempdb=on,online=on);
--alter index IX_Period_by_Organization on  Period rebuild with (sort_in_tempdb=on,online=on);
alter index UK_Period_name on  Period rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PeriodRange on  PeriodRange rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PeriodRange_by_PeriodType on  PeriodRange rebuild with (sort_in_tempdb=on,online=on);
alter index UK_PeriodRange_label on  PeriodRange rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PeriodType on  PeriodType rebuild with (sort_in_tempdb=on,online=on);
alter index UK_PeriodType_name on  PeriodType rebuild with (sort_in_tempdb=on,online=on);
alter index UK_PeriodType_label on  PeriodType rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Phrase_by_Prompt on  Phrase reorganize;
alter index PK_PromptAudio on  Phrase rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Phrase_PromptChoice on  Phrase rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Phrase_audioObjectId on  Phrase rebuild with (sort_in_tempdb=on,online=on)
alter index UQC_Prompt_AudioOption_UsageType_Choice on  Phrase rebuild with (sort_in_tempdb=on,online=on);
alter index PK__PlumStatus__159BDDE9 on  PlumStatus rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PlumStatus_by_host_creationDateTime on  PlumStatus rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PostalCode on  PostalCode rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PostalCode_by_Country_PostalCode on  PostalCode rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PostalCode_by_PostalCode on  PostalCode rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PostalCode_by_Latitude_Longitude on  PostalCode rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PostalCode_by_dtmfCode on  PostalCode rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Prompt_by_dataField on  Prompt rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Prompt_by_outputDataFieldObjectId on  Prompt rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PROMPT_BY_PROMPT_TYPE on  Prompt rebuild with (sort_in_tempdb=on,online=on);
alter index PK_Prompt on  Prompt rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Prompt_Organization on  Prompt rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PromptChoice on  PromptChoice rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PromptChoice_UniqueDtmf on  PromptChoice rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PromptEvent on  PromptEvent reorganize;
alter index IX_PromptEvent_by_conditionDataFieldObjectId on  PromptEvent rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PromptEvent_by_Prompt on  PromptEvent rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PromptEvent_by_ActionDateOfServiceType on  PromptEvent rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PromptEventLocationCategoryType on  PromptEventLocationCategoryType rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PromptEventPromp on  PromptEventPrompt rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PromptEventTrigger on  PromptEventTrigger rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PromptEventTrigger_by_Event on  PromptEventTrigger rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PromptEventTriggerLocationAttribute on  PromptEventTriggerLocationAttribute rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PromptEventTriggerLocationCategory on  PromptEventTriggerLocationCategory rebuild with (sort_in_tempdb=on,online=on);
alter index IX_PromptEventTriggerLocationCategory_by_Event on  PromptEventTriggerLocationCategory rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PromptGroup on  PromptGroup rebuild with (sort_in_tempdb=on,online=on);
alter index PK__RedemptionCode__1784265B on  RedemptionCode rebuild with (sort_in_tempdb=on,online=on);
alter index IX_RedemptionCode_by_OfferCode on  RedemptionCode rebuild with (sort_in_tempdb=on,online=on);
alter index PK_ReportBenchmark on  ReportBenchmark rebuild with (sort_in_tempdb=on,online=on);
alter index UK_Report_benchmarkLabel on  ReportBenchmark rebuild with (sort_in_tempdb=on,online=on);
alter index PK_ReportColumn on  ReportColumn rebuild with (sort_in_tempdb=on,online=on);
alter index IX_ReportColumn_by_Report on  ReportColumn rebuild with (sort_in_tempdb=on,online=on);
alter index IX_ReportColumn_by_DataField on  ReportColumn rebuild with (sort_in_tempdb=on,online=on);
alter index UK_ReportColumn_label on  ReportColumn rebuild with (sort_in_tempdb=on,online=on);
alter index PK_ReportColumnComputation on  ReportColumnComputation rebuild with (sort_in_tempdb=on,online=on);
alter index PK_ReportColumnCriteriaSet on  ReportColumnCriteriaSet rebuild with (sort_in_tempdb=on,online=on);
alter index PK_ReportColumnDrillDownParam on  ReportColumnDrillDownParam rebuild with (sort_in_tempdb=on,online=on);
alter index PK_ScorecardCrossTabField on  ScorecardCrossTabField rebuild with (sort_in_tempdb=on,online=on);
alter index PK_ScorecardLocCatType on  ScorecardLocCatType rebuild with (sort_in_tempdb=on,online=on);
alter index PK_ScorecardScore on  ScorecardScore rebuild with (sort_in_tempdb=on,online=on);
alter index PK_Signup on  Signup reorganize;
alter index PK_SignupNewLocation on  SignupNewLocation rebuild with (sort_in_tempdb=on,online=on);
alter index PK_SignupPlan on  SignupPlan rebuild with (sort_in_tempdb=on,online=on);
alter index PK_SignupPricePoint on  SignupPricePoint rebuild with (sort_in_tempdb=on,online=on);
alter index PK_SignupProperties on  SignupProperties reorganize;
alter index PK_SignupRemovedLocation on  SignupRemovedLocation rebuild with (sort_in_tempdb=on,online=on);
alter index PK__SocialMedia__4A706432 on  SocialMedia rebuild with (sort_in_tempdb=on,online=on);
alter index PK_Survey on  Survey rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Survey_by_Organization on  Survey rebuild with (sort_in_tempdb=on,online=on);
--alter index _dta_index_Survey_5_2111346586__K4_1 on  Survey rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Survey_FeedbackChannel on  Survey rebuild with (sort_in_tempdb=on,online=on);
alter index PK_PhoneNumber on  SurveyGateway rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Gateway_By_Dnis on  SurveyGateway rebuild with (sort_in_tempdb=on,online=on);
alter index PK_SurveyGatewayParameter on  SurveyGatewayParameter rebuild with (sort_in_tempdb=on,online=on);
alter index IX_GatewayParameter_By_Gateway on  SurveyGatewayParameter rebuild with (sort_in_tempdb=on,online=on);
--alter index PK_Surveyresponse on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_complete_beginDate_Offer_id on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_by_Survey_beginTime on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_by_Survey_beginDate_complete on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_by_Survey_beginDate on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_by_Survey on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_by_OfferCode_beginDate on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_by_loyalty_offerCode on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_by_cookieUID_offerCode on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_by_AssignedUser_IsRead_Complete_OfferCode_Id on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_by_ani_complete_beginDate_offerCode on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponse_by_OfferCode_beginDate_complete_exclusionReason on  SurveyResponse rebuild with (sort_in_tempdb=on,online=on)
--alter index PK__SurveyResponseAl__6E7723D0 on  SurveyResponseAlert rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseAlert_by_SurveyResponse on  SurveyResponseAlert rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseAlert_by_ResponseAndTrigger on  SurveyResponseAlert rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseAlert_by_TriggerField on  SurveyResponseAlert rebuild with (sort_in_tempdb=on,online=on)
--alter index PK_SurveyresponseAnswer on  SurveyResponseAnswer rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseAnswer_by_SurveyResponse_Id on  SurveyResponseAnswer rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseAnswer_by_SurveyResponse_BinaryContent on  SurveyResponseAnswer rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseAnswer_by_field_binary_response on  SurveyResponseAnswer rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseAnswer_by_DataFieldOption on  SurveyResponseAnswer rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseAnswer_by_dataFieldObjectId on  SurveyResponseAnswer rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseAnswer_by_BinaryContent_SurveyResponse on  SurveyResponseAnswer rebuild with (sort_in_tempdb=on,online=on)
--alter index PK_SurveyResponseNote on  SurveyResponseNote rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseNote_by_SurveyResponse_dateStamp_stateType on  SurveyResponseNote rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseNote_by_datestamp1 on  SurveyResponseNote rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseNote_by_SurveyResponse_Datestamp1 on  SurveyResponseNote rebuild with (sort_in_tempdb=on,online=on)
--alter index PK_SurveyresponseScore on  SurveyResponseScore rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseScore_by_SurveyResponse_DataField on  SurveyResponseScore rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseScore_by_field on  SurveyResponseScore rebuild with (sort_in_tempdb=on,online=on)
--alter index PK_SurveyResponseTag on  SurveyResponseTag rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseTag_SurveyResponse on  SurveyResponseTag rebuild with (sort_in_tempdb=on,online=on)
--alter index UK_SurveyResponseTag_ResponseTag on  SurveyResponseTag rebuild with (sort_in_tempdb=on,online=on)
--alter index IX_SurveyResponseTag_BinaryContentAnnotation on  SurveyResponseTag rebuild with (sort_in_tempdb=on,online=on)
alter index PK_SurveyStep on  SurveyStep rebuild with (sort_in_tempdb=on,online=on);
alter index IX_SurveyStep_by_Survey on  SurveyStep rebuild with (sort_in_tempdb=on,online=on);
alter index PK_SurveyStepPrompt on  SurveyStepPrompt rebuild with (sort_in_tempdb=on,online=on);

alter index PK_Tag on  Tag rebuild with (sort_in_tempdb=on,online=on);
alter index IX_Tag_Organization on  Tag rebuild with (sort_in_tempdb=on,online=on);
alter index IX_TagCategoryObjectId on  Tag rebuild with (sort_in_tempdb=on,online=on);
alter index UK_Tag_name on  Tag rebuild with (sort_in_tempdb=on,online=on);
alter index PK_TagCategory on  TagCategory rebuild with (sort_in_tempdb=on,online=on);
alter index IX_TagCategory_Organization on  TagCategory rebuild with (sort_in_tempdb=on,online=on);
alter index PK_TempComment on  TempComment reorganize;
alter index IX_TempComment_SurveyResponseAnswerObjectId on  TempComment rebuild with (sort_in_tempdb=on,online=on);
alter index PK_Term on  Term rebuild with (sort_in_tempdb=on,online=on);
alter index PK_TermFilter on  TermFilter rebuild with (sort_in_tempdb=on,online=on);
alter index PK_TileGroup on  TileGroup rebuild with (sort_in_tempdb=on,online=on);
alter index IX_TileGroup_Sequence on  TileGroup rebuild with (sort_in_tempdb=on,online=on);
alter index IX_TileGroup_PeerComparisonModelId on  TileGroup rebuild with (sort_in_tempdb=on,online=on);
alter index PK_Transcription on  Transcription rebuild with (sort_in_tempdb=on,online=on);
alter index PK_TranslatorAudioOption on  TranslatorAudioOption rebuild with (sort_in_tempdb=on,online=on);
alter index PK_TranslatorSurvey on  TranslatorSurvey rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UnstructuredFeedbackComment on  UnstructuredFeedbackCommentField rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UnstructuredFeedbackModel on  UnstructuredFeedbackModel rebuild with (sort_in_tempdb=on,online=on);
alter index UN_UnstructuredFeedbackModel_Name on  UnstructuredFeedbackModel rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UnstructuredFeedbackTermFilter on  UnstructuredFeedbackTermFilter rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UpliftModel on  UpliftModel rebuild with (sort_in_tempdb=on,online=on);
alter index UN_UpliftModel_Name_Channel on  UpliftModel rebuild with (sort_in_tempdb=on,online=on);
alter index IX_UpliftModel_FeedbackChannel on  UpliftModel rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UpliftModelPerformanceAttribute on  UpliftModelPerformanceAttribute rebuild with (sort_in_tempdb=on,online=on);
alter index UN_UpliftModelPerformanceAttribute_Model_Field on  UpliftModelPerformanceAttribute rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UpliftModelRegression on  UpliftModelRegression rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UpliftModelRegressionParam on  UpliftModelRegressionParam rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UpliftModelStrategy on  UpliftModelStrategy rebuild with (sort_in_tempdb=on,online=on);
alter index PK_User on  UserAccount rebuild with (sort_in_tempdb=on,online=on);
alter index IX_UserAccount_UniqueEmail on  UserAccount rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UserAccountLocation on  UserAccountLocation rebuild with (sort_in_tempdb=on,online=on);
--alter index IX_UserAccountLocation_by_UserAccount on  UserAccountLocation rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UserAccountLocationCategory on  UserAccountLocationCategory rebuild with (sort_in_tempdb=on,online=on);
alter index IX_UserAccountLocationCategory_by_UserAccount on  UserAccountLocationCategory rebuild with (sort_in_tempdb=on,online=on);
alter index IX_UserAccountLocationCategory_by_LocationCategory on  UserAccountLocationCategory rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UserAccountRole on  UserAccountRole rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UserEncryptionKey on  UserEncryptionKey rebuild with (sort_in_tempdb=on,online=on);
alter index PK_UserSession on  UserSession rebuild with (sort_in_tempdb=on,online=on);
alter index IX_UserSession_by_userAccount on  UserSession rebuild with (sort_in_tempdb=on,online=on);
alter index IX_UserSession_by_AccountAndDate on  UserSession rebuild with (sort_in_tempdb=on,online=on);
alter index IX_UserSession_sessionDate on  UserSession rebuild with (sort_in_tempdb=on,online=on);
--alter index PK_WebServiceInitedSurveyResponse on  WebServiceInitedSurveyResponse rebuild with (sort_in_tempdb=on,online=on);
--alter index PK_WebServiceInitedSurveyResponseParam on  WebServiceInitedSurveyResponseParam rebuild with (sort_in_tempdb=on,online=on);
--alter index IX_WebServiceInitedSurveyResponse_by_uniqueKey on  WebServiceInitedSurveyResponse rebuild with (sort_in_tempdb=on,online=on);
--alter index IX_WebServiceInitedSurveyResponseParam_by_WebServiceInitedSurveyResponse on  WebServiceInitedSurveyResponseParam rebuild with (sort_in_tempdb=on,online=on);
alter index PK_WebSurveyStyle on  WebSurveyStyle rebuild with (sort_in_tempdb=on,online=on);
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

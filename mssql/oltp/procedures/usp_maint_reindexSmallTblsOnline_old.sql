SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_maint_reindexSmallTblsOnline_old]
as
BEGIN
	print 'Reorganizing indices...'

	print 'BinaryContent'
	alter index all on BinaryContent reorganize
	print 'PageLogEntry'
	alter index all on PageLogEntry reorganize
	print 'PageLogEntryOrganizationalUnit'
	alter index all on PageLogEntryOrganizationalUnit reorganize
	print 'PageLogEntryUserAccount'
	alter index all on PageLogEntryUserAccount reorganize
	print 'SurveyResponse'
	alter index all on SurveyResponse reorganize
	print 'SurveyResponseAlert'
	alter index all on SurveyResponseAlert reorganize
	print 'SurveyResponseNote'
	alter index all on SurveyResponseNote reorganize
	print 'SurveyResponseScore'
	alter index all on SurveyResponseScore reorganize
	print 'SurveyResponseTag'
	alter index all on SurveyResponseTag reorganize

	print 'Rebuilding indices...'

	print 'Address'
	alter index PK_Address on Address rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Address_by_PostalCode on Address rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Announcement'
	alter index PK_Announcement on Announcement rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Announcement_by_Org_Date on Announcement rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Announcement_name on Announcement rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Announcement_content on Announcement rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'AudioOption'
	alter index PK_AudioOption on AudioOption rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)

	--print 'BinaryContentAccess'
	--alter index PK_BinaryContentAccessKey on BinaryContentAccess rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'BlockedANI'
	alter index PK_BlockedANI on BlockedANI rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index BlockedANI_ani on BlockedANI rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--print 'Campaign'
	--alter index PK__Campaign__225785E0 on Campaign rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'CompositePromptMapping'
	alter index PK_CompositePromptMapping on CompositePromptMapping rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'ContactInfo'
	alter index PK_ContactInfo on ContactInfo rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'DataField'
	alter index PK_DataField on DataField rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_DataField_by_Organization_fieldType_name on DataField rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_DataField_Label on DataField rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_DataField_by_systemField on DataField rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_DataField_Text on DataField rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_DataField_by_Organization_scriptBindingName_name on DataField rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'DataFieldGroup'
	alter index PK_DataFieldGroup on DataFieldGroup rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'DataFieldOption'
	alter index PK_DataFieldOption on DataFieldOption rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_DataFieldOption_by_DataField on DataFieldOption rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_DataFieldOption_Label on DataFieldOption rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'DataFieldScoreComponent'
	alter index PK_DataFieldScoreComponent on DataFieldScoreComponent rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'DataFieldScoreComponent'
	alter index IX_DataFieldScoreComponent_by_Field_ScoredField on DataFieldScoreComponent rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'DataFieldScoreComponentPoints'
	alter index PK_DataFieldScoreComponentPoints on DataFieldScoreComponentPoints rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_DataFieldScoreComponentPoints_DataFieldScoreComponent on DataFieldScoreComponentPoints rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_DataFieldScoreComponentPoints_DataFieldOption on DataFieldScoreComponentPoints rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'DataFieldTranscriptionPrompt'
	alter index PK_DataFieldTranscriptionPrompt on DataFieldTranscriptionPrompt rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'DeliveryRunLogEntry'--select count(*) from DeliveryRunLogEntry
	alter index PK_DeliveryRunLogEntry on DeliveryRunLogEntry rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'DeliveryRunThreadLogEntry'--select count(*) from DeliveryRunThreadLogEntry
	alter index PK_DeliveryRunThreadLogEntry on DeliveryRunThreadLogEntry rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'EmailQueue' --select count(*) from emailqueue
--	alter index PK_EmailQueue on EmailQueue rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
--	alter index IX_EmailQueue_creationDateTime on EmailQueue reorganize-- with(fillfactor=80,sort_in_tempdb=on,online=on)
--	alter index IX_EmailQueue_by_sentDateTime on EmailQueue rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
--	alter index IX_EmailQueue_attachment on EmailQueue rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
--	print 'Employee'
	alter index PK_Employee on Employee rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Employee_by_Location on Employee rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Employee_by_Location_employeeCode on Employee rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Employee_by_Location_Employee_Code on Employee rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Folder'
	alter index PK_Folder on Folder rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Folder_Name on Folder rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Folder_Description on Folder rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Goal'
	alter index PK_Goal on Goal rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Goal_by_Organization on Goal rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Locale'--select count(*) from Locale
	alter index PK_Locale on Locale rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Locale_LocaleKey on Locale rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Locale_SortOrder on Locale rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'LocalizedString'
	alter index PK_LocalizedString on LocalizedString rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'LocalizedStringValue'
	alter index PK_LocalizedStringValue on LocalizedStringValue reorganize --with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Location'
	alter index PK_Location on Location rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Location_by_Organization on Location rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Location_by_Organization_and_number on Location rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Location_enabled on Location rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'LocationAttribute'
	alter index PK_LocationAttribute on LocationAttribute rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'LocationAttributeLocation'
	alter index PK_LocationAttributeLocation on LocationAttributeLocation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'LocationCategory'
	alter index PK_LocationCategory on LocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_LocationCategory_by_category_type on LocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_LocationCategory_by_Organization on LocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_LocationCategory_Lineage on LocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_LocationCategory_by_parentObjectId on LocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_LocationCategory_by_LocationCategoryType_id on LocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'LocationCategoryLocation'
	alter index PK_LocationCategoryLocation on LocationCategoryLocation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_LocationCategoryLocation_by_location on LocationCategoryLocation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_LocationCategoryLocation_by_Category on LocationCategoryLocation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_LocationCategoryLocation_Location_LocationCategory on LocationCategoryLocation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'LocationCategoryType'
	alter index PK_LocationCategoryType on LocationCategoryType rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_LocationCategoryType_by_Org on LocationCategoryType rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'McDonaldsLocalizedStringValue'
	alter index PK_McDonaldsLocalizedStringValue on McDonaldsLocalizedStringValue reorganize-- with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Offer'
	alter index PK_Offer on Offer rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'OfferCode'
	alter index PK_OfferCode on OfferCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_OfferCode_By_offerCodeAndPhone on OfferCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_OfferCode_by_Location on OfferCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_OfferCode_by_PhoneNumber on OfferCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_OfferCode_by_GatewayAndCode on OfferCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_OfferCode_by_offer on OfferCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'OfferSurvey'
	alter index PK_OfferSurvey on OfferSurvey rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_OfferSurvey_By_Offer on OfferSurvey rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Organization'
	alter index PK_Organization on Organization rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Organization_apiKey on Organization rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Organization_messagePhoneNumber on Organization rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'OrganizationAccountManagers'
	alter index PK_OrganizationAccountManagers on OrganizationAccountManagers rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'OrganizationalUnit'
	alter index PK_OrganizationalUnit on OrganizationalUnit rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'OrganizationLocale'
	alter index PK_OrganizationLocale on OrganizationLocale rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_OrganizationLocale_by_Organization on OrganizationLocale rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)

	print 'OrganizationUserAccount'
	alter index PK_OrganizationUserAccount on OrganizationUserAccount rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_OrganizationUserAccount_by_AcctAndOrg on OrganizationUserAccount rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Page'
	alter index PK_Page on Page rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Page_by_Organization on Page rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Page_Name on Page rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Page_Description on Page rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriteriaSet'
	alter index PK_PageCriteriaSet on PageCriteriaSet rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterion'
	alter index PK_PageCriterion on PageCriterion rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_PageCriterion_Label on PageCriterion rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionDataFieldOption'
	alter index PK_PageCriterionDataFieldOption on PageCriterionDataFieldOption rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionLocation'
	alter index PK_PageCriterionLocation on PageCriterionLocation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionLocationAttribute'
	alter index PK_PageCriterionLocationAttribute on PageCriterionLocationAttribute rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionLocationCategory'
	alter index PK_PageCriterionLocationCategory on PageCriterionLocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionMode'
	alter index PK_PageCriterionMode on PageCriterionMode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionOffer'
	alter index PK_PageCriterionOffer on PageCriterionOffer rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionPeriod'
	alter index PK_PageCriterionPeriod on PageCriterionPeriod rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionSatisfactionType'
	alter index PK_PageCriterionSatisfactionType on PageCriterionSatisfactionType rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionState'
	alter index PK_PageCriterionState on PageCriterionState rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionSurvey'
	alter index PK_PageCriterionSurvey on PageCriterionSurvey rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionTag'
	alter index PK_PageCriterionTag on PageCriterionTag rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageCriterionUserAccount'
	alter index PK_PageCriterionUserAccount on PageCriterionUserAccount rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageDataField'
	alter index PK_PageDataField on PageDataField rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageLocCatAccess'
	alter index PK_PageLocCatAccess on PageLocCatAccess rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)

	--print 'PageLogEntry'--select count(*) from PageLogEntry
	--alter index PK_PageLogEntry on PageLogEntry rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_PageLogEntry_by_CreationDateTime on PageLogEntry rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_PageLogEntry_Page_CreationDateTime on PageLogEntry rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_PageLogEntry_by_Page on PageLogEntry rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_PageLogEntry_by_PageSchedule on PageLogEntry rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)

	--print 'PageLogEntryOrganizationalUnit'--select count(*) from PageLogEntryOrganizationalUnit
	--alter index PK_PageLogEntryOrganizationalUnit on PageLogEntryOrganizationalUnit rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_PageLogEntryOrganizationalUnit_PageLogEntry on PageLogEntryOrganizationalUnit rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)

	--print 'PageLogEntryUserAccount'--select count(*) from PageLogEntryUserAccount
	--alter index PK_PageLogEntryUserAccount on PageLogEntryUserAccount rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_PageLogEntryUserAccount_UserAccount on PageLogEntryUserAccount rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_PageLogEntryUserAccount_PageLogEntry on PageLogEntryUserAccount rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageSchedule'
	alter index PK_PageSchedule on PageSchedule rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PageSchedule_by_Active_Date on PageSchedule rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PageSchedule_by_Page on PageSchedule rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageScheduleCriterion'
	alter index PK_PageScheduleCriterion on PageScheduleCriterion rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageScheduleOptOut'
	alter index PK_PageScheduleOptOut on PageScheduleOptOut rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageScheduleSubscription'
	alter index PK_PageScheduleSubscription on PageScheduleSubscription rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PageWebAccess'
	alter index PK_PageWebAccess on PageWebAccess rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)

	print 'Period'
	alter index PK_Period on Period rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Period_by_PeriodType on Period rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Period_by_Organization on Period rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Period_name on Period rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PeriodRange'
	alter index PK_PeriodRange on PeriodRange rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PeriodRange_by_PeriodType on PeriodRange rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_PeriodRange_label on PeriodRange rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PeriodType'
	alter index PK_PeriodType on PeriodType rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_PeriodType_name on PeriodType rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_PeriodType_label on PeriodType rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Phrase'
	alter index PK_PromptAudio on Phrase rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Phrase_by_Prompt on Phrase reorganize-- with(fillfactor=80,sort_in_tempdb=on,online=on)

	alter index IX_Phrase_PromptChoice on Phrase rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Phrase_audioObjectId on Phrase rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UQC_Prompt_AudioOption_UsageType_Choice on Phrase rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PostalCode'
	alter index PK_PostalCode on PostalCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PostalCode_by_Country_PostalCode on PostalCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PostalCode_by_PostalCode on PostalCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PostalCode_by_Latitude_Longitude on PostalCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PostalCode_by_dtmfCode on PostalCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Prompt'
	alter index PK_Prompt on Prompt rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Prompt_by_dataField on Prompt rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Prompt_by_outputDataFieldObjectId on Prompt rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PROMPT_BY_PROMPT_TYPE on Prompt rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)

	alter index IX_Prompt_Organization on Prompt rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PromptChoice'
	alter index PK_PromptChoice on PromptChoice rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PromptChoice_UniqueDtmf on PromptChoice rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PromptEvent'
	alter index PK_PromptEvent on PromptEvent reorganize-- with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PromptEvent_by_conditionDataFieldObjectId on PromptEvent rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PromptEvent_by_Prompt on PromptEvent rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PromptEvent_by_ActionDateOfServiceType on PromptEvent rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PromptEventLocationCategoryType'
	alter index PK_PromptEventLocationCategoryType on PromptEventLocationCategoryType rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PromptEventPrompt'
	alter index PK_PromptEventPromp on PromptEventPrompt rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PromptEventTrigger'
	alter index PK_PromptEventTrigger on PromptEventTrigger rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PromptEventTrigger_by_Event on PromptEventTrigger rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PromptEventTriggerLocationAttribute'
	alter index PK_PromptEventTriggerLocationAttribute on PromptEventTriggerLocationAttribute rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PromptEventTriggerLocationCategory'
	alter index PK_PromptEventTriggerLocationCategory on PromptEventTriggerLocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_PromptEventTriggerLocationCategory_by_Event on PromptEventTriggerLocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'PromptGroup'
	alter index PK_PromptGroup on PromptGroup rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--print 'RedemptionCode'--select count(*) from redemptioncode
	--alter index PK__RedemptionCode__1784265B on RedemptionCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_RedemptionCode_by_OfferCode on RedemptionCode rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'ReportBenchmark'
	alter index PK_ReportBenchmark on ReportBenchmark rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Report_benchmarkLabel on ReportBenchmark rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'ReportColumn'
	alter index PK_ReportColumn on ReportColumn rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_ReportColumn_by_Page on ReportColumn rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_ReportColumn_by_DataField on ReportColumn rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_ReportColumn_label on ReportColumn rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'ReportColumnComputation'
	alter index PK_ReportColumnComputation on ReportColumnComputation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'ReportColumnCriteriaSet'
	alter index PK_ReportColumnCriteriaSet on ReportColumnCriteriaSet rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'ReportColumnDrillDownParam'
	alter index PK_ReportColumnDrillDownParam on ReportColumnDrillDownParam rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_ReportSchedule_title on ReportSchedule rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_ReportSchedule_instructions on ReportSchedule rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'ScorecardCrossTabField'
	alter index PK_ScorecardCrossTabField on ScorecardCrossTabField rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'ScorecardLocCatType'
	alter index PK_ScorecardCrossLocCatType on ScorecardLocCatType rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'ScorecardScore'
	alter index PK_ScorecardScore on ScorecardScore rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Signup'
	alter index PK_Signup on Signup reorganize-- with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'SignupNewLocation'
	alter index PK_SignupNewLocation on SignupNewLocation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'SignupPlan'
	alter index PK_SignupPlan on SignupPlan rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'SignupPricePoint'
	alter index PK_SignupPricePoint on SignupPricePoint rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'SignupProperties'
	alter index PK_SignupProperties on SignupProperties reorganize-- with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'SignupRemovedLocation'
	alter index PK_SignupRemovedLocation on SignupRemovedLocation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Survey'
	alter index PK_Survey on Survey rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Survey_by_Organization on Survey rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'SurveyGateway'
	alter index PK_PhoneNumber on SurveyGateway rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Gateway_By_Dnis on SurveyGateway rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'SurveyGatewayParameter'
	alter index PK_SurveyGatewayParameter on SurveyGatewayParameter rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_GatewayParameter_By_Gateway on SurveyGatewayParameter rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)

	--print 'SurveyResponseAlert'--select count(*) from surveyresponsealert
	--alter index PK__SurveyResponseAl__6E7723D0 on SurveyResponseAlert rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_SurveyResponseAlert_by_SurveyResponse on SurveyResponseAlert rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_SurveyResponseAlert_by_ResponseAndTrigger on SurveyResponseAlert rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_SurveyResponseAlert_by_TriggerField on SurveyResponseAlert rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--print 'SurveyResponseNote'--select count(*) from surveyresponsenote
	--alter index PK_SurveyResponseNote on SurveyResponseNote rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_SurveyResponseNote_by_datestamp on SurveyResponseNote rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_SurveyResponseNote_by_SurveyResponse_Datestamp on SurveyResponseNote rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--print 'surveyresponsescore'--select count(*) from surveyresponsescore
	--alter index PK_SurveyResponseScore on SurveyResponseScore rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_SurveyResponseScore_by_SurveyResponse_DataField on SurveyResponseScore rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--alter index IX_SurveyResponseScore_by_field on SurveyResponseScore rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	--print 'address'--select count(*) from surveyresponsetag
	--alter index PK_SurveyResponseTag on SurveyResponseTag rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'SurveyStep'
	alter index PK_SurveyStep on SurveyStep rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_SurveyStep_by_Survey on SurveyStep rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'SurveyStepPrompt'
	alter index PK_SurveyStepPrompt on SurveyStepPrompt rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'SystemEncryptionKey'
	alter index PK_SystemEncryptionKey on SystemEncryptionKey reorganize-- rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Tag'
	alter index PK_Tag on Tag rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Tag_Organization on Tag rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Tag_name on Tag rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Tip'
	alter index PK_Tip on Tip rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_Tip_by_nameObjectid on Tip rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Tip_name on Tip rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index UK_Tip_content on Tip rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'Transcription'
	alter index PK_Transcription on Transcription rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'TranslatorAudioOption'
	alter index PK_TranslatorAudioOption on TranslatorAudioOption rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'TranslatorSurvey'
	alter index PK_TranslatorSurvey on TranslatorSurvey rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'UserAccount'
	alter index PK_User on UserAccount rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_UserAccount_UniqueEmail on UserAccount rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'UserAccountLocation'
	alter index PK_UserAccountLocation on UserAccountLocation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_UserAccountLocation_by_UserAccount on UserAccountLocation rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'UserAccountLocationCategory'
	alter index PK_UserAccountLocationCategory on UserAccountLocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_UserAccountLocationCategory_by_UserAccount on UserAccountLocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_UserAccountLocationCategory_by_LocationCategory on UserAccountLocationCategory rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'UserAccountRole'
	alter index PK_UserAccountRole on UserAccountRole rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'UserEncryptionKey'
	alter index PK_UserEncryptionKey on UserEncryptionKey rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'UserSession'--select count(*) from usersession
	alter index PK_UserSession on UserSession reorganize --with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_UserSession_by_userAccount on UserSession reorganize --with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_UserSession_by_AccountAndDate on UserSession reorganize --with(fillfactor=80,sort_in_tempdb=on,online=on)
	alter index IX_UserSession_sessionDate on UserSession reorganize --with(fillfactor=80,sort_in_tempdb=on,online=on)
	print 'WebSurveyStyle'
	alter index PK_WebSurveyStyle on WebSurveyStyle rebuild with(fillfactor=80,sort_in_tempdb=on,online=on)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

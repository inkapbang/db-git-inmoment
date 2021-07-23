SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_TranslationsExport_AutoDelivery_test]
	@DisplayInfo				int				= 1
	, @ShowChecks				int				= 0		
	, @TableColumnList			int 			= 1
	, @OrganizationObjectId		int				= NULL
	, @OrganizationName			varchar(100)	= NULL	
	, @OrganizationNameLookup	int				= 0
	, @DeliveryEmail			varchar(100)	= NULL
	, @localeKey01				varchar(10)		= 'en_US'
	, @localeKey02				varchar(10)		= NULL
	


AS

/********************************************  Translation Export Requests  ********************************************

	Comments
		
		Tested and completed.  Found some abnormalities in database as a result of building the automated version.


	History
		11.01.2014	Tad Peterson
			-- created, tested, and finished
		
		01.13.2014	Tad Peterson
			-- added info to have unnecessary row(s) removed in import file


			
************************************************************************************************************************/
SET NOCOUNT ON



DECLARE @DisplayInfoCheck						int
SET 	@DisplayInfoCheck						= CASE WHEN @DisplayInfo = 1						THEN 1							ELSE 0		END



DECLARE @ShowChecksCheck						int
SET		@ShowChecksCheck						= CASE	WHEN @ShowChecks IS NULL 					THEN 0
														WHEN @ShowChecks = 1						THEN 1
														ELSE 0
													END



DECLARE @TableColumnListCheck					int
SET		@TableColumnListCheck					= CASE	WHEN @TableColumnList	= 1 				THEN 1							ELSE 0		END

									

DECLARE @OrganizationObjectIdCheck				int
SET		@OrganizationObjectIdCheck				= CASE	WHEN @OrganizationObjectId IS NULL 			THEN 0
														WHEN @OrganizationObjectId > 0				THEN 1
														ELSE 0
													END


DECLARE @OrganizationNameCheck					int
SET		@OrganizationNameCheck					= CASE	WHEN LEN(@OrganizationName) IS NULL 		THEN 0
														WHEN LEN(@OrganizationName) = 0				THEN 0
														WHEN LEN(@OrganizationName) > 0				THEN 1
													END													
													
													
													
DECLARE @OrganizationNameLookupCheck			int
SET		@OrganizationNameLookupCheck			= CASE	WHEN @OrganizationNameLookup = 1			THEN 1							ELSE 0		END



DECLARE @deliveryEmailCheck					int
SET		@deliveryEmailCheck					= CASE	WHEN @deliveryEmail IS NULL 	THEN 0
													WHEN LEN(@deliveryEmail) = 0	THEN 0
													WHEN LEN(@deliveryEmail) > 0	THEN 1
												END


DECLARE @LocaleKey01Check					int
SET		@LocaleKey01Check					= CASE	WHEN LEN(@LocaleKey01) IS NULL 				THEN 0
														WHEN LEN(@LocaleKey01) = 0				THEN 0
														WHEN LEN(@LocaleKey01) > 0				THEN 1
													END													

													
DECLARE @LocaleKey02Check					int
SET		@LocaleKey02Check					= CASE	WHEN LEN(@LocaleKey02) IS NULL 				THEN 0
														WHEN LEN(@LocaleKey02) = 0				THEN 0
														WHEN LEN(@LocaleKey02) > 0				THEN 1
													END													

													

-- Used for raise error														
DECLARE @message								nvarchar(200)
													
													
													
													




-- Displays Info 
IF @DisplayInfoCheck = 1
BEGIN

	PRINT N' '
	PRINT N' '	
	PRINT N'-- Processing, Variables & Inputs '
	PRINT N' '
	PRINT N'EXEC dbo.sp_TranslationsExport_AutoDelivery'
	PRINT N'	@DisplayInfo			    = 0'
	PRINT N'    , @ShowChecks				= 0'
	PRINT N'    , @TableColumnList	        = 0'		
	PRINT N'    , @OrganizationObjectId     = 439'	
	PRINT N'	, @DeliveryEmail            = ''tpeterson@InMoment.com'''
	PRINT N'	, @LocaleKey01              = ''en_US'''
	PRINT N'	, @LocaleKey02              = ''fr_CA'''
	
	PRINT N' '
	PRINT N' '
	PRINT N' '
	PRINT N' '
	PRINT N' '	
	PRINT N'-- Looking Up An Orgainzation'
	PRINT N' '
	PRINT N'EXEC dbo.sp_TranslationsExport_AutoDelivery'
	PRINT N'	@DisplayInfo			    = 0'
	PRINT N'    , @ShowChecks				= 0'
	PRINT N'    , @TableColumnList	        = 0'
	PRINT N'    , @OrganizationNameLookup   = 1'	
	PRINT N'    , @OrganizationName			= ''Giant Tiger'''	
	PRINT N' '
	PRINT N' '
	PRINT N' '
	PRINT N' '
	


	RETURN

	
END
													


													
-- Enables input checking
IF @ShowChecksCheck = 1
BEGIN
	SELECT 
			@ShowChecks							AS ShowChecks
			, @ShowChecksCheck					AS ShowChecksCheck
			, @OrganizationObjectId				AS OrganizationObjectId
			, @OrganizationObjectIdCheck		AS OrganizationObjectIdCheck
			, @OrganizationName					AS OrganizationName
			, @OrganizationNameCheck			AS OrganizationNameCheck
			, @DeliveryEmailCheck				AS DeliveryEmailCheck
			, @DeliveryEmail					AS DeliveryEmail
			, @LocaleKey01Check					AS LocaleKey01Check
			, @LocaleKey01						AS LocaleKey01
			, @LocaleKey02Check					AS LocaleKey02Check
			, @LocaleKey02						AS LocaleKey02
			
			
			
			
END





-- Lookup checking	
IF @OrganizationNameLookupCheck = 1 AND @OrganizationNameCheck = 0
BEGIN

		SET @message = 'No organization name present to do the look up with.'
		RAISERROR (@message,0,1) with NOWAIT

		RETURN
	

END



-- Lookup checking	
IF @OrganizationNameLookupCheck = 0 AND @OrganizationNameCheck = 1
BEGIN

		SET @message = 'Organization name is present but the lookup flag is not set.'
		RAISERROR (@message,0,1) with NOWAIT

		RETURN
	

END

		
	
-- Lookup checking	
IF @OrganizationNameLookupCheck = 1 AND @OrganizationNameCheck = 1
BEGIN

		SET @message = 'Looking up Organization id and name.'
		RAISERROR (@message,0,1) with NOWAIT


		SELECT
				ObjectId	AS OrgId
				, Name		AS OrgName

		FROM
				Organization
		WHERE
				Name LIKE '%' + @OrganizationName + '%'



		RETURN
	

END



-- Show Tables and Columns that will be in looked up
IF @TableColumnList = 1
BEGIN

		SET @message = 'Tables and Columns that will be used during looked up.  It is hard coded so you may want to verify tables are in the code.'
		RAISERROR (@message,0,1) with NOWAIT

		
		SET @message = 'SP_HelpText ''sp_TranslationsExport_AutoDelivery'''
		RAISERROR (@message,0,1) with NOWAIT

		
		-- List all fields in database with these column names
		SELECT
				DISTINCT
				table_name
				, column_name
				
				--, *
				
		FROM
				information_schema.columns

		WHERE
				(
					-- Find these columns
						column_name LIKE '%labelObjectId%'
					OR
						column_name LIKE '%nameObjectId%'
					OR
						column_name LIKE '%contentObjectId%'
					OR
						column_name LIKE '%descriptionObjectId%'
					OR
						column_name LIKE '%textObjectId%'
					OR
						column_name LIKE '%labelId%'
					OR
						column_name LIKE '%descriptionId%'
						
				)
					
			-- Excludes these tables		
			AND
				table_name NOT LIKE '%syncobj%'
			AND
				table_name NOT LIKE '%_tmpbob%'
			AND
				table_name NOT LIKE '%feedbackchannelbak%'
			AND
				table_name NOT LIKE '%OntarioMTSRS%'
			AND
				table_name NOT LIKE '%STA_SurveyResponseAnswer%'
			AND
				table_name NOT LIKE '%v_surveys%'
			AND
				table_name NOT LIKE '%datafieldoptionbak%'
			AND
				table_name NOT LIKE '%view'
			AND
				table_name NOT LIKE 'TagViewSlow'
	

	
	RETURN
END









-- Processing
IF 	@OrganizationObjectIdCheck = 1
BEGIN
		-- Once complete move up to top
		DECLARE @orgId			int
		SET 	@orgId 			= @OrganizationObjectId  			--modify this


		--DECLARE @localeKey01	varchar(10)
		--DECLARE @localeKey02	varchar(10)

		--SET 	@localeKey01 	= 'en_US'
		--SET 	@localeKey02 	= 'fr_CA'		--modify this; swedish






		-- Processing
		DECLARE @dTT01 TABLE
			(
				RowId							int IDENTITY(1,1)
				, LocalizedStringObjectId		bigint
			)
			



			
		INSERT INTO @dTT01	( localizedStringObjectId )
		SELECT
				distinct labelObjectId
		FROM
				alert
		WHERE
				organizationObjectId = @orgId




		INSERT INTO @dTT01	( localizedStringObjectId )
		SELECT
				distinct contentObjectId
		FROM
				announcement
		WHERE
				organizationObjectId = @orgId


				

				
		INSERT INTO @dTT01	( localizedStringObjectId )
		SELECT
				distinct nameObjectId
		FROM
				announcement
		WHERE
				organizationObjectId = @orgId
				



				
		INSERT INTO @dTT01	( localizedStringObjectId )			
		SELECT
				DISTINCT descriptionId
		FROM
				Dashboard	
				
		WHERE
				organizationId = @OrgId			
				



				
		INSERT INTO @dTT01	( localizedStringObjectId )			
		SELECT
				DISTINCT labelId
		FROM
				Dashboard	
				
		WHERE
				organizationId = @OrgId			
				



				
		INSERT INTO @dTT01	( localizedStringObjectId )			
		SELECT
				DISTINCT t01.labelId
		FROM
				DashboardMap		t01
			JOIN
				Hierarchy			t02
					ON t01.HierarchyObjectId = t02.objectId
				
		WHERE
				t02.organizationObjectId = @orgId



				
			
		INSERT INTO @dTT01	( localizedStringObjectId )
		SELECT
				distinct labelObjectId	
		FROM
				dataField
		WHERE
				organizationObjectId = @orgId
				



				
		INSERT INTO @dTT01	( localizedStringObjectId )
		SELECT
				distinct textObjectId
		FROM
				dataField
		WHERE
				organizationObjectId = @orgId
				
			
			


		INSERT INTO @dTT01	( localizedStringObjectId )
		SELECT
				distinct t02.labelObjectId
		FROM
				dataField			t01
			JOIN
				dataFieldOption		t02
						ON t01.objectId = t02.dataFieldObjectId
				
		WHERE
				t01.organizationObjectId = @orgId


				

				
		INSERT INTO @dTT01	( localizedStringObjectId )
		SELECT
				distinct labelObjectId
		FROM
				feedbackChannel
		WHERE
				organizationObjectId = @orgId
				
				
				
				
		INSERT INTO @dTT01	( localizedStringObjectId )
		SELECT
				distinct t01.labelObjectId
		FROM
				FeedbackChannelType		t01
			JOIN
				FeedbackChannel			t02
						ON t01.objectId = t02.feedbackChannelTypeObjectId
		WHERE
				t02.organizationObjectId = @orgId





		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct descriptionObjectId
		FROM
				folder
		WHERE
				organizationObjectId = @orgId		
				

				
				
				
		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct nameObjectId
		FROM
				folder
		WHERE
				organizationObjectId = @orgId		





		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct nameObjectId
		FROM
				locationAttribute
		WHERE
				organizationObjectId = @orgId




		/*
		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct nameObjectId
		FROM
				offerAttribute
		WHERE
				organizationObjectId = @orgId
		*/




		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct reviewResponseTextObjectId
		FROM
				Organization
		WHERE
				ObjectId = @orgId


				
				

		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct labelObjectId
		FROM
				OrganizationMetadata
				
				
			
				
		INSERT INTO @dTT01	( localizedStringObjectId )				
		SELECT
				distinct descriptionObjectId
		FROM
				page
		WHERE
				organizationObjectId = @orgId
				
				
			
				
		INSERT INTO @dTT01	( localizedStringObjectId )				
		SELECT
				distinct editableContentObjectId
		FROM
				page
		WHERE
				organizationObjectId = @orgId


				

		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct nameObjectId
		FROM
				page
		WHERE
				organizationObjectId = @orgId
				
				

				
		INSERT INTO @dtt01 ( localizedStringObjectId )
		SELECT
				DISTINCT
				t30.LabelObjectId
		FROM
				page				t10		
			JOIN
				pageCriteriaSet		t20
					ON t10.objectId = t20.pageObjectId
			JOIN
				pageCriterion		t30
					ON t20.pageCriterionObjectId = t30.objectId	
		WHERE
				t10.OrganizationObjectId = @orgId


				

		INSERT INTO @dTT01	( localizedStringObjectId )						
		SELECT
				distinct t01.labelObjectId
		FROM
				pageCriterion		t01
			JOIN
				dataField			t02
						ON t01.dataFieldObjectId = t02.objectId
		WHERE
				t02.organizationObjectId = @orgId


				
		INSERT INTO @dTT01	( localizedStringObjectId )										
		SELECT
				DISTINCT 
				t40.labelObjectId
		FROM
				page				t10		
			JOIN
				pageCriteriaSet		t20
					ON t10.objectId = t20.pageObjectId
			JOIN
				pageCriterion		t30
					ON t20.pageCriterionObjectId = t30.objectId	
			LEFT JOIN
				DataField			t40
					ON t30.dataFieldObjectId = t40.objectId
		WHERE
				t10.OrganizationObjectId = @orgId
				
				


				
		INSERT INTO @dTT01	( localizedStringObjectId )										
		SELECT
				DISTINCT 
				t40.TextObjectId
		FROM
				page				t10		
			JOIN
				pageCriteriaSet		t20
					ON t10.objectId = t20.pageObjectId
			JOIN
				pageCriterion		t30
					ON t20.pageCriterionObjectId = t30.objectId	
			LEFT JOIN
				DataField			t40
					ON t30.dataFieldObjectId = t40.objectId
		WHERE
				t10.OrganizationObjectId = @orgId
				
				
				
				
				
				
				
				
				

		INSERT INTO @dTT01	( localizedStringObjectId )								
		SELECT
				distinct nameObjectId
		FROM
				period		
		WHERE
				organizationObjectId = @orgId
				



		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct t03.labelObjectId
		FROM
				Period				t01
			JOIN
				PeriodType			t02
						ON t01.periodTypeObjectId = t02.objectId		
			JOIN
				PeriodRange			t03
						ON t02.objectId = t03.periodTypeObjectId
		WHERE
				t01.organizationObjectId = @orgId




				
		INSERT INTO @dTT01	( localizedStringObjectId )								
		SELECT
				distinct t02.labelObjectId
		FROM
				period			t01
			JOIN
				periodType		t02
						ON t01.periodTypeObjectId = t02.objectId
		WHERE
				t01.organizationObjectId = @orgId





		INSERT INTO @dTT01	( localizedStringObjectId )								
		SELECT
				distinct t01.benchmarkLabelObjectId
		FROM
				ReportBenchmark			t01
			JOIN
				LocationCategoryType	t02
					ON t01.benchmarkLocationCategoryTypeObjectId = t02.objectId
		WHERE
				t02.organizationObjectId = @orgId
				


				
				
		INSERT INTO @dTT01	( localizedStringObjectId )								
		SELECT
				distinct t01.labelObjectId
		FROM
				reportColumn	t01
			JOIN
				dataField		t02
						ON t01.dataFieldObjectId = t02.objectId
		WHERE
				t02.organizationObjectId = @orgId


				
				
		INSERT INTO @dTT01	( localizedStringObjectId )								
		SELECT
				distinct t01.labelId
		FROM
				ReportHierarchyMap	t01
			JOIN
				Hierarchy			t02
					ON t01.HierarchyObjectId = t02.objectId
				
		WHERE
				t02.organizationObjectId = @orgId


				
				
		INSERT INTO @dTT01	( localizedStringObjectId )								
		SELECT
				distinct t03.labelObjectId
		FROM
				ReportHierarchyMap			t01
			JOIN
				Hierarchy					t02
					ON t01.HierarchyObjectId = t02.objectId
			JOIN	
				ReportHierarchyMapLabel		t03
					ON t01.objectId = t03.reportHierarchyMapObjectId
		WHERE
				t02.organizationObjectId = @orgId
					


				
		INSERT INTO @dTT01	( localizedStringObjectId )
		SELECT
				distinct contentObjectId
		FROM
				socialMedia		
		WHERE
				organizationObjectId = @orgId
				
				
				
				
				
		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct labelObjectId
		FROM
				tag			
		WHERE
				organizationObjectId = @orgId

				
				

				
		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct nameObjectId
		FROM
				tag			
		WHERE
				organizationObjectId = @orgId
				
				
				
				
				
		INSERT INTO @dTT01	( localizedStringObjectId )				
		SELECT
				distinct labelObjectId
		FROM
				tagCategory			
		WHERE
				organizationObjectId = @orgId
				
				
				

				
		INSERT INTO @dTT01	( localizedStringObjectId )		
		SELECT
				distinct nameObjectId
		FROM
				tagCategory			
		WHERE
				organizationObjectId = @orgId
						
				
				

				
		INSERT INTO @dTT01	( localizedStringObjectId )			
		SELECT
				DISTINCT ptdLabelObjectId
		FROM
				UpliftModel	
				
		WHERE
				organizationObjectId = @orgId
				
				
				

		-- Removes all items that have already been translated
		DELETE
				t10
		FROM
				@dTT01		t10
		WHERE
				LocalizedStringObjectId IN (
												SELECT
														t10.LocalizedStringObjectId
												FROM
														@dTT01					t10
													JOIN
														localizedStringValue	t20
															ON t10.LocalizedStringObjectId = t20.LocalizedStringObjectId
												WHERE
														LocaleKey = @LocaleKey02
											)
													
			
				


				
		--SELECT * 	FROM @dTT01
		--SELECT distinct localizedStringObjectId		FROM @dTT01


		IF OBJECT_ID('tempdb..##translationExport_Results01') IS NOT NULL			DROP TABLE ##translationExport_Results01		
		SELECT	
				localizedStringObjectId
				, LocaleKey
				, value
		INTO ##translationExport_Results01	
		FROM
				localizedStringValue
				
		WHERE
				localizedStringObjectId IN ( SELECT localizedStringObjectId		FROM @dTT01 )
			AND
				localeKey = @localeKey01
				
			--AND
			--	localeKey != @localeKey02
			
			AND
				value NOT LIKE '%/%/%'
			AND
				value NOT LIKE '[0-9]'	
				



		-- Removes any non localeKey01 left overs
		DELETE
				t10
		FROM
				##translationExport_Results01	t10
		WHERE
				LocaleKey != @LocaleKey01 





				
				
		IF OBJECT_ID('tempdb..##translationExport_Results02') IS NOT NULL			DROP TABLE ##translationExport_Results02				
		SELECT
				DISTINCT Value
		INTO ##translationExport_Results02		
		FROM
				##translationExport_Results01



		
END




-- Testing
--SELECT *				FROM ##translationExport_Results01				
--SELECT DISTINCT Value	FROM ##translationExport_Results02		
		
		


		
		
		
PROCESS_COMPLETE:

DECLARE @OrgName					varchar(100)	
SET		@OrgName					= ( SELECT Name FROM Organization WHERE objectId = @OrganizationObjectId )	
	
		
DECLARE @FileNameCompletedV1		varchar(100)

SET 	@FileNameCompletedV1		= ( SELECT CONVERT(char(8), GETDATE(), 112) + '_' + @OrgName + '_CompanyTranslationExport_InMomentLink.csv' ) 


		
-- Email Results & File
DECLARE @querySqlStatementV1		varchar(max)	
SET		@querySqlStatementV1		= 
										'
											SELECT
													LocalizedStringObjectId
													, LocaleKey
													, Value
											FROM 
													##translationExport_Results01
										'				
			
		
		
		
-- Send InMoment Link		
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @DeliveryEmail
, @copy_recipients 				= 'tpeterson@InMoment.com'	--; bluther@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'Company Translation Export InMoment Link'
, @body_format					= 'Text'
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= '|'
, @query_attachment_filename	= @FileNameCompletedV1
, @query_result_header 			= 1
, @execute_query_database		= 'Mindshare'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV1
, @body							=
'
Email 1 of 2

IMPORTANT

Please keep this document.  After you get the file back from the translator(s), you will
use this file in conjunction with the translated file to build a three column import file.

This file should be previewed for any abnormalities that currently exists in the database, 
such as a LocaleKey and corresponding Value being inconsistent.

Most people use VLOOKUP to build the following three columns.

- Example -
LocalizedStringObjectId     LocaleKey       TranslatedValue
280235                      es_MX           organización de casa
280236                      es_MX           artículos y muebles de baño
280237                      es_MX           decoración e iluminación


Please remove any unnecessary row(s) in the import file when you return it for uploading. Such as empty rows, 
dashed rows, and row count info.  Furthermore, every row must have a value present all three columns, if not
you will need to remove the row(s) in order to ensure successful processing.

The import file will need to be SAVE AS Type: Unicode Text ( *.txt ).  The adjustment can be 
found by the file name input box.

Please contact me if you need further assistance.

'
;

		


-- File 2 of 2 		
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + '_' +  @OrgName + '_CompanyTranslationExport_TranslatorPortion.csv' ) 


DECLARE @querySqlStatementV2		varchar(max)	
SET		@querySqlStatementV2		= 
										'
											SELECT
													Value
											FROM 
													##translationExport_Results02
										'				
		
		
		
		
-- Send InMoment Link	

EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @DeliveryEmail
, @copy_recipients 				= 'tpeterson@InMoment.com' --; bluther@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'Company Translation Export Translator Portion'
, @body_format					= 'Text'
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= '|'
, @query_attachment_filename	= @FileNameCompletedV2
, @query_result_header 			= 1
, @execute_query_database		= 'Mindshare'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV2
, @body							=

'
Email 2 of 2

Please send this file to the tranlators.  The file is a distinct list of all items
to be translated.

Please contact me if you need further assistance.

'
;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

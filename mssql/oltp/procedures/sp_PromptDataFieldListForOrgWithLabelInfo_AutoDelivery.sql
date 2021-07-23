SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[sp_PromptDataFieldListForOrgWithLabelInfo_AutoDelivery]
		@deliveryEmail	varchar(100)	= NULL
		, @orgId		int				= NULL

		
AS

/************** Prompt and Corresponding DataField Change  **************

	Provides a list of Prompts, PromptTypes, and their corresponding
	DataFields.
	
	Executed against OLTP and any Warehouse

	Note: Executing these SP without any parameters will
	print out requirements.
	
	sp_PromptDataFieldListForOrgWithLabelInfo_AutoDelivery	
		@DeliveryEmail	= ''''
		, @OrgId	= ''''
	
	History
		4.9.2014	Tad Peterson
			-- created as a need from Mike Chriss
	
************************************************************************/

SET NOCOUNT ON
													
DECLARE @deliveryEmailCheck			int
SET		@deliveryEmailCheck			= CASE	WHEN @deliveryEmail IS NULL 	THEN 0
											WHEN LEN(@deliveryEmail) = 0	THEN 0
											WHEN LEN(@deliveryEmail) > 0	THEN 1
										END
									

DECLARE @OrgIdCheck				int
SET		@OrgIdCheck				= CASE	WHEN LEN(@OrgId) IS NULL 			THEN 0
											WHEN LEN(@OrgId) = 0			THEN 0
											WHEN LEN(@OrgId) > 0			THEN 1
										END

										

-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0	
	AND 
		@OrgIdCheck				= 0	
			
	BEGIN
	
		PRINT 'Prompt and corresponding dataField list for an Org'
		PRINT CHAR(9) + 'Description: '
		PRINT CHAR(9) + CHAR(9) + 'Provides a list of Prompts, PromptTypes, and their corresponding info'
		PRINT CHAR(9) + CHAR(9) + 'based on a provided OrgId'
		PRINT ''
		PRINT ''
		PRINT 'Minimum Requirements:'
		PRINT CHAR(9) + 'Delivery email address ' 
		PRINT CHAR(9) + 'Org Id'
		PRINT ''
		PRINT ''
		PRINT 'To send the requestor a form to fill out, execute the following'
		PRINT ''
		PRINT CHAR(9) + 'sp_PromptDataFieldListForOrgWithLabelInfo_AutoDelivery'
		PRINT CHAR(9) + CHAR(9) + '@DeliveryEmail     = ''Their Email Here'''
		PRINT CHAR(9) + CHAR(9) + ', @OrgId           = ''Org Id Here'''
		
		
		
	RETURN
	END		




-- Sends Form to requestor; and requirements
IF		@deliveryEmailCheck		= 1	
	AND 
		@OrgIdCheck				= 0	
			
BEGIN
	PRINT 'Emailed form to ' + @deliveryEmail
	
EXEC msdb.dbo.sp_send_dbmail
@profile_name		= 'Internal Request'
, @recipients		= @deliveryEmail
, @reply_to			= 'dba@mshare.net'
, @subject			= 'Prompt and DataField List Form & Explanation'
, @body_format		= 'Text'
, @body				=
'
Notes & Comments
-----------------
	1. There is not a file setup with this request.
	2. The body of your return email should be like examples below.
	3. All that is needed is the OrgId.




Return Email
-------------

sp_PromptDataFieldListForOrgWithLabelInfo_AutoDelivery
	@DeliveryEmail	= ''your email address here''
	, @OrgId		= ''orgId here''
		

		
		
-- Example Below --

sp_PromptDataFieldListForOrgWithLabelInfo_AutoDelivery
	@DeliveryEmail	= ''tpeterson@mshare.net''
	, @OrgId		= ''749''
		

		
'		
	
RETURN	
END






-- Upload and Process Statistics
IF		@deliveryEmailCheck		= 1	
	AND 
		@OrgIdCheck				= 1
		
BEGIN

SET NOCOUNT ON 

DECLARE @OrgName					varchar(50)
DECLARE @OrgNameV2					varchar(50)

SET		@OrgName					= ( SELECT Name 	FROM Organization	WHERE ObjectId = @OrgId )
SET		@OrgNameV2					= ( SELECT REPLACE( @OrgName, ' ', '' )  )

DECLARE @processingStartV2			dateTime
SET 	@ProcessingStartV2			= ( SELECT GETDATE() )



-- Lists all Prompts and DataFields for a given Org.
IF OBJECT_ID('tempdb..##PromptDataFieldListForOrgWithLabelInfo') IS NOT NULL			DROP TABLE ##PromptDataFieldListForOrgWithLabelInfo
SELECT
		t10.objectId								AS PromptId
		, REPLACE(t10.name, ',', '' )				AS PromptName
		, REPLACE(t30.Value, ',', '' )				AS ReportName
			
		
		, CASE	WHEN t10.promptType = 0		THEN 'Read Only Prompt'
				WHEN t10.promptType = 1		THEN 'Numeric Prompt'
				WHEN t10.promptType = 2		THEN 'Text Prompt'
				WHEN t10.promptType = 3		THEN 'Date Prompt'
				WHEN t10.promptType = 4		THEN 'Rating Prompt'
				WHEN t10.promptType = 5		THEN 'Comment Prompt'
				WHEN t10.promptType = 6		THEN 'Composite Text Prompt'
				WHEN t10.promptType = 7		THEN 'Logic Prompt'
				WHEN t10.promptType = 8		THEN 'Transfer Prompt'
				WHEN t10.promptType = 9		THEN 'Rating Group Prompt'
				WHEN t10.promptType = 10	THEN 'OfferCode Search Prompt'
				WHEN t10.promptType = 11	THEN 'Employee Selector Prompt'
				WHEN t10.promptType = 12	THEN '(unused) Prompt'
				WHEN t10.promptType = 13	THEN 'Time Prompt'
				WHEN t10.promptType = 14	THEN 'Boolean Prompt'
				WHEN t10.promptType = 15	THEN 'Boolean Group Prompt'
				WHEN t10.promptType = 16	THEN 'Multiple Choice Prompt'
				WHEN t10.promptType = 17	THEN 'Multiple Choice Group Prompt'
			END										AS PromptTypeDescription
		
		
		, t10.PromptType							AS PromptType

		, t20.objectId								AS DataFieldId		
		, REPLACE(t20.name, ',', '' )				AS DataFieldName
		, REPLACE(t40.Value, ',', '' )				AS DataFieldLabel
		
		, t20.FieldType
		, t20.SystemField							AS SystemFieldValue
		
		
INTO 	##PromptDataFieldListForOrgWithLabelInfo	
		
FROM
		Prompt		t10
	RIGHT JOIN
		DataField	t20
			ON t10.dataFieldObjectId = t20.objectId
	LEFT JOIN
		LocalizedStringValue	t30
			ON t10.ReportLabel = t30.localizedStringObjectId	
	LEFT JOIN
		LocalizedStringValue	t40
			ON t20.labelObjectId= t40.localizedStringObjectId	
			
			
			
			
				

WHERE
		t10.organizationObjectId = @OrgId
	OR
		t20.organizationObjectId = @OrgId
		
		
ORDER BY
		t10.objectId					


GOTO PROCESSING_COMPLETE

END






PROCESSING_COMPLETE:
IF		@deliveryEmailCheck		= 1	
	AND 
		@OrgIdCheck				= 1
		
BEGIN

SET NOCOUNT ON

PRINT 'Generating & Sending Results via Email'



DECLARE	@DeliveryEmailV2									varchar(100)
		, @serverNameV2										varchar(25)
		, @originalCountV2									int
		, @processingCompleteV2								dateTime

		, @Minutes											varchar(3)
		, @Seconds											varchar(3)		
		, @ProcessingDurationV2								varchar(25)
				
		

SET @deliveryEmailV2										= @deliveryEmail
SET @serverNameV2											= ( SELECT @@ServerName )
SET @originalCountV2										= ( SELECT COUNT(1)						FROM ##PromptDataFieldListForOrgWithLabelInfo )




SET @ProcessingCompleteV2		= ( SELECT GETDATE() )
		
SET 	@Minutes	= ( SELECT (DATEDIFF( ss, @ProcessingStartV2, @ProcessingCompleteV2 )) / 60		)
SET 	@Seconds	= ( SELECT (DATEDIFF( ss, @ProcessingStartV2, @ProcessingCompleteV2 )) % 60		) 




IF @Minutes < 10
	BEGIN
		SET @Minutes = '0' + @Minutes
	END

	
IF @Seconds < 10
	BEGIN
		SET @Seconds = '0' + @Seconds
	END

SET @ProcessingDurationV2 = 'Minutes ' + @Minutes + ' Seconds ' + @Seconds




		




-- Builds Final Email
IF OBJECT_ID('tempdb..##PromptDataFieldListForOrgWithLabelInfo_Results') IS NOT NULL	DROP TABLE ##PromptDataFieldListForOrgWithLabelInfo_Results
CREATE TABLE ##PromptDataFieldListForOrgWithLabelInfo_Results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)



INSERT INTO ##PromptDataFieldListForOrgWithLabelInfo_Results ( Item, Criteria )
SELECT 'Server Name'								, @serverNameV2
UNION ALL
SELECT 'Delivery Email'								, @deliveryEmailV2
UNION ALL
SELECT 'Org Name'									, @OrgName
UNION ALL
SELECT 'Org Id'										, CAST( @OrgId as varchar )
UNION ALL	
SELECT 'CSV File Row Count'							, REPLACE(CONVERT(varchar(20), (CAST( ISNULL( @originalCountV2 , 0)   										AS money)), 1), '.00', '')	
UNION ALL
SELECT 'Processing Complete'						, CONVERT(varchar, @ProcessingCompleteV2, 100)
UNION ALL
SELECT 'Processing Duration'						, @ProcessingDurationV2
		



DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @xmlV2   					nvarchar(Max)
DECLARE @bodyV2   					nvarchar(Max)
DECLARE @OrgIdCompletedV2			varchar(255)
DECLARE @subjectV2					varchar(255)

SET		@subjectV2				= ( SELECT 'Prompt PromptType DataField FieldType With Label Completed - Org ' + @OrgNameV2 + ' OrgId ' + CAST( @OrgId as varchar ) + '' )

SET 	@OrgIdCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'Prompt_PromptType_DataField_FieldType_With_Label_Org_' + @OrgNameV2 + '_OrgId_' + CAST( @OrgId as varchar ) + '.csv' ) 


		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
SELECT
		PromptId
		, PromptName
		, ReportName	
		
		, PromptTypeDescription
		, PromptType

		, DataFieldId
		, DataFieldName
		, DataFieldLabel
		
		, FieldType
		, SystemFieldValue
		
FROM
		##PromptDataFieldListForOrgWithLabelInfo
	
							'				



SET @xmlV2 = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##PromptDataFieldListForOrgWithLabelInfo_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @bodyV2 =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Prompt PromptType DataField FieldType Org List With Label
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @bodyV2 = @bodyV2 + @xmlV2 +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmailV2
--, @copy_recipients 				= 'tpeterson@mshare.net'
, @copy_recipients 				= 'tpeterson@mshare.net; bluther@mshare.net'
, @reply_to						= 'dba@mshare.net'
, @subject						= @subjectV2
, @body_format					= 'HTML'
, @body							= @bodyV2
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= '|'
, @query_attachment_filename	= @OrgIdCompletedV2
, @query_result_header 			= 1
, @execute_query_database		= 'oltp'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV2


		
		
		
PRINT 'Email has been sent'	

END

GOTO CLEANUP


	
CLEANUP:

	PRINT 'Cleaning up temp tables'




IF OBJECT_ID('tempdb..##PromptDataFieldListForOrgWithLabelInfo') IS NOT NULL			DROP TABLE ##PromptDataFieldListForOrgWithLabelInfo
IF OBJECT_ID('tempdb..##PromptDataFieldListForOrgWithLabelInfo_Results') IS NOT NULL	DROP TABLE ##PromptDataFieldListForOrgWithLabelInfo_Results

	PRINT 'Cleanup is complete'



	
-- For Debugging; Table by Table Verification	
--SELECT *	FROM ##PromptDataFieldListForOrgWithLabelInfo
--SELECT *	FROM ##PromptDataFieldListForOrgWithLabelInfo_Results

	
	
	
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

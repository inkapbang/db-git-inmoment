SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[UserAccountAndRoleFullList_SOC_Audit_bob]
	@DeliveryEmail		varchar(255)	= NULL
	, @ShowResults		char(1)			= NULL

AS

/*********************  Mindshare User Account And Role Full List  *********************


  Usage: 

      exec UserAccountAndRoleFullList_SOC_Audit @deliveryemail='MChriss@Inmoment.com'

	Comments
		Mike needs to pass off one of these
			Mindshare User Account And Role Full List ( this one )
			Mindshare User Role Full List

		Executes against OLTP


	History
		00.00.0000	Tad Peterson
			-- created
			
		06.11.2014 	Tad Peterson
			-- turned it into a stored procedure
			
		12.05.2014	Tad Peterson
			-- added/modified definitions
			
			
			
	-- Command To Process		
	EXEC dbo.UserAccountAndRoleFullList_SOC_Audit
		@DeliveryEmail = 'mChriss@InMoment.com; bLittle@InMoment.com;bluther@InMoment.com'
		--@DeliveryEmail = 'bluther@InMoment.com'
		--, @ShowResults   = 'Y'	


**************************************************************************************/
SET NOCOUNT ON

DECLARE @deliveryEmailCheck						int
SET		@deliveryEmailCheck						= CASE	WHEN @deliveryEmail IS NULL 	THEN 0
														WHEN LEN(@deliveryEmail) = 0	THEN 0
														WHEN LEN(@deliveryEmail) > 0	THEN 1
													END

IF	@deliveryEmailCheck = 0
BEGIN
	PRINT 'No email present.  Please provide a delivery email.'
	RETURN
END												

PROCESSING:

	PRINT N'Processing has started.'


-- Query
IF OBJECT_ID('tempdb..##UserAccountAndRoleFullList_SOC_Audit') IS NOT NULL			DROP TABLE ##UserAccountAndRoleFullList_SOC_Audit		
SELECT
		--TOP 100 *
		t10.LastName
		, t10.FirstName
		,t30.objectId OrganizationObjectid
		,t30.name OrganizationName
		, t10.Email
		, t10.LastLogin	
		, t20.Role
		, CASE t20.Role
				WHEN	1	THEN 'Sys Admin'
				WHEN	2	THEN 'Org Setup'
				WHEN	3	THEN 'Org Manager'
				WHEN	4	THEN 'SSO Bypass'
				WHEN	5	THEN 'Survey Editor'
				WHEN	6	THEN 'Report Editor'
				WHEN	7	THEN 'User Manager'
				WHEN	8	THEN 'User'
				WHEN	9	THEN 'Translator'
				WHEN	10	THEN 'Transcriber'
				WHEN	11	THEN 'Employee Manager'
				WHEN	12	THEN 'Customer Service Rep'
				WHEN	13	THEN 'Report Subscriber'
				WHEN	14	THEN 'Personal Data Viewer'
				WHEN	15	THEN 'Program Maintenance'
				WHEN	17	THEN 'Large Report RowCount'
				WHEN	18	THEN 'Tagger'
				WHEN	19	THEN 'Pilot'

				WHEN 	22 THEN 'Show Auto Transcriptions'
				WHEN 	23 THEN 'Review Reply'
				WHEN 	24 THEN 'Mindshare Employee Admin'
				WHEN 	25 THEN 'System Diagnostics'
				WHEN 	26 THEN 'Report Editor Advanced'
				WHEN 	27 THEN 'Score Recalc Runner'
				WHEN 	28 THEN 'Hierarchy Editor'
				WHEN 	29 THEN 'SSO Admin'
				WHEN 	30 THEN 'Text Analytics Admin'
				WHEN 	31 THEN 'Web Services Admin'
				WHEN 	32 THEN 'Client Diagnostics'
				WHEN 	33 THEN 'Plum Servers'
				WHEN 	34 THEN 'Report Run Enqueueing'
				WHEN 	35 THEN 'Social Admin'
				
				WHEN 	36 THEN 'Service Account'
				
				WHEN 	37 THEN 'Placeholder 1'
				WHEN 	38 THEN 'Placeholder 2'
				WHEN 	39 THEN 'Placeholder 3'
				
				WHEN 	100 THEN 'Web Services'
				
				WHEN	101	THEN 'Survey Data Export'
				WHEN	102	THEN 'Survey Data Import'
				WHEN	103	THEN 'Structure Export'
				WHEN	104	THEN 'Structure Import'
				WHEN	105	THEN 'Mindshare Desktop'
				WHEN	106	THEN 'Inbound Phone Survey'
				WHEN	107	THEN 'Inbound Web Survey'
				WHEN	108	THEN 'Outbound Phone Survey'
				WHEN	109	THEN 'Outbound Web Survey'
				WHEN	110	THEN 'Web Services'
				WHEN	111	THEN 'Unrestricted Survey Data'
				
				WHEN	112	THEN 'Web Service Unrestricted Survey Data'
				
				WHEN	114	THEN 'Advanced Theme Editor'
				
				
				
			END													AS [Role Description]
		, t10.Enabled
		, t10.Global
		, t10.MindshareEmployee									AS [InMomentEmployee]
		, t10.Locked
		, t30.name as [PasswordPolicyOrg]

INTO ##UserAccountAndRoleFullList_SOC_Audit		

		
FROM
		Mindshare.dbo.UserAccount				t10		
	JOIN
		Mindshare.dbo.UserAccountRole			t20		
			ON t10.objectId	= t20.userAccountObjectId
			
	LEFT JOIN
		Mindshare.dbo.Organization						t30		
			ON t10.passwordPolicyOrganizationObjectId = 	t30.ObjectId 	
	
	
WHERE
		t20.role IN 
					( 
						1, 2, 3, 5, 6, 15, 17, 22
						, 23, 24, 25, 26, 27, 28
						, 29, 30, 31, 32, 33, 34
						, 35, 36, 37, 38, 100, 111
					)
			
ORDER BY
		t10.Email
		, t10.LastName
		, t10.FirstName
		, t20.Role
		, t10.LastLogin	


	
-- Email building		
DECLARE @querySqlStatementV2		nvarchar(Max)											
DECLARE @FileNameCompletedV2		varchar(100)

SET 	@FileNameCompletedV2		= ( SELECT CONVERT(char(8), GETDATE(), 112) + 'UserAccountAndRoleFullList_SOC_Audit.csv' ) 



		
		-- Email Results & File	
SET @querySqlStatementV2		= 
							'
								SELECT
										[LastName]
										, [FirstName]
										, [Email]
										, [organizationObjectid]
										, [OrganizationName]
										, [LastLogin]	
										, [Role]
										, [Role Description]
										, [Enabled]
										, [Global]
										, [Locked]
										, [InMomentEmployee]
										, [PasswordPolicyOrg]
												
								FROM 
										##UserAccountAndRoleFullList_SOC_Audit
								
							'				
		
		
		
		
		
		
		
		
		
EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @DeliveryEmail
, @copy_recipients 				= 'tpeterson@InMoment.com'
--, @copy_recipients 				= 'tpeterson@InMoment.com'
, @reply_to						= 'dba@InMoment.com'
, @subject						= 'InMoment User Account And Role Full List SOC Audit'
, @body_format					= 'Text'
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= '|'
, @query_attachment_filename	= @FileNameCompletedV2
, @query_result_header 			= 1
, @execute_query_database		= 'Mindshare'
, @query_result_width 			= 32767
, @body							= 'Please review and notify IT with comments and concerns.  -- DBA Team'

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatementV2
		


PRINT 'Email has been sent'	


IF @ShowResults   = 'Y'
BEGIN
		SELECT
				*
		FROM
				##UserAccountAndRoleFullList_SOC_Audit	
END




GOTO CLEANUP



CLEANUP:

	PRINT 'Cleaning up temp tables'

	IF OBJECT_ID('tempdb..##UserAccountAndRoleFullList_SOC_Audit') IS NOT NULL			DROP TABLE ##UserAccountAndRoleFullList_SOC_Audit		
	
	
	
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

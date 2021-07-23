SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE Procedure sp_DropOutAnalysis_WithDataFieldAnswerTo_AutoDelivery
CREATE Procedure [dbo].[sp_DropOutAnalysis_WithDataFieldAnswerTo_AutoDelivery]
		@deliveryEmail	varchar(100)			= NULL
		, @OrgId				int				= NULL
		, @beginDate			dateTime		= NULL
		, @endDate				dateTime		= NULL
		, @surveyName			nvarchar(100)	= NULL
		, @surveyId				varchar(1000)	= NULL
		, @modeType				int				= NULL
		, @dataFieldAnswerTo	int				= NULL

AS

/**************  Drop Out Analysis Auto Delivery  **************

	To be executed against OLTP.


***************************************************************/
SET NOCOUNT ON

DECLARE @deliveryEmailCheck		int
SET		@deliveryEmailCheck		= CASE	WHEN @deliveryEmail IS NULL 	THEN 0
										WHEN LEN(@deliveryEmail) = 0	THEN 0
										WHEN LEN(@deliveryEmail) > 0	THEN 1
									END
									

DECLARE @OrgIdCheck				int
SET		@OrgIdCheck				= CASE	WHEN ISNULL(@OrgId, 0 ) IS NULL 	THEN 0
										WHEN ISNULL(@OrgId, 0 ) = 0			THEN 0
										WHEN ISNULL(@OrgId, 0 ) > 0			THEN 1
									END

									
DECLARE @beginDateCheck			int
SET		@beginDateCheck			= CASE	WHEN @beginDate IS NULL							THEN 0
										WHEN @beginDate = '1900-01-01 00:00:00.000'		THEN 0
										WHEN @beginDate > '1900-01-01 00:00:00.000'		THEN 1
									END

									
DECLARE @endDateCheck			int
SET		@endDateCheck			= CASE	WHEN @endDate IS NULL						THEN 0
										WHEN @endDate = '1900-01-01 00:00:00.000'	THEN 0
										WHEN @endDate > '1900-01-01 00:00:00.000'	THEN 1
									END


DECLARE @surveyNameCheck		int
SET		@surveyNameCheck		= CASE	WHEN @surveyName IS NULL	THEN 0
										WHEN LEN(@surveyName) = 0	THEN 0
										WHEN LEN(@surveyName) > 0	THEN 1
									END

									
DECLARE @surveyIdCheck			int
SET		@surveyIdCheck			= CASE	WHEN ISNULL(@surveyId, 0 ) IS NULL	THEN 0
										WHEN ISNULL(@surveyId, 0 ) = 0		THEN 0
										WHEN ISNULL(@surveyId, 0 ) > 0		THEN 1
									END
									

DECLARE @modeTypeCheck			int
SET		@modeTypeCheck			= CASE	WHEN ISNULL(@modeType, 0 ) IS NULL	THEN 0
										WHEN ISNULL(@modeType, 0 ) = 0		THEN 0
										WHEN ISNULL(@modeType, 0 ) > 0		THEN 1
									END

DECLARE @dataFieldAnswerToCheck			int
SET		@dataFieldAnswerToCheck			= CASE	WHEN ISNULL(@dataFieldAnswerTo, 0 ) IS NULL	THEN 0
												WHEN ISNULL(@dataFieldAnswerTo, 0 ) = 0		THEN 0
												WHEN ISNULL(@dataFieldAnswerTo, 0 ) > 0		THEN 1
											END


SET		@endDate				= CASE	WHEN @endDateCheck = 0	THEN DATEADD(dd,1,cast(floor(cast(getdate() as float))as datetime)) --tomorrow
										WHEN @endDateCheck = 1	THEN @endDate
									END	

						
DECLARE @FileName				varchar(100)
SET 	@FileName 				= 	cast(replace(convert(varchar(10),getdate(),120),'-','') as varchar) + 'dropoutAnalysis_OrgId_' + CAST(@OrgId as varchar) + '.csv'


DECLARE @querySqlStatement		nvarchar(Max)											
DECLARE @xml   					nvarchar(Max)
DECLARE @body   				nvarchar(Max)
						
						
						
-- Parameter Checking / Verification
--SELECT @deliveryEmailCheck AS Email, @OrgIdCheck AS OrgId, @beginDateCheck AS BeginDate, @surveyIdCheck AS surveyId, @surveyNameCheck AS SurveyName, @modeTypeCheck AS ModeType
--SELECT @endDate, @endDateCheck



-- Prints Out Requirements & Criteria
IF		@deliveryEmailCheck		= 0	
	AND 
		@OrgIdCheck				= 0	
	AND 
		@beginDateCheck			= 0	
			
	BEGIN
	
		PRINT 'Drop Out Analysis'  + CHAR(13) + CHAR(13) + 'Minimum Requirements:' + CHAR(13) + CHAR(9) + 'Delivery email address ' + CHAR(13) + CHAR(9) + 'Org Id' + CHAR(13) + CHAR(9) + 'Begin Date' + CHAR(13) + CHAR(9) + 'DataFieldId For Answer To Information'  + CHAR(13) + CHAR(13) + 'Optional Criteria:'  + CHAR(13) + CHAR(9) + 'End Date'  + CHAR(13) + CHAR(9) + 'Survey Name or Survey Id (preferably Id)' + CHAR(13) + CHAR(9) + 'Mode Type ( 1 = phone, 2 = web, 3 = import )'
		PRINT CHAR(13) + CHAR(13) + CHAR(13) + 'To send the requestor a form to fill out, execute the following'
		PRINT CHAR(9) + 'sp_DropOutAnalysis_WithDataFieldAnswerTo_AutoDelivery ''Their Email Here'''
		
	RETURN
	END		


IF		@deliveryEmailCheck		= 0	
	AND 
		(
				@OrgIdCheck				= 0
			OR
				@OrgIdCheck				= 1
		)	
	AND 
		(
				@beginDateCheck			= 0
			OR
				@beginDateCheck			= 1	
		)			
			
	BEGIN
		PRINT 'Email is required'		
	RETURN
	END		

	
	
-- Send an email to delivery for information
IF		@deliveryEmailCheck		= 1	
	AND 
		@OrgIdCheck				= 0	
	AND 
		@beginDateCheck			= 0		


BEGIN
	PRINT 'Emailed Form'
	
EXEC msdb.dbo.sp_send_dbmail
@profile_name		= 'Internal Request'
, @recipients		= @deliveryEmail
, @reply_to			= 'dba@mshare.net'
, @subject			= 'Drop Analysis Form & Explanation'
, @body_format		= 'Text'
, @body				=
'
Please fill out and return to DBAs for processing.


sp_DropOutAnalysis_WithDataFieldAnswerTo_AutoDelivery
	-- required
		@deliveryEmail	      = ''your email address here''
		, @OrgId		      = ''organization id here''
		, @beginDate	      = ''starting date here''
		, @dataFieldAnswerTo    = ''dataField id for answer to info''
		
	-- optional	
		, @endDate		      = NULL
		, @surveyName	      = NULL
		, @surveyId		      = NULL
		, @modeType		      = NULL
		




		
		
		
-- Example Below --

sp_DropOutAnalysis_WithDataFieldAnswerTo_AutoDelivery
	-- required
		@deliveryEmail	     = ''tpeterson@mshare.net''
		, @OrgId		     = ''777''
		, @beginDate	     = ''1/1/2012''
		, @dataFieldAnswerTo   = ''14392''
		
	-- optional
		, @endDate		     = ''2/1/2012''
		, @surveyName	     = NULL
		, @surveyId		     = ''4246''
		


Notes & Comments
-----------------
	All entries must be inside single quotes '''', except NULLs
		
	Survey Id is preferred to Survey Name, if using this optional criteria
	Mode Type ( 1 = phone, 2 = web, 3 = import )

	DataFieldIdAnswerTo is used when you want to know how they answered
	a specific question earlier in the survey.
		
'		
	
	
RETURN	
END




------------------   Place remaining Stored Procedure Here   -------------------------
-- Missing Begin Date Parameter
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 0
			
BEGIN
	PRINT 'Begin Date parameter required'
RETURN	
END


-- Missing Org Id Parameter
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 0		
	AND
		@beginDateCheck		= 1

BEGIN
	PRINT 'Org Id parameter required'
RETURN	
END


-- Missing Answer TO Parameter
IF		@deliveryEmailCheck			= 1
	AND
		@OrgIdCheck					= 1	
	AND
		@beginDateCheck				= 1
	AND
		@dataFieldAnswerToCheck 	= 0

BEGIN
	PRINT 'DataFieldAnswerTo parameter required'
RETURN	
END


-- When "required" are present run the drop out analysis
IF		@deliveryEmailCheck			= 1
	AND
		@OrgIdCheck					= 1		
	AND
		@beginDateCheck				= 1
	AND
		@dataFieldAnswerToCheck  	= 1

BEGIN
	PRINT 'Query has been generated'
	
	
	IF OBJECT_ID('tempdb..##dropOutAnalysis_01') IS NOT NULL	DROP TABLE ##dropOutAnalysis_01
	SELECT 
			DISTINCT sr.objectId
			, l.name 										AS location
			, s.objectId 									AS surveyObjectId
			, s.name
			, sr.surveyGatewayObjectId			
			, complete
			, sr.modeType
			, sr.beginDate
			, substring(cast(sr.begintime as varchar),12,9) AS beginTime
			, sr.minutes
			, sr.ani
			, offercode
			, o.name 										AS offerName

	INTO ##dropOutAnalysis_01
	FROM 
			location l										WITH (NOLOCK)
		JOIN 
			surveyresponse sr								WITH (NOLOCK)
					ON l.objectid = sr.locationobjectid
		JOIN 
			survey s										WITH (NOLOCK)
					ON s.objectid = sr.surveyobjectid
		JOIN 
			offer o											WITH (NOLOCK)
					ON o.objectid = sr.offerobjectid
	WHERE 
			l.organizationobjectid = @orgId
		AND 
			sr.beginDate BETWEEN 	@beginDate 
							AND 	@endDate 
		AND 
			complete = 0
		AND 
			exclusionReason = 0
			


		
		
		
	IF OBJECT_ID('tempdb..##dropOutAnalysis_02') IS NOT NULL	DROP TABLE ##dropOutAnalysis_02
	SELECT
			sra.surveyResponseObjectId
			, sra.objectId
			, df.name
			, sra.sequence, rank() over(partition by sra.surveyResponseObjectId order by sra.sequence desc) 		AS rowNumber
			, sra.dataFieldObjectId
			, sra.dataFieldOptionObjectId

	INTO ##dropOutAnalysis_02
	FROM 
			surveyResponseAnswer sra 				WITH (NOLOCK)
		JOIN 
			dataField df
					ON df.objectId=sra.dataFieldObjectId
	WHERE sra.surveyResponseObjectId IN 
										(
											SELECT objectid 
											FROM ##dropOutAnalysis_01
										)


	IF OBJECT_ID('tempdb..##dropOutAnalysis_03') IS NOT NULL	DROP TABLE ##dropOutAnalysis_03
	SELECT 
			a.objectId 
			, location
			, surveyObjectId
			, surveyName
			, surveyGatewayObjectId						
			, modeType
			, beginDate
			, beginTime
			, minutes
			, ani
			, offerCode
			, offerName
			, coalesce(b.name,'No Answers') 		AS promptName
			, dataFieldObjectId
			, c.name 								AS answer
			, isnull(questionNumber,0) 				AS questionNumber

	INTO ##dropOutAnalysis_03	
	FROM 
			(
				SELECT 
					objectid
					, name 								AS surveyName
					, surveyObjectId
					, surveyGatewayObjectId			
					, location
					, modeType
					, beginDate 						AS beginDate
					, beginTime
					, minutes
					, ani
					, offerCode
					, offerName
				FROM ##dropOutAnalysis_01
			)as a
		LEFT JOIN
			(
				SELECT 
					surveyResponseObjectid
					, name
					, sequence+1 					AS questionNumber
					, dataFieldObjectId
					, dataFieldOptionObjectId
				FROM ##dropOutAnalysis_02 
				WHERE rowNumber = 1
			)as b 
				ON a.objectId=b.surveyResponseObjectId
		JOIN
			(
				SELECT
					objectId
					, name
				FROM dataFieldOption
			) as c 
				ON b.dataFieldOptionObjectId=c.objectId
			
	ORDER BY surveyName, location






-- Builds Final Temp Table
IF OBJECT_ID('tempdb..##dropOutAnalysis_ResultSet') IS NOT NULL	DROP TABLE ##dropOutAnalysis_ResultSet
CREATE TABLE ##dropOutAnalysis_ResultSet
	(
		SurveyResponseObjectId			bigInt
		, SurveyObjectId				int
		, surveyGatewayObjectId			int		
		, ModeType						int
		, Location						varchar(max)
		, SurveyName					nvarchar(max)
		, BeginDate						dateTime
		, BeginTime						dateTime
		, Minutes						float
		, Ani							varchar(max)
		, OfferCode						varchar(max)
		, OfferName						varchar(max)
		, PromptName					varchar(max)
		, DataFieldObjectId				int
		, Answer						varchar(max)
		, QuestionNumber				int
		, DataFieldIdAnswerTo			int
		, DataFieldOptioinIdAnswerTo	int
		, AnswerTo						varchar(max)
	)

	
END






--Optional @endDate, will automatically be present from CASE statement at beginning.


--No options present
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 1
	AND
				@surveyIdCheck		= 0
	AND
				@surveyNameCheck	= 0
	AND
				@modeTypeCheck		= 0
			
	BEGIN
		PRINT 'No Additonal Options'
		
		INSERT INTO ##dropOutAnalysis_ResultSet
		SELECT 
				t10.objectId								AS SurveyResponseObjectId
				, t10.SurveyObjectId
				, t10.SurveyGatewayObjectId	
				, t10.ModeType
				, REPLACE( t10.Location		, ',', '' )		AS Location
				, REPLACE( t10.SurveyName	, ',', '' )		AS SurveyName
				, t10.BeginDate
				, t10.BeginTime
				, t10.Minutes
				, t10.Ani
				, REPLACE( t10.OfferCode	, ',', '' )		AS OfferCode	
				, REPLACE( t10.OfferName	, ',', '' )		AS OfferName
				, REPLACE( t10.PromptName	, ',', '' )		AS PromptName
				, t10.DataFieldObjectId
				, REPLACE( t10.Answer		, ',', '' )		AS Answer
				, t10.QuestionNumber
				, t20.dataFieldObjectId						AS DataFieldIdAnswerTo	
				, t20.dataFieldOptionObjectId				AS DataFieldOptioinIdAnswerTo
				, REPLACE( t20.name		, ',', '' )			AS AnswerTo		
				
		FROM 
				##dropOutAnalysis_03	t10
			LEFT JOIN
				(
						SELECT
								 sra.surveyResponseObjectId, sra.dataFieldObjectId, sra.dataFieldOptionObjectId, dfo.name

						FROM
								surveyResponseAnswer		sra
							JOIN
								dataFieldOption				dfo 
										ON sra.dataFieldOptionObjectId = dfo.objectId
						WHERE 
								surveyResponseObjectId IN ( SELECT objectId FROM ##dropOutAnalysis_03 )
							AND 
								sra.dataFieldObjectId = @dataFieldAnswerTo
				)	AS t20
						ON t10. objectId = t20.surveyResponseObjectId


				
	GOTO CLEANUP
	END





--Optional surveyId, present
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 1
	AND
				@surveyIdCheck		= 1
	AND
		(		
				@surveyNameCheck	= 0
			OR
				@surveyNameCheck	= 1
		)		
	AND
				@modeTypeCheck		= 0
			
	BEGIN
		PRINT 'Includes survey Id'
		
		INSERT INTO ##dropOutAnalysis_ResultSet
		SELECT 
				t10.objectId								AS SurveyResponseObjectId
				, t10.SurveyObjectId
				, t10.SurveyGatewayObjectId	
				, t10.ModeType
				, REPLACE( t10.Location		, ',', '' )		AS Location
				, REPLACE( t10.SurveyName	, ',', '' )		AS SurveyName
				, t10.BeginDate
				, t10.BeginTime
				, t10.Minutes
				, t10.Ani
				, REPLACE( t10.OfferCode	, ',', '' )		AS OfferCode	
				, REPLACE( t10.OfferName	, ',', '' )		AS OfferName
				, REPLACE( t10.PromptName	, ',', '' )		AS PromptName
				, t10.DataFieldObjectId
				, REPLACE( t10.Answer		, ',', '' )		AS Answer
				, t10.QuestionNumber
				, t20.dataFieldObjectId						AS DataFieldIdAnswerTo	
				, t20.dataFieldOptionObjectId				AS DataFieldOptioinIdAnswerTo
				, REPLACE( t20.name		, ',', '' )			AS AnswerTo		
				
		FROM 
				##dropOutAnalysis_03	t10
			LEFT JOIN
				(
						SELECT
								 sra.surveyResponseObjectId, sra.dataFieldObjectId, sra.dataFieldOptionObjectId, dfo.name

						FROM
								surveyResponseAnswer		sra
							JOIN
								dataFieldOption				dfo 
										ON sra.dataFieldOptionObjectId = dfo.objectId
						WHERE 
								surveyResponseObjectId IN ( SELECT objectId FROM ##dropOutAnalysis_03 )
							AND 
								sra.dataFieldObjectId = @dataFieldAnswerTo
				)	AS t20
						ON t10. objectId = t20.surveyResponseObjectId
		WHERE
				SurveyObjectId = @surveyId	
				
	GOTO CLEANUP
	END




--Optional Survey Name, present
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 1
	AND
				@surveyIdCheck		= 0
	AND
				@surveyNameCheck	= 1
	AND
				@modeTypeCheck		= 0
				
	BEGIN
		PRINT 'Includes SurveyName'
		
		INSERT INTO ##dropOutAnalysis_ResultSet
		SELECT 
				t10.objectId								AS SurveyResponseObjectId
				, t10.SurveyObjectId
				, t10.SurveyGatewayObjectId	
				, t10.ModeType
				, REPLACE( t10.Location		, ',', '' )		AS Location
				, REPLACE( t10.SurveyName	, ',', '' )		AS SurveyName
				, t10.BeginDate
				, t10.BeginTime
				, t10.Minutes
				, t10.Ani
				, REPLACE( t10.OfferCode	, ',', '' )		AS OfferCode	
				, REPLACE( t10.OfferName	, ',', '' )		AS OfferName
				, REPLACE( t10.PromptName	, ',', '' )		AS PromptName
				, t10.DataFieldObjectId
				, REPLACE( t10.Answer		, ',', '' )		AS Answer
				, t10.QuestionNumber
				, t20.dataFieldObjectId						AS DataFieldIdAnswerTo	
				, t20.dataFieldOptionObjectId				AS DataFieldOptioinIdAnswerTo
				, REPLACE( t20.name		, ',', '' )			AS AnswerTo		
				
		FROM 
				##dropOutAnalysis_03	t10
			LEFT JOIN
				(
						SELECT
								 sra.surveyResponseObjectId, sra.dataFieldObjectId, sra.dataFieldOptionObjectId, dfo.name

						FROM
								surveyResponseAnswer		sra
							JOIN
								dataFieldOption				dfo 
										ON sra.dataFieldOptionObjectId = dfo.objectId
						WHERE 
								surveyResponseObjectId IN ( SELECT objectId FROM ##dropOutAnalysis_03 )
							AND 
								sra.dataFieldObjectId = @dataFieldAnswerTo
				)	AS t20
						ON t10. objectId = t20.surveyResponseObjectId
		WHERE
				SurveyName = @surveyName	
				
		
	GOTO CLEANUP
	END



--Optional ModeType, present
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 1
	AND
				@surveyIdCheck		= 0
	AND
				@surveyNameCheck	= 0
	AND
				@modeTypeCheck		= 1
				
	BEGIN
		PRINT 'Includes ModeType'
		
		INSERT INTO ##dropOutAnalysis_ResultSet
		SELECT 
				t10.objectId								AS SurveyResponseObjectId
				, t10.SurveyObjectId
				, t10.SurveyGatewayObjectId	
				, t10.ModeType
				, REPLACE( t10.Location		, ',', '' )		AS Location
				, REPLACE( t10.SurveyName	, ',', '' )		AS SurveyName
				, t10.BeginDate
				, t10.BeginTime
				, t10.Minutes
				, t10.Ani
				, REPLACE( t10.OfferCode	, ',', '' )		AS OfferCode	
				, REPLACE( t10.OfferName	, ',', '' )		AS OfferName
				, REPLACE( t10.PromptName	, ',', '' )		AS PromptName
				, t10.DataFieldObjectId
				, REPLACE( t10.Answer		, ',', '' )		AS Answer
				, t10.QuestionNumber
				, t20.dataFieldObjectId						AS DataFieldIdAnswerTo	
				, t20.dataFieldOptionObjectId				AS DataFieldOptioinIdAnswerTo
				, REPLACE( t20.name		, ',', '' )			AS AnswerTo		
				
		FROM 
				##dropOutAnalysis_03	t10
			LEFT JOIN
				(
						SELECT
								 sra.surveyResponseObjectId, sra.dataFieldObjectId, sra.dataFieldOptionObjectId, dfo.name

						FROM
								surveyResponseAnswer		sra
							JOIN
								dataFieldOption				dfo 
										ON sra.dataFieldOptionObjectId = dfo.objectId
						WHERE 
								surveyResponseObjectId IN ( SELECT objectId FROM ##dropOutAnalysis_03 )
							AND 
								sra.dataFieldObjectId = @dataFieldAnswerTo
				)	AS t20
						ON t10. objectId = t20.surveyResponseObjectId
		WHERE
				modeType = @modeType	
						
		
		
	GOTO CLEANUP
	END


--Optional surveyId & ModeType, present
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 1
	AND
				@surveyIdCheck		= 1
	AND
		(		
				@surveyNameCheck	= 0
			OR
				@surveyNameCheck	= 1
		)		
	AND
				@modeTypeCheck		= 1
				
	BEGIN
		PRINT 'Includes SurveyId & ModeType'
		
		INSERT INTO ##dropOutAnalysis_ResultSet
		SELECT 
				t10.objectId								AS SurveyResponseObjectId
				, t10.SurveyObjectId
				, t10.SurveyGatewayObjectId	
				, t10.ModeType
				, REPLACE( t10.Location		, ',', '' )		AS Location
				, REPLACE( t10.SurveyName	, ',', '' )		AS SurveyName
				, t10.BeginDate
				, t10.BeginTime
				, t10.Minutes
				, t10.Ani
				, REPLACE( t10.OfferCode	, ',', '' )		AS OfferCode	
				, REPLACE( t10.OfferName	, ',', '' )		AS OfferName
				, REPLACE( t10.PromptName	, ',', '' )		AS PromptName
				, t10.DataFieldObjectId
				, REPLACE( t10.Answer		, ',', '' )		AS Answer
				, t10.QuestionNumber
				, t20.dataFieldObjectId						AS DataFieldIdAnswerTo	
				, t20.dataFieldOptionObjectId				AS DataFieldOptioinIdAnswerTo
				, REPLACE( t20.name		, ',', '' )			AS AnswerTo		
				
		FROM 
				##dropOutAnalysis_03	t10
			LEFT JOIN
				(
						SELECT
								 sra.surveyResponseObjectId, sra.dataFieldObjectId, sra.dataFieldOptionObjectId, dfo.name

						FROM
								surveyResponseAnswer		sra
							JOIN
								dataFieldOption				dfo 
										ON sra.dataFieldOptionObjectId = dfo.objectId
						WHERE 
								surveyResponseObjectId IN ( SELECT objectId FROM ##dropOutAnalysis_03 )
							AND 
								sra.dataFieldObjectId = @dataFieldAnswerTo
				)	AS t20
						ON t10. objectId = t20.surveyResponseObjectId
		WHERE
				SurveyObjectId = @surveyId				
			AND
				ModeType = @modeType
					
						
	GOTO CLEANUP
	END





--Optional surveyId & ModeType, present
IF		@deliveryEmailCheck	= 1
	AND
		@OrgIdCheck			= 1		
	AND
		@beginDateCheck		= 1
	AND
				@surveyIdCheck		= 0
	AND
				@surveyNameCheck	= 1
	AND
				@modeTypeCheck		= 1
				
	BEGIN
		PRINT 'Includes SurveyName & ModeType'
		
		INSERT INTO ##dropOutAnalysis_ResultSet
		SELECT 
				t10.objectId								AS SurveyResponseObjectId
				, t10.SurveyObjectId
				, t10.SurveyGatewayObjectId	
				, t10.ModeType
				, REPLACE( t10.Location		, ',', '' )		AS Location
				, REPLACE( t10.SurveyName	, ',', '' )		AS SurveyName
				, t10.BeginDate
				, t10.BeginTime
				, t10.Minutes
				, t10.Ani
				, REPLACE( t10.OfferCode	, ',', '' )		AS OfferCode	
				, REPLACE( t10.OfferName	, ',', '' )		AS OfferName
				, REPLACE( t10.PromptName	, ',', '' )		AS PromptName
				, t10.DataFieldObjectId
				, REPLACE( t10.Answer		, ',', '' )		AS Answer
				, t10.QuestionNumber
				, t20.dataFieldObjectId						AS DataFieldIdAnswerTo	
				, t20.dataFieldOptionObjectId				AS DataFieldOptioinIdAnswerTo
				, REPLACE( t20.name		, ',', '' )			AS AnswerTo		
				
		FROM 
				##dropOutAnalysis_03	t10
			LEFT JOIN
				(
						SELECT
								 sra.surveyResponseObjectId, sra.dataFieldObjectId, sra.dataFieldOptionObjectId, dfo.name

						FROM
								surveyResponseAnswer		sra
							JOIN
								dataFieldOption				dfo 
										ON sra.dataFieldOptionObjectId = dfo.objectId
						WHERE 
								surveyResponseObjectId IN ( SELECT objectId FROM ##dropOutAnalysis_03 )
							AND 
								sra.dataFieldObjectId = @dataFieldAnswerTo
				)	AS t20
						ON t10. objectId = t20.surveyResponseObjectId
		WHERE
				SurveyName = @surveyName
			AND
				ModeType = @modeType
					
		
	GOTO CLEANUP
	END




CLEANUP:

PRINT 'Generating & Sending Results via Email'


-- Builds Final Email
IF OBJECT_ID('tempdb..##dropOutAnalysis_Results') IS NOT NULL	DROP TABLE ##dropOutAnalysis_Results
CREATE TABLE ##dropOutAnalysis_results
	(
		Item			varchar(max)
		, Criteria		varchar(max)
	)

DECLARE @fileRowCount	varchar(25)
SET		@fileRowCount	= ( SELECT REPLACE(CONVERT(varchar(20), (CAST(    		COUNT(1)    	AS money)), 1), '.00', '')		FROM ##dropOutAnalysis_ResultSet )
 	

INSERT INTO ##dropOutAnalysis_results ( Item, Criteria )
SELECT 'Server Name', @@SERVERNAME
UNION ALL
SELECT 'Delivery Email', @deliveryEmail
UNION ALL
SELECT 'Organization Id', CAST(@OrgId as varchar)
UNION ALL
SELECT 'Start Date', CONVERT(char(8), @beginDate, 112)
UNION ALL
SELECT 'End Date', CONVERT(char(8), @endDate, 112)
UNION ALL
SELECT 'Survey Name', CASE WHEN @surveyNameCheck = 0 THEN 'No Filter' ELSE @surveyName END
UNION ALL
SELECT 'Survey Id', CASE WHEN @surveyIdCheck = 0 THEN 'No Filter' ELSE CAST(@surveyId as varchar) END
UNION ALL
SELECT 'Mode Type', CASE WHEN @modeTypeCheck = 0 THEN 'No Filter' ELSE CAST(@modeType as varchar) END
UNION ALL
SELECT 'DataField Answer To', CASE WHEN @dataFieldAnswerToCheck = 0 THEN 'No Filter' ELSE CAST(@dataFieldAnswerTo as varchar) END
UNION ALL
SELECT 'Execution Date & Time', CONVERT(varchar, getdate(), 109)
UNION ALL
SELECT 'File Row Count', @fileRowCount

		
		
		
		-- Email Results & File	
SET @querySqlStatement		= 
							'
								SELECT 
										SurveyResponseObjectId
										, SurveyObjectId
										, SurveyGatewayObjectId	
										, ModeType
										, Location
										, SurveyName
										, BeginDate
										, BeginTime
										, Minutes
										, Ani
										, OfferCode	
										, OfferName
										, PromptName
										, DataFieldObjectId
										, Answer
										, QuestionNumber
										, DataFieldIdAnswerTo	
										, DataFieldOptioinIdAnswerTo
										, AnswerTo		
										
								FROM 
										##dropOutAnalysis_ResultSet

							'				



SET @xml = CAST(( 


SELECT 	
		Item																			
										AS 'td',''
		, Criteria
										AS 'td'
FROM 
		##dropOutAnalysis_Results

		
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


-----Header Naming and Column Naming below

SET @body =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
Dropout Analysis Comments
													</H4><table border = 2><tr><th>	
Item								
													</th><th>
Criteria									
													</th></tr>'    

 
SET @body = @body + @xml +'</table></body></html>'




EXEC msdb.dbo.sp_send_dbmail
@profile_name					= 'Internal Request'
, @recipients					= @deliveryEmail
--, @copy_recipients 				= 'tpeterson@mshare.net'
, @copy_recipients 				= 'tpeterson@mshare.net; jdiamond@mshare.net'
, @reply_to						= 'dba@mshare.net'
, @subject						= 'Drop Analysis Results & Criteria'
, @body_format					= 'HTML'
, @body							= @body
, @query_result_no_padding 		= 1	-- turn off padding of fields with spaces
, @query_result_separator 		= ','
, @query_attachment_filename	= @FileName
, @query_result_header 			= 1
, @execute_query_database		= 'Mindshare'
, @query_result_width 			= 32767

, @attach_query_result_as_file 	= 1
, @query 						= @querySqlStatement


		
		
		
PRINT 'Email Has Been Sent'		
	
PRINT 'Removing Temp Tables'

--SELECT *	FROM ##dropOutAnalysis_ResultSet
		
IF OBJECT_ID('tempdb..##dropOutAnalysis_01') IS NOT NULL		DROP TABLE ##dropOutAnalysis_01
IF OBJECT_ID('tempdb..##dropOutAnalysis_02') IS NOT NULL		DROP TABLE ##dropOutAnalysis_02
IF OBJECT_ID('tempdb..##dropOutAnalysis_03') IS NOT NULL		DROP TABLE ##dropOutAnalysis_03
IF OBJECT_ID('tempdb..##dropOutAnalysis_Results') IS NOT NULL	DROP TABLE ##dropOutAnalysis_Results	
IF OBJECT_ID('tempdb..##dropOutAnalysis_ResultSet') IS NOT NULL	DROP TABLE ##dropOutAnalysis_ResultSet	
		
	
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

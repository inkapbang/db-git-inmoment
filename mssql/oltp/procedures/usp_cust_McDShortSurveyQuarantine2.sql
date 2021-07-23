SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_cust_McDShortSurveyQuarantine2]
AS

/*****************  usp_cust_McDShortSurveyQuarantine2  ******************

	McD quarantine for too fast surveys
	Bob Luther 092909

*************************************************************************/

--get McD Canada locations
IF OBJECT_ID(N'tempdb..#cat1003', N'U') IS NOT NULL 	
	DROP TABLE #cat1003;

	
CREATE TABLE #cat1003 
	(
        locationObjectId 				int NOT NULL
		, locationCategoryObjectId 		int NOT NULL
		, locationCategoryName 			varchar(100) NOT NULL
		, Primary Key(locationObjectId, locationCategoryObjectId)
    );
	
INSERT INTO #cat1003
SELECT
		locationObjectId
		, locationCategoryObjectId
		, locationCategoryName 
FROM
		dbo.ufn_app_LocationsInCategoryOfType(1003) ;

		
--SELECT * 	FROM #cat1003 	WHERE locationCategoryObjectId = 14999

DECLARE @beginDT 			dateTime
		, @endDT 			dateTime
		, @voiceMinutes 	float
		, @webMinutes 		float

--SET @beginDT 	= '4/21/2011'
--SET @endDT	= '4/25/2011'

--exec [dbo].[usp_cust_McDShortSurveyQuarantine2]
SET @beginDT 	= DATEADD( dd, -3, CAST(GETDATE() AS DATE)  )
--SET @endDT 		= DATEADD( mi, -10, getdate() )

SET @endDT=CAST(GETDATE() AS DATE)
select @beginDT,@endDT

SET @voiceMinutes 	= 4.0
SET @webMinutes 	= 2.2

DECLARE @res TABLE 
	(
		srObjectId 			int
		, locationNumber 	varchar(50)
		, locationName 		varchar(100)
		, minutes 			float
		, beginDateUTC 		dateTime
		, mode 				varchar(12)
	)
	
	
--get phone AND web surveys that are below minumum time limits
INSERT INTO @res

SELECT 
		sr.objectId
		, l.locationNumber
		, l.name
		, sr.minutes
		, sr.beginDateUTC
		, CASE modeType WHEN 1 THEN 'Phone' WHEN 2 THEN 'WebSurvey' ELSE 'Import' END	 AS mode
--SELECT min(sr.minutes) AS minmin, max(sr.minutes) AS maxmin, var(sr.minutes), varp(sr.minutes) AS varpmin, stdev(sr.minutes), stdevp(sr.minutes) AS stdevpmin, avg(sr.minutes) avgmin
FROM 
		location l 				WITH (NOLOCK)
	JOIN 
		surveyResponse sr 		WITH (NOLOCK)
				ON l.objectId = sr.locationObjectId
	LEFT OUTER JOIN #cat1003 cat1003
				ON l.objectId = cat1003.locationObjectId
WHERE 
		l.organizationObjectId = 569
	AND 
		beginDate >= @beginDT
	AND 
		beginDate <	@endDT
	AND 
		sr.modeType = 1 --Phone
	--AND 
	--	sr.modeType = 2 --web
	AND 
		l.enabled = 1
	AND 
		l.hidden = 0
	AND 
		sr.complete = 1
	--AND 
	--	offer.objectId IN ( 1223,1222 )   
	AND 
		cat1003.locationCategoryObjectId = 14999
	AND 
		minutes > 0.0
	AND 
		minutes < @voiceMinutes
	AND 
		( sr.offerObjectId != 1361 AND sr.locationObjectId != 282275 )
	AND 
		( sr.offerObjectId != 1361 AND sr.locationObjectId != 282276 )
	AND 
		( sr.offerObjectId != 1361 AND sr.locationObjectId != 282277 )
		
--SELECT * FROM @res

UNION

SELECT 
		sr.objectid
		, l.locationNumber
		, l.name
		, sr.minutes
		, sr.beginDateUTC
		, CASE modeType WHEN 1 THEN 'Phone' WHEN 2 THEN 'WebSurvey' ELSE 'Import' END	AS mode
--SELECT min(sr.minutes) AS minmin, max(sr.minutes) AS maxmin, var(sr.minutes), varp(sr.minutes) AS varpmin, stdev(sr.minutes), stdevp(sr.minutes) AS stdevpmin , avg(sr.minutes) AS avgmin
FROM 
		location l 					WITH (NOLOCK)
	JOIN 
		surveyResponse sr 			WITH (NOLOCK)
				ON l.objectId = sr.locationObjectId
	LEFT OUTER JOIN 
		#cat1003 cat1003
				ON l.objectId = cat1003.locationObjectId
WHERE 
		l.organizationObjectId = 569
	AND 
		beginDateUTC >= @beginDT
	AND 
		beginDateUTC <	@endDT
	--AND 
	--	sr.modeType = 1 --Phone
	AND 
		sr.modeType = 2 --web
	AND 
		l.enabled = 1
	AND 
		l.hidden = 0
	AND 
		sr.complete = 1
	--AND 
	--	offer.objectId IN ( 1223,1222 )   
	AND 
		cat1003.locationCategoryObjectId = 14999
	--AND 
	--	minutes > 0.0
	AND 
		minutes < @webMinutes
	AND 
		( sr.offerObjectId != 1361 AND sr.locationObjectId != 282275 )
	AND 
		( sr.offerObjectId != 1361 AND sr.locationObjectId != 282276 )
	AND 
		( sr.offerObjectId != 1361 AND sr.locationObjectId != 282277 )

SELECT * FROM @res ORDER BY mode, srObjectId

--exec dbo.usp_cust_McDShortSurveyQuarantine2

DELETE FROM @res
WHERE srObjectId IN ( SELECT surveyResponseObjectId 	FROM surveyResponseAnswer sra 	JOIN @res r		ON r.srObjectId = sra.surveyResponseObjectId	WHERE sra.dataFieldOptionObjectId = 89261 );


-----------------
DECLARE @count 				int
		, @sraObjectId 		int
		, @srObjectId 		int
		, @locationNumber 	varchar(50)
		, @locationName 	varchar(100)
		, @newSequence 		int
		
SET @count=0

DECLARE mycursor CURSOR for
SELECT srObjectId, locationNumber, locationName 	FROM  @res

OPEN mycursor
FETCH next FROM mycursor INTO @srObjectId, @locationNumber, @locationName
WHILE @@FETCH_status = 0
BEGIN

SET @newSequence = ( SELECT max(sequence) + 1 	FROM surveyResponseAnswer 	WITH (NOLOCK) 		WHERE surveyResponseObjectId = @srObjectId )

----INSERT orig locationNumber INTO sratextValue

INSERT INTO surveyResponseAnswer( surveyResponseObjectId, sequence, textValue, dataFieldObjectId )
SELECT @srObjectId, @newSequence, @locationNumber, 28288

----INSERT orig locationName INTO sraTextValue

INSERT INTO surveyResponseAnswer( surveyResponseObjectId, sequence, textValue, dataFieldObjectId )
SELECT @srObjectId, @newSequence + 1, @locationName, 28289

UPDATE surveyResponse WITH (ROWLOCK) 	SET externalId = cast( offerObjectId as varchar ) 		WHERE objectid = @srObjectId
UPDATE surveyResponse WITH (ROWLOCK) 	SET offerObjectId = 1361, locationObjectId = 282275  	WHERE objectid = @srObjectId
--

SET @count = @count + 1

PRINT cast(@count as varchar)+' ,'+cast(@srObjectId as varchar)+' ,'+@locationNumber+' ,'+@locationName
FETCH next FROM mycursor INTO @srObjectId,@locationNumber,@locationName
END--WHILE
CLOSE mycursor
DEALLOCATE mycursor
PRINT cast(@count as varchar) +' Records Processed'



---
; IF OBJECT_ID(N'tempdb..#cat1003', N'U') IS NOT NULL 
	DROP TABLE #cat1003;

--exec dbo.usp_cust_McDShortSurveyQuarantine2

----------chk
--SELECT sr.objectid,sr.offerCodeObjectId,sr.externalid,sr.modeType,sr.ani,sr.ipaddress,sr.minutes
--FROM location l WITH (NOLOCK) JOIN offercode oc WITH (NOLOCK)
--on l.objectid=oc.locationobjectid
--JOIN surveyResponse sr WITH (NOLOCK)
--on oc.objectid = sr.offerCodeObjectId
--WHERE l.organizationobjectid=569
--AND sr.begindate >'8/1/2009' 
--AND sr.offerCodeObjectId=800573
--order by modeType,minutes,objectid asc
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

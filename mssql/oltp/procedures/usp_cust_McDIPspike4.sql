SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_cust_McDIPspike4]
 --exec [dbo].[usp_cust_McDIPspike4]
AS




DECLARE @beginDT 				datetime
		,@endDT 				datetime
		,@minutesToLookBack 	int
		
SET @minutesToLookBack=180

--SET @beginDT 	= '4/21/2011'
--SET @endDT	= '4/24/2011'
SET @endDT		= DATEADD( mi, -10, getUTCDate() )
SET @beginDT	= DATEADD( dd,  -2, @endDT )

SELECT @beginDT, @endDT
--PRINT @beginDT

--get 
IF Object_id(N'tempdb..#res1',N'U') IS NOT NULL
  DROP TABLE #res1;

CREATE TABLE #res1
	(
		srObjectId 			bigInt
		, locationNumber	varchar(150)
		, ipAddress 		varchar(150)
		, beginDateUTC 		dateTime
	)

IF Object_id(N'tempdb..#res3',N'U') IS NOT NULL
  DROP TABLE #res3;

CREATE TABLE #res3
	(
		srObjectId 	bigInt
	)

--get surveys for that period
INSERT INTO #res1
SELECT 
		sr.objectId
		, l.locationNumber
		, sr.ipAddress
		, sr.BEGINDateUTC
FROM   
		location l 					WITH (NOLOCK)
   JOIN 
		surveyResponse sr 			WITH (NOLOCK)
					ON l.objectId = sr.locationObjectId
WHERE  
		l.organizationObjectId = 569
   AND 
		modeType=2
   AND 
		l.objectId IN (
						SELECT 
								locationObjectId
						FROM   
								dbo.Ufn_app_locationsincategoryoftype(1003)
						WHERE  
								locationCategoryObjectId IN ( 14999, 14999 )
					)--Canada

   AND 
		( sr.offerObjectId != 1361 	AND sr.locationObjectId != 282275 )
   AND 
		(sr.offerObjectId != 1361 	AND sr.locationObjectId != 282276)
   AND 
		(sr.offerObjectId != 1361 	AND sr.locationObjectId != 282277)
   AND 
		BEGINDateUTC BETWEEN @beginDT 
						AND  @endDT
   AND 
		l.enabled 	= 1
   AND 
		l.hidden 	= 0
   AND 
		sr.complete = 1
	AND sr.IPAddress <> '38.108.87.20';

		
		
--SELECT * FROM #res1

DELETE FROM #res1
WHERE srObjectId IN 
					(
						SELECT 
								surveyResponseObjectId 
						FROM 
								surveyResponseAnswer sra 			WITH (NOLOCK)
							JOIN 
								#res1 r
										ON r.srObjectId = sra.surveyResponseObjectid
						WHERE 
								sra.dataFieldOptionObjectId = 89261
					);

					
----Top Of Loop
DECLARE @count 				int
		, @locationnumber 	varchar(15)
		, @ipaddress 		varchar(15)
		
SET 	@count = 0

DECLARE myCursor CURSOR for
SELECT locationNumber,	ipAddress	FROM #res1		GROUP BY locationNumber, ipAddress		HAVING count(*) > 2

OPEN myCursor
FETCH next FROM myCursor INTO @locationnumber, @ipaddress

WHILE @@FETCH_Status = 0
BEGIN
--PRINT cast(@count as varchar)+', '+@locationNumber+', '+@ipAddress

--Inner loop
IF Object_id(N'tempdb..#res2',N'U') IS NOT NULL
  DROP TABLE #res2;

CREATE TABLE #res2
	(
		isrObjectId 		bigInt
		,ilocationNumber 	varchar(15)
		,iipAddress 		varchar(15)
		,ibeginDateUTC 		datetime
		,irowNumber 		int
	)

DECLARE  @isrObjectId 			bigint
		, @ilocationNumber 		varchar(15)
		, @iipAddress 			varchar(15)
		, @ibeginDateUTC 		datetime 
		, @irowNumber 			int

DECLARE innerCursor CURSOR for 
SELECT 
		srObjectId
		, locationNumber
		, ipAddress
		, beginDateUTC
		, ROW_NUMBER() OVER (ORDER BY BEGINdateutc DESC) AS rowNumber
		
FROM 
		#res1
WHERE 
		locationNumber = @locationNumber
	AND 
		ipAddress = @ipAddress
		

OPEN innerCursor
FETCH next FROM innerCursor INTO @isrObjectId, @ilocationNumber, @iipAddress, @ibeginDateUTC, @irowNumber

WHILE @@FETCH_status = 0
BEGIN
--PRINT cast(@isrObjectId as varchar)+', '+@locationNumber+', '+@iipAddress+', '+convert(varchar(25), @ibeginDateUTC, 101)+', '+cast(@irowNumber as varchar)+', '+cast(@minutesToLookBack as varchar)

--- populate #res2 for 
INSERT INTO #res2
SELECT 
		@isrobjectid
		, @ilocationNumber
		, @iipAddress
		, @ibeginDateUTC
		, @irowNumber

FETCH next FROM innercursor INTO @isrObjectId, @ilocationNumber, @iipAddress, @ibeginDateUTC, @irowNumber
END--WHILE
CLOSE innerCursor
DEALLOCATE innerCursor

--
--process
DECLARE @maxRow 				int
		, @i 					int 
		, @newestsrObjectId 	bigInt
		, @newestTime 			dateTime
		, @nextsrObjectId 		bigInt
		, @nextTime 			dateTime
		
SET @newestTime 		= ( SELECT ibeginDateUTC 	FROM #res2 		WHERE irowNumber = 1 )
SET @newestsrObjectId	= ( SELECT isrobjectid 		FROM #res2 		WHERE irowNumber = 1 )
SET @i 					= 1
SET @maxRow 			= ( SELECT max(irowNumber) 	FROM #res2 )

WHILE @i <= @maxRow -1
BEGIN
	
	SET @nextTime 		= ( SELECT ibeginDateUTC 	FROM #res2 		WHERE irowNumber = @i+2 )
	SET @nextsrObjectId = ( SELECT isrobjectid 		FROM #res2 		WHERE irownumber = @i+2 )

	IF DATEDIFF( mi, @nextTime, @newestTime ) <= @minutesToLookBack
		INSERT INTO #res3 SELECT @newestsrObjectId

SET @newestTime 		= ( SELECT ibeginDateUTC 	FROM #res2 		WHERE irowNumber = @i+1 )
SET @newestsrObjectId 	= ( SELECT isrObjectId 		FROM #res2 		WHERE irowNumber = @i+1 )

--	SET @newestTime = @nextTime
--	SET @newestsrObjectId = @nextsrObjectId

SET @i = @i+1
END --WHILE


--SELECT * FROM #res2
SET @count = @count + 1
FETCH next FROM myCursor INTO @locationNumber, @ipAddress

END--WHILE
CLOSE myCursor
DEALLOCATE myCursor

SELECT * FROM #res3
PRINT cast(@count as varchar) +' Records Processed'

--------
--update surveyResponse
UPDATE surveyResponse 	WITH (ROWLOCK)
SET externalId = CAST(offerObjectId as varchar)
WHERE objectId IN ( SELECT srObjectId 	FROM #res3 )

UPDATE surveyResponse 	WITH (ROWLOCK)
SET offerObjectId 		= 1361
	, locationObjectId 	= 282277
WHERE objectId IN ( SELECT srObjectId 	FROM #res3 )

-----------
----update surveyResponseAnswer
-----------------
DECLARE @counter 			int
		, @sraObjectId 		int
		, @srObjectId 		int
		, @locationNumber2 	varchar(50)
		, @locationName 	varchar(100)
		, @newSequence 		int
		
SET @counter = 0

DECLARE myCursor2 CURSOR for
--SELECT srObjectId, locationNumber, locationName 	FROM #res3

SELECT 
		sr.objectId
		, l.locationNumber
		, l.name
FROM   
		location l 				WITH (NOLOCK)
   JOIN 
		surveyResponse sr 		WITH (NOLOCK)
				ON l.objectId = sr.locationObjectId
   JOIN 
		#res3 r
				ON r.srObjectId = sr.objectId

OPEN myCursor2
FETCH next FROM myCursor2 INTO @srObjectId, @locationNumber2, @locationName

WHILE @@FETCH_status = 0
BEGIN

SET @newSequence = ( SELECT max(sequence) + 1 	FROM surveyResponseAnswer 	WITH (NOLOCK) 		WHERE surveyResponseObjectId = @srObjectId )

----INSERT orig locationNumber INTO sraTextValue

INSERT INTO surveyResponseAnswer( surveyResponseObjectId, sequence, textValue, dataFieldObjectId )
SELECT @srObjectId, @newSequence, @locationNumber2, 28288

----INSERT orig locationName INTO sraTextValue

INSERT INTO surveyResponseAnswer( surveyResponseObjectId, sequence, textValue, dataFieldObjectId )
SELECT @srObjectId, @newSequence + 1, @locationName, 28289

SET @counter = @counter + 1
PRINT cast(@counter as varchar)+' ,'+cast(@srObjectId as varchar)+' ,'+@locationNumber2+' ,'+@locationName

FETCH next FROM myCursor2 INTO @srObjectId, @locationNumber2, @locationName
END--WHILE
CLOSE myCursor2
DEALLOCATE myCursor2

PRINT cast(@count as varchar) +' Records Processed'

--
--------------------------
----exec [dbo].[usp_cust_McDIPspike4] 
--
----chk
--SELECT sr.objectid,l.locationnumber,l.name,sr.ipaddress,sr.begindate,sr.begintime,sr.begindateutc,sr.offerCodeObjectId,sr.externalid
--FROM location l JOIN offercode oc
--on l.objectid=oc.locationobjectid
--JOIN surveyresponse sr
--on oc.objectid = sr.offerCodeObjectId
--WHERE l.organizationobjectid=569
--AND sr.BEGINdate >'8/1/2009'
--AND sr.complete=1
--AND l.enabled= 1
--AND sr.offerCodeObjectId=800573
--order by locationnumber,ipaddress,begindateUTC desc

--
----chk
--DECLARE @beginDT datetime,@endDT datetime
--SET @beginDT='8/1/2009'
--SET @endDT=getUTCDate()
--SELECT sr.objectid,l.locationnumber,sr.ipaddress,sr.begindate,sr.begintime,sr.begindateUTC
--        FROM   location l WITH (NOLOCK)
--               JOIN offercode oc WITH (NOLOCK)
--                 ON l.objectid = oc.locationobjectid
--               JOIN surveyresponse sr WITH (NOLOCK)
--                 ON oc.objectid = sr.offercodeobjectid
--        WHERE  l.organizationobjectid = 569
--			   AND modetype=2
--               AND l.objectid IN (SELECT locationobjectid
--                                  FROM   dbo.Ufn_app_locationsincategoryoftype(1003)
--                                  WHERE  locationcategoryobjectid = 14999)--Canada
--
--               AND sr.offercodeobjectid != 800575
--			   AND begindateUTC BETWEEN @beginDT AND @endDT
--               AND l.enabled = 1
--               AND l.hidden = 0
--               AND sr.complete = 1
--order by locationnumber,ipaddress,begindateutc desc;

-----------
--SELECT * 
--FROM surveyresponse sr JOIN surveyresponseanswer sra
--on sr.objectid=sra.surveyresponseobjectid
--WHERE sr.offercodeobjectid=800575
--AND sra.datafieldobjectid=28288
----
----28289
--SELECT * 
--FROM surveyresponse sr JOIN surveyresponseanswer sra
--on sr.objectid=sra.surveyresponseobjectid
--WHERE sra.datafieldobjectid=28289
----
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

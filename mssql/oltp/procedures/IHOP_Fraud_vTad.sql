SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[IHOP_Fraud_vTad]
AS
-----If a server number has 5 of more surveys with a Total Score of 100 in one day, quarantine all surveys.

--*********************************  Begining of Script  ***************************************

/* Table is on OLTP and holds sroid history information
CREATE TABLE IHOP_Fraud_History
	(
		surveyResponseObjectId		bigint
		, modifiedDateTime			dateTime
	)
*/


DECLARE @dTT01 TABLE
	(
		surveyResponseObjectId		bigint
		, locationObjectId			int
		, textValue					varchar(50)
	)

INSERT INTO @dTT01
SELECT	
		t01.objectId													
		, t01.locationObjectId		
		, textValue
		
FROM
		surveyResponse			t01		WITH (NOLOCK)
	JOIN
		surveyResponseAnswer	t02		WITH (NOLOCK)
				ON t01.objectId = t02.surveyResponseObjectId	

WHERE				
		t02.dataFieldObjectId = 40057
	AND 
		t01.beginDate =	DATEADD(dd,-1,cast(floor(cast(getdate() as float))as datetime))		
						--BETWEEN	'7/1/2011'
						--AND		'7/1/2011'
	AND 
		t01.complete = 1
		

ORDER BY 
		t01.locationObjectId
		, textValue			
				
				


DECLARE @dTT02	TABLE
	(
		rowId							INT IDENTITY (1,1)
		, locationObjectId				int
		, textValue						varchar(50)
		, countNum							int
	)


INSERT INTO @dTT02
SELECT	
														
		t01.locationObjectId		
		, textValue
		, count(1)
		
FROM
		@dTT01		t01
		
GROUP BY
		t01.locationObjectId
		, textValue	
				
HAVING count(1) >= 5

ORDER BY 
		t01.locationObjectId
		, textValue			



-------Checking surveys for scores of 100
DECLARE @dTT03 TABLE
	(
		surveyResponseObjectId		INT
		, calcValue					FLOAT
	)
	
DECLARE @dTT04 TABLE
	(
		rowId							INT IDENTITY (1,1)
		, surveyResponseObjectId		INT
	)
	
DECLARE @count			INT
		, @endCount		INT
		, @valueCheck	INT
		
SET 	@count	=	1
SET 	@endCount =	( SELECT max(rowId)	FROM @dTT02 )



WHILE @count 	<=	@endCount
BEGIN
		
		INSERT INTO @dTT03
		SELECT
				t03.surveyResponseObjectId
				, cast( sum(t04.points) as float) / cast( sum(t04.pointsPossible) as float) AS calcValue
				
		FROM 		
				@dTT01	t03
			JOIN
				(
					( SELECT locationObjectId, textValue		FROM @dTT02		WHERE rowId = @count )
				) aa		
						ON t03.locationObjectId = aa.locationObjectId	AND t03.textValue = aa.textValue
			JOIN	
				surveyResponseScore			t04		WITH (NOLOCK)
						ON t03.surveyResponseObjectId = t04.surveyResponseObjectId
			
			GROUP BY
				t03.surveyResponseObjectId		
				
				
		SET	@valueCheck =	( SELECT COUNT(1)	FROM @dTT03 	WHERE calcValue = 1	)
		
		IF @valueCheck  >=	5
		BEGIN
			INSERT INTO @dTT04
			SELECT surveyResponseObjectId 	FROM @dTT03
		END		

		DELETE @dTT03	
		
		SET @count = @count+1

END



/*	Analysing the Data, it takes a few moments for final table to return data

DECLARE @dTT05 TABLE
	(
		objectId						varchar(100)
		, surveyGatewayObjectId			varchar(100)
		, ani							varchar(100)
		, beginDate						varchar(100)
		, complete						varchar(100)
		, surveyObjectId				varchar(100)
		, dateOfService					varchar(100)
		, offerCodeObjectId				varchar(100)
		, redemptionCode				varchar(100)
		, beginTime						varchar(100)
		, minutes						varchar(100)
		, modeType						varchar(100)
		, beginDateUTC					varchar(100)
		, exclusionReason				varchar(100)
	)

	

DECLARE @anDataCount			int
		, @anDataEndCount		int

SET		@anDataCount 		= 	1
SET		@anDataEndCount		=	( SELECT max(rowId)	FROM @dTT04 )


WHILE @anDataCount <=	@anDataEndCount
BEGIN
	INSERT INTO @dTT05
	SELECT 
			objectId,
			surveyGatewayObjectId,
			ani,
			beginDate,
			complete,
			surveyObjectId,
			dateOfService,
			offerCodeObjectId,
			redemptionCode,
			beginTime,
			minutes,
			modeType,
			beginDateUTC,
			exclusionReason			
FROM 
		surveyResponse
WHERE
		objectId IN	(
						SELECT
								surveyResponseObjectId
						FROM
								@dTT01 	t01
							JOIN
								@dTT02	t02
									ON t01.locationObjectId = t02.locationObjectId	AND	t01.textValue = t02.textValue
						WHERE
								rowId = @anDataCount
					)			


	INSERT INTO @dTT05
	SELECT
			'  '
			, '  '
			, '  '
			, '  '
			, '  '
			, '  '
			, '  '
			, '  '
			, '  '
			, '  '
			, '  '
			, '  '
			, '  '
			, '  '
			
	SET @anDataCount	=	@anDataCount + 1 		

END

SELECT * FROM @dTT05

*/



--////////////////////////////////////////////////////////////////////////////////////////////

----- This cursor is LIVE !!!	-----
	
	
DECLARE  @cursorCount int, @sroid int
SET @count = 0

DECLARE mycursor CURSOR for
SELECT surveyResponseObjectId FROM @dTT04

OPEN mycursor
FETCH next FROM mycursor INTO @sroid

WHILE @@FETCH_Status = 0
BEGIN


----******************* W A R N I N G***************************


UPDATE surveyResponse WITH (ROWLOCK)
SET exclusionReason = 2
WHERE objectId = @sroid

INSERT INTO IHOP_Fraud_History	(surveyResponseObjectId, modifiedDateTime)
SELECT @sroid, getDate()



----***********************************************************


SET @cursorCount = @cursorCount + 1
FETCH next FROM mycursor INTO @sroid

END--WHILE
CLOSE mycursor
DEALLOCATE mycursor


--///////////////////////////////////////////////////////////////////////////////////////////// */





/*
SELECT * 	FROM @dTT01
SELECT * 	FROM @dTT02
SELECT * 	FROM @dTT03

SELECT * 	FROM @dTT04


SELECT
		--*
		COUNT(1)
FROM
		IHOP_Fraud_History

WHERE
		modifiedDateTime BETWEEN	'10/25/2011'
							AND		'10/26/2011'
							
									
*/

--*********************************  End of Script  ***************************************


	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

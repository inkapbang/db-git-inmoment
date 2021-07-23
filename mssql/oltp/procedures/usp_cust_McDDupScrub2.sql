SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_McDDupScrub2]
as
 
/*******************  usp_cust_McDDupScrub2  ********************
This procedure identifies surveys that have duplicate:
dateofservice,lobjectid,numericvalue,and contactnumber.
When found, it preserves the first entry, moves the existing 
offerobjectid to sr.externalid and moves the 
subsequent entries to offer objectid =1361

Bob Luther 10-08-2009

*****************************************************************/
DECLARE	@daysToLookBack 	INT

SET 	@daysToLookBack 	= 100

IF Object_id(N'tempdb..#res1',N'U') IS NOT NULL
	DROP TABLE #res1;

CREATE TABLE #res1 
	(
	  srObjectId    INT,
	  beginDateUTC  DATETIME,
	  dateOfService DATETIME,
	  lObjectId     INT,
	  numericValue  MONEY,
	  contactNumber VARCHAR(15)
	 )

INSERT INTO #res1
SELECT srObjectId,
       beginDateUTC,
       dateOfService,
       lObjectId,
       numericValue,
       contactNumber
--select *
FROM 
		(
			SELECT sr.objectId srObjectId,
				   sr.beginDateUTC,
				   sr.dateOfService,
				   sr.beginTime,
				   l.objectId  lObjectId,
				   sra.numericValue
			FROM   
					location l 					WITH (NOLOCK)
				JOIN 
					surveyResponse sr 			WITH (NOLOCK)
							ON l.objectId = sr.locationObjectId
				LEFT OUTER JOIN 
					surveyResponseAnswer sra 	WITH (NOLOCK)
							ON sr.objectId = sra.surveyResponseObjectId
			WHERE  
					l.organizationObjectId = 569
				AND 
					l.objectId IN (
									SELECT 
											locationObjectId
									FROM   
											dbo.Ufn_app_locationsincategoryoftype(1003)
									WHERE  
											locationCategoryObjectId = 14999--Canada
										AND 
											beginDateUTC >= DATEADD( dd, -@daysToLookBack, GetUTCDate() ) --days to look back
										AND 
											(sr.offerObjectId != 1361 AND sr.locationObjectId != 282276)
								  )
			   AND 
					l.enabled = 1
			   AND 
					l.hidden = 0
			   AND 
					sr.complete = 1
			   AND 
					sra.dataFieldObjectId = 25757
		) AS a
		
	LEFT OUTER JOIN 
		(
			SELECT 
					sra.surveyResponseObjectId
					, Replace(Replace(Replace(Replace(sra.textvalue,'(',''),')',''),'-',''),' ','') AS contactnumber
                        
			FROM   
					surveyResponseAnswer sra WITH (NOLOCK)
            WHERE  
					dataFieldObjectId = 25846
		) AS b				ON a.srObjectId = b.surveyResponseObjectId

--select * from #res1;
;WITH mycte
     AS (
			SELECT  
					dateOfService,
					lObjectId,
					numericValue,
					contactNumber
			 FROM     
					#res1
			 WHERE    
					contactNumber IS NOT NULL
					
			 GROUP BY 
					dateOfService,
					lObjectId,
					numericValue,
					contactNumber
			 HAVING   
					Count(*) > 1
		 )
		 
--select * from mycte
UPDATE surveyResponse
SET    externalId 			= CAST(offerobjectid AS VARCHAR)
       , offerObjectId 		= 1361
       , locationObjectId 	= 282276
WHERE  objectId IN (
						SELECT 
								srObjectId
						FROM   (
									SELECT 
											r.srObjectId,
											r.dateOfService,
											r.lObjectId,
											r.numericValue,
											r.contactNumber,
											r.beginDateUTC,
											ROW_NUMBER() OVER(PARTITION BY r.dateOfService, r.lObjectId, r.numericValue, r.contactNumber ORDER BY beginDateUTC) AS rowNumber
									FROM   
											mycte m
										JOIN 
											#res1 r
													ON m.dateOfService 		= r.dateOfService
														AND m.lObjectId 	= r.lObjectId
														AND m.numericValue 	= r.numericValue
														AND m.contactNumber = r.contactNumber
								) AS a
						WHERE  rowNumber > 1
					)

IF Object_id(N'tempdb..#res1',N'U') IS NOT NULL
  DROP TABLE #res1; 

--exec [dbo].[usp_cust_McDDupScrub2]

--chk
--select sr.objectid,sr.offerCodeObjectId,sr.externalid
--from location l join offercode oc
--on l.objectid=oc.locationobjectid
--join surveyresponse sr
--on oc.objectid = sr.offerCodeObjectId
--where l.organizationobjectid=569
--and sr.begindate >'8/1/2009' 
--and sr.offerCodeObjectId=800574
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

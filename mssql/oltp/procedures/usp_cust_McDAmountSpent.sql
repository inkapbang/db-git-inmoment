SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_cust_McDAmountSpent]  
   
as  
--exec [dbo].[usp_cust_McDAmountSpent]  
DECLARE @begindt 				datetime
		, @enddt 				datetime
		--, @minutestolookback 	int 
		
--SET @minutestolookback	= 180  
 
SET @enddt		= DATEADD(mi,-10,getUTCDate())
SET @begindt	= DATEADD(dd,-7,@enddt)
 
--SET @begindt 	= '11/1/2009 07:00:00' 
--SET @enddt	= '10/8/2009'  

  
--SELECT 	@begindt, @enddt  
  
  
-----get surveys for that period  
UPDATE 	surveyResponse 		WITH (ROWLOCK)  
SET 	offerObjectId		= 791
		, locationObjectId	= 148678  
WHERE objectId IN (  
					SELECT 
							sr.objectid
							--,*--sr.objectid
							--, l.locationNumber
							--, sr.ipAddress
							--, sr.beginDateUTC  
					FROM   
							location l 				WITH (NOLOCK)  
						JOIN 
							surveyResponse sr 		WITH (NOLOCK)  
									 ON l.objectId = sr.locationObjectId  
						JOIN 
							surveyResponseAnswer sra WITH (NOLOCK)  
									ON sr.objectId	= sra.surveyResponseObjectId  
					WHERE  
							l.organizationObjectId = 569  
						--AND 
						--	modeType = 2  
						AND 
							l.objectId IN (
											SELECT 
													locationObjectId  
											FROM   
													dbo.Ufn_app_locationsincategoryoftype(1003)  
											WHERE  
													locationCategoryObjectId IN	( 14998, 14999 )
										  )--Canada  
						AND 
							( offerObjectId != 791 AND locationObjectId != 148678 )
							
						AND 
							begindateutc BETWEEN @begindt 
											AND  @enddt 
											
						AND 
							sra.datafieldobjectid = 25757  
						AND 
							l.enabled 	= 1  
						AND 
							l.hidden 	= 0  
						AND 
							sr.complete = 1  
						AND 
							( sra.numericValue < .50 OR sra.numericValue > 500.00)   
					)  
------------  
--exec [dbo].[usp_cust_McDAmountSpent]  
  
--chk  
--SELECT * from surveyresponse  
--WHERE offercodeobjectid=298930  
  
--SELECT *   
--from location l  
--JOIN offercode oc  
--on l.objectid=oc.locationobjectid  
--WHERE offercode='0000004'  
  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

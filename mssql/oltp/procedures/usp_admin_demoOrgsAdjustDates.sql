SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_demoOrgsAdjustDates]
AS  
  
/*************************  Adjust Demo Orgs Weekly  ******************************  
  
 Production 
 usp_admin_demoOrgsAdjustDates

 DemoServer
 usp_admin_demoOrgsAdjustDates_vDemoServer 
   
 Runs on OLTP; replicated stored proc  
  
  
 Every week this adjusts demo Orgs survey data by rolling  
 the dates forward by 1 week .  
   
   REMOVED 		938	= Monitor™ Demo - Call Center		REMOVED
   941 	= ABC Call Centers  
   995 	= z- test Dashboard 2.0 Org  
   992 	= ABC Restaurants  
   1003 = ABC Retail Demo
   1204	= Hashtags Org
   1303 = Hashtags Food
   1407 = ABC Fleet Services
   1389 = Call Center Demo Mike
   1413 = ABC Healthcare Mike/Andrew
   
   
 
 History:
	2.20.2013  Tad Peterson	
		- changed to global temp tables
		- changed to key everything off of beginDateUTC
		- wrapped job with StartSuccessFailure Notify
		
	4.4.2013	Tad Peterson	
		- added org 938 as per Spencer Morris request
	
	12.11.2013	Tad Peterson
		- added org 1204 as per Payden Van Brocklin
		- rolled exist id up 28 days as prep
		- removed OrgId 938 from processing
		
	05.13.2014	Tad Peterson
		-- added org 1303 as per Spencer Anderson
		-- altered query with exclusion reason
		-- removed org table join
		
	07.26.2014 	Tad Peterson
		-- modified to be a replicated stored proc ( DemoServer Environment )
		
	09.11.2014	Tad Peterson
		-- added by Michael Taylor org 1407 - ABC Fleet Services
		-- added by Michael Taylor org 1389 - Call Center Demo Mike
		-- added by Michael Taylor org 1413 - ABC Healthcare Mike/Andrew

		
		
		
		
		
**********************************************************************************/  
 
 
DECLARE @UTCDiff	int
SET		@UTCDiff	= ( SELECT  DATEDIFF( Hour,  GETUTCDATE(), GETDATE() )	)

 
   
  
IF OBJECT_ID('tempdb..##demoOrgsUpdateSRDates') IS NOT NULL			DROP TABLE ##demoOrgsUpdateSRDates		
CREATE TABLE ##demoOrgsUpdateSRDates  
	(  
		objectId    		bigInt  
		, beginDate   		dateTime  
		, dateOfService  	dateTime  
		, beginDateUTC  	dateTime  
	)  

IF OBJECT_ID('tempdb..####demoOrgsUpdateList') IS NOT NULL			DROP TABLE ##demoOrgsUpdateList
CREATE TABLE ##demoOrgsUpdateList  
	(  
		orgId int not null primary key
	)  
  
insert into ##demoOrgsUpdateList
select	objectId
from	Organization with (nolock)
where	objectId in (
		941
		, 995
		, 992
		, 1003
		, 1204
		, 1303 
		, 1407
		, 1389
		, 1413
		, 1570
		, 1413)
		and responseBehavior = 0

    
INSERT INTO ##demoOrgsUpdateSRDates   
SELECT  
		  --TOP 1   -- beginDate dateOfService beginDateUTC  
		  --* 
		  
		  -- COUNT(1)
		  
		  t10.objectId      
		  , CAST( FLOOR( CAST( DATEADD( Hour, @UTCDiff, t10.beginDateUTC ) AS FLOAT )) AS DateTime ) 		AS beginDate     
		  , DATEADD( Day, -1, DATEADD( Hour, @UTCDiff, t10.beginDateUTC ) )									AS dateOfService    
		  , t10.beginDateUTC    
    
FROM  
		surveyResponse 		t10
	JOIN  
		surveyGateway 		t20
			ON 
					t10.surveyGateWayObjectId = t20.objectId  

				AND 
					t20.OrganizationObjectId IN (select objectId from ##demoOrgsUpdateList)
				AND 
					t10.exclusionReason = 0
				
    

    
    
    
--/* /////////////////////////////////////////////////////////////////////////////////////////  
  
-----Cursor for SR Update  
  
DECLARE @objectId 	bigInt, @beginDate	dateTime, @dateOfService	dateTime, @beginDateUTC	dateTime   
  
DECLARE mycursor cursor for  
SELECT objectId, beginDate, dateOfService, beginDateUTC FROM ##demoOrgsUpdateSRDates  
  
OPEN mycursor  
FETCH next FROM mycursor INTO @objectId, @beginDate, @dateOfService, @beginDateUTC  
  
WHILE @@Fetch_Status=0  
BEGIN  
  
----*******************  W A R N I N G  ***************************  
  
  
UPDATE surveyResponse WITH (ROWLOCK)  
SET   
	beginDate		= DATEADD(wk, 1, @beginDate)  
	, dateOfService	= DATEADD(wk, 1, @dateOfService)  
	, beginDateUTC	= DATEADD(wk, 1, @beginDateUTC)  
WHERE 
	objectId		= @objectId  
  
  
----***************************************************************  
  
FETCH next FROM mycursor INTO @objectId, @beginDate, @dateOfService, @beginDateUTC  
  
END--WHILE  
CLOSE mycursor  
DEALLOCATE mycursor  
  
  
--////////////////////////////////////////////////////////////////////////////////////////// */  
   
    
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

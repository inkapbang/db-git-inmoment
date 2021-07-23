SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure [dbo].[usp_cust_CrackerBarrelVoiceComments]
 @startDate		dateTime
 ,@endDate		dateTime
 ,@orgId			int =1008
as

--exec dbo.usp_cust_CrackerBarrelVoiceComments @startdate='12/27/14', @endDate='1/30/15'
-- exec usp_cust_CrackerBarrelVoiceCommentsNew @startdate='05/28/16', @endDate='06/24/16' 
--exec usp_cust_CrackerBarrelVoiceComments @startdate='05/28/16', @endDate='06/24/16' 

/****** Object:  Table [dbo].[_Cracker]    Script Date: 11/04/2014 13:38:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_Cracker]') AND type in (N'U'))
DROP TABLE [dbo].[_Cracker]
;


/****** Object:  Table [dbo].[_crackerbarrel]    Script Date: 11/04/2014 13:38:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_crackerbarrel]') AND type in (N'U'))
DROP TABLE [dbo].[_crackerbarrel]
;




/**********************  Comment Access Retrieval Counts By Locations  **********************

	Requested by Sara Russell for Cracker Barrel.  Derek wrote the original query 
	earlier this spring.  Todd Labrum was working something similar, he talked
	with the developers to understand commentAccess.commentType = 0 indicates
	comment retrieval.

		History
			9.19.2013	Tad Peterson
				-- created, results verified by sara

select * from organization where name like '%Cracker%'
********************************************************************************************/



--SET		@orgId			= 1008
--SET		@startDate		= @begindt
--SET		@endDate		= @enddt	-- this field includes a timeStamp with it




-- Query
SELECT

		--TOP 10
		
		--t50.OrganizationObjectId	AS OrgId

		t50.objectId				AS LocationId
		, t50.Name					AS LocationName
		, COUNT(1)					AS Qnty
		
		
		
		
FROM
		CommentAccess			t10
	JOIN
		Comment					t20
			ON t10.commentObjectId = t20.objectId
	JOIN
		SurveyResponseAnswer	t30
			ON t20.surveyResponseAnswerObjectId = t30.objectId
	JOIN
		SurveyResponse			t40
			ON t30.surveyResponseObjectId = t40.objectId
	JOIN
		Location				t50
			ON t40.locationObjectId = t50.objectId
			
		
WHERE
		-- message retreival is type 0
		t10.accessType = 0
	

	and
		-- this field has a timeStamp with it, so you will need to use next day to include the day you want
		t10.time BETWEEN
							@startDate
						AND	
							
							@endDate	
	AND
		t50.organizationObjectId = @orgId					


GROUP BY
		--t50.OrganizationObjectId
		
		t50.objectId
		, t50.Name

ORDER BY

		t50.Name
						
						
						/**********************  Comment Access Retrieval Counts By Locations  **********************

	Requested by Sara Russell for Cracker Barrel.  Derek wrote the original query 
	earlier this spring.  Todd Labrum was working something similar, he talked
	with the developers to understand commentAccess.commentType = 0 indicates
	comment retrieval.

		History
			9.19.2013	Tad Peterson
				-- created, results verified by sara

select * from organization where name like '%Cracker%'
********************************************************************************************/



--SET		@orgId			= 1008
--SET		@startDate		= '20140830'
--SET		@endDate		= '20140926'	-- this field includes a timeStamp with it




-- Query


/****** Object:  Table [dbo].[_CrackerBarrelCommentAccess]    Script Date: 11/04/2014 13:37:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_CrackerBarrelCommentAccess]') AND type in (N'U'))
DROP TABLE [dbo].[_CrackerBarrelCommentAccess]
;


SELECT

		--TOP 10
		
		--t50.OrganizationObjectId	AS OrgId

		t50.objectId				AS LocationId
		, t50.Name					AS LocationName
		, COUNT(1)					AS Qnty
		
		
into _CrackerBarrelCommentAccess		
		
FROM
		CommentAccess			t10
	JOIN
		Comment					t20
			ON t10.commentObjectId = t20.objectId
	JOIN
		SurveyResponseAnswer	t30
			ON t20.surveyResponseAnswerObjectId = t30.objectId
	JOIN
		SurveyResponse			t40
			ON t30.surveyResponseObjectId = t40.objectId
	JOIN
		Location				t50
			ON t40.locationObjectId = t50.objectId
			
		
WHERE
		-- message retreival is type 0
		t10.accessType = 0
	
	AND
		-- this field has a timeStamp with it, so you will need to use next day to include the day you want
		t10.time BETWEEN
							@startDate
						AND	
							
							@endDate	
	AND
		t50.organizationObjectId = @orgId					


GROUP BY
		--t50.OrganizationObjectId
		
		t50.objectId
		, t50.Name

ORDER BY

		t50.Name
														

---
select * from _CrackerBarrelCommentAccess
select * from Organization where name like 'cracker%'

select * from Location where organizationObjectId=1008

select l.objectid,l.name,ca.Qnty 
from _CrackerBarrelCommentAccess ca left join Location l 
on l.objectid =ca.LocationId  
and l.organizationObjectId = 1008	
order by l.name 

select l.objectid, l.name, 0 as Qnty 
into _Cracker
from Location l where organizationObjectId=1008 order by name

update _Cracker 
set Qnty=
--select 
ca.Qnty from _CrackerBarrelCommentAccess ca  join _Cracker c
on ca.LocationId=c.objectId

select * from _Cracker order by name 

	
								
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

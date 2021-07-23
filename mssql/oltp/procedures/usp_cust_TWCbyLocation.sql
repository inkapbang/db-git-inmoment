SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_TWCbyLocation] 
as

--exec usp_cust_TWCbyLocation 
/****** Object:  Table [dbo].[_srreq]    Script Date: 06/29/2015 13:19:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_srreq]') AND type in (N'U'))
DROP TABLE [dbo].[_srreq]

    declare @begindt date 
    declare @enddt date
   -- set @begindt ='8/16/15'
   -- set @enddt ='8/22/15'  
set @begindt=(select DATEADD(wk, -1, DATEADD(wk, DATEDIFF(wk, 0,getdate()), -1)))   
set @enddt=(DATEADD(wk, DATEDIFF(wk, 0, getdate()), -2))
set @enddt=(DATEADD(dd,1,@enddt))
 
    select @begindt,@enddt

select surveyrequest.objectid SurveyrequestObjecid,
surveyresponse.objectid surveyresponseobjectid,
surveyresponse.offercode,
location.objectId locationobjectid,
	Location.name locationname,
		Location.locationnumber locationnumber,
	surveygateway.name surveygatewayname,
	CONVERT(datetime, CONVERT(VARCHAR(10), creationTime, 101), 101) as creationDate,
    --COUNT(*) totalRequests,
   attemptCount totalAttempts,
   case when failureReason in (0,1, 10, 11) and lastAttemptResult=0 then 1 else 0  end as ERROR,
   case when failureReason=2 and lastAttemptResult=0 then 1 else 0 end as INVALID_CONTACT_INFO,
   case when failureReason=3 and lastAttemptResult=0 then 1 else 0 end as INVALID_PARAMS,
   case when failureReason=4 and lastAttemptResult=0 then 1 else 0 end as DUPLICATE,
   case when failureReason=5 and lastAttemptResult=0 then 1 else 0 end as UNSUBSCRIBED,
   case when failureReason=6 and lastAttemptResult=0 then 1 else 0 end as DECLINED,
   case when failureReason=7 and lastAttemptResult=0 then 1 else 0 end as EXPIRED,
   case when failureReason=8 and lastAttemptResult=0 then 1 else 0 end as OUTSIDE_CALL_WINDOW,
   case when failureReason=12 and lastAttemptResult=0 then 1 else 0 end as LOCATION_MAX,
   case when failureReason=13 and lastAttemptResult=0 then 1 else 0 end as REPEAT_LIMIT,
   case when failureReason in (14, 15) and lastAttemptResult=0 then 1 else 0 end as SYSTEM_ISSUE,
   case when failureReason=16 and lastAttemptResult=0 then 1 else 0 end as OFFER_MAX,
   case when failureReason=17 and lastAttemptResult=0 then 1 else 0 end as INVALID_TIME_ZONE,
   -- -------AttemptResultType-------------
   case when lastAttemptResult=1 then 1 else 0 end as LIVE_ANSWER,
   case when lastAttemptResult=2 then 1 else 0 end as ANSWERING_MACHINE,
   case when lastAttemptResult=3 then 1 else 0 end as FAX,
   case when lastAttemptResult=4 then 1 else 0 end as BUSY,
   case when lastAttemptResult=5 then 1 else 0 end as NO_ANSWER,
   case when lastAttemptResult=6 then 1 else 0 end as OPERATOR,
   case when lastAttemptResult=7 then 1 else 0 end as INFORMATION_TONE,
   case when lastAttemptResult=8 then 1 else 0 end as NO_ATTEMPT,
   case when lastAttemptResult=9 then 1 else 0 end as LINE_FAILURE,
   case when lastAttemptResult=10 then 1 else 0 end as DISCONNECT,
   case when lastAttemptResult=11 then 1 else 0 end as UNKNOWN,
   case when lastAttemptResult in (1, 2, 3, 8, 9, 10, 11) then 1 else 0 end as connectedCalls,
   case when lastAttemptResult in (8, 10, 11) then 1 else 0 end as undeterminedCalls,
   case when (lastAttemptResult=0) then 1 else 0 end as rejectedRecords,
   case when (lastAttemptResult<>0) then 1 else 0 end as acceptedRecords,
   case when attemptCount<1 and failureReason<1 then 1 else 0 end as systemReportBackFailure,
   case when attemptCount>0 then 1 else 0 end as requestsWithAttempts,
   case when SurveyRequest.surveyResponseObjectId is not null then 1 else 0 end as responseStarted,
   minutes as surveyMinutes,
   -- AVG(minutes) as avgMinutes,
   case when surveyresponse.complete=1 then 1 else 0 end as completedSurvey
   --(select srqp.param_name,
   --case when srqp.param_name='d' then srqp.param_value else NULL end as 'd'
   --(select srqp.param_value  as d from SurveyRequestParam srqp where param_name ='d')
   --srqp.*
   
   into _srreq
from SurveyRequest
join SurveyGateway
    on SurveyGateway.objectId=SurveyRequest.surveyGatewayObjectId
left outer join Location
	on Location.objectId = SurveyRequest.locationObjectId
left outer join SurveyResponse
	on SurveyRequest.surveyResponseObjectId=SurveyResponse.objectId
--	left join SurveyRequestParam srqp
--on SurveyRequest.objectId=srqp.SurveyRequestObjectId
where
	creationTime between @begindt and @enddt
	--and SurveyRequest.surveyGatewayObjectId in (1052)
		and SurveyRequest.surveyGatewayObjectId in (select objectId from SurveyGateway where organizationObjectId=1134)
--GROUP BY
--location.objectId,
--	Location.name,
--	SurveyGateway.name,
--	CONVERT(VARCHAR(10), creationTime, 101)
ORDER BY
surveyrequest.objectid,
--location.objectId,
--	Location.name,
--	SurveyGateway.name,
	creationDate
	
	--select * from location where objectid =1095135
	
	--select * from offercode where offercode='2512652'
	
	--select * from surveyrequestParam where surveyrequestobjectid=1585766657
	
alter table _srreq add d varchar(255);
alter table _srreq add TS varchar(255);
alter table _srreq add TE varchar(255);
alter table _srreq add OC varchar(255);

alter table _srreq add AN varchar(255);
alter table _srreq add CC varchar(255);
alter table _srreq add VDN varchar(255);
alter table _srreq add S varchar(255);

alter table _srreq add SN varchar(255);
alter table _srreq add A varchar(255);
alter table _srreq add M varchar(255);
alter table _srreq add CIP varchar(255);

alter table _srreq add ANM varchar(255);
alter table _srreq add CAN varchar(255);
alter table _srreq add V varchar(255);
alter table _srreq add HSD varchar(255);

alter table _srreq add P varchar(255);
alter table _srreq add MRR varchar(255);
alter table _srreq add CT varchar(255);
alter table _srreq add CTB varchar(255);

alter table _srreq add E varchar(255);
alter table _srreq add CCN varchar(255);
alter table _srreq add EB varchar(255);
alter table _srreq add SC varchar(255);

alter table _srreq add SS varchar(255);
alter table _srreq add SITEID varchar(255);
alter table _srreq add LNG varchar(255);
alter table _srreq add type varchar(255);

alter table _srreq add TZ varchar(255);
alter table _srreq add UCID varchar(255);
alter table _srreq add TECHTYPE varchar(255);
alter table _srreq add SysPRN varchar(255);

alter table _srreq add mod varchar(255);
alter table _srreq add typ varchar(255);
----
update _srreq 
set d=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='d'

update _srreq 
set TS=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='TS'

update _srreq 
set TE=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='TE'

update _srreq 
set OC=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='OC'
---
update _srreq 
set AN=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='AN'

update _srreq 
set CC=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='CC'

update _srreq 
set VDN=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='VDN'

update _srreq 
set S=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='S'

update _srreq 
set SN=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='SN'

update _srreq 
set A=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='A'

update _srreq 
set M=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='M'

update _srreq 
set CIP=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='CIP'

---
update _srreq 
set ANM=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='ANM'

update _srreq 
set CAN=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='CAN'

update _srreq 
set V=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='V'

update _srreq 
set HSD=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='HSD'

update _srreq 
set P=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='P'

update _srreq 
set MRR=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='MRR'

update _srreq 
set CT=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='CT'

update _srreq 
set CTB=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='CTB'

update _srreq 
set E=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='E'


update _srreq 
set CCN=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='CCN'


update _srreq 
set EB=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='EB'


update _srreq 
set SC=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='SC'

update _srreq 
set SS=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='SS'

update _srreq 
set SITEID=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='SITEID'

update _srreq 
set LNG=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='LNG'

update _srreq 
set [type]=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='type'

update _srreq 
set TZ=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='TZ'


update _srreq 
set UCID=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='UCID'


update _srreq 
set TECHTYPE=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='TECHTYPE'


update _srreq 
set SysPRN=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='SysPRN'

update _srreq 
set mod=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='mod'

update _srreq 
set typ=srqp.param_value
from surveyrequestparam  srqp with (nolock) join _srreq with (nolock)
on _srreq.SurveyrequestObjecid=srqp.SurveyRequestObjectId where param_name ='typ'

delete from _srreq where surveyresponseobjectid is not null and offercode is null

select * from _srreq
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

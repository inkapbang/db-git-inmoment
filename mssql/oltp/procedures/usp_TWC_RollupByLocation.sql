SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure dbo.usp_TWC_RollupByLocation
@begindt datetime, @enddt datetime
as

--exec dbo.usp_TWC_RollupByLocation @begindt='2015-05-01' , @enddt='2015-06-11'

select
      location.objectid,Location.name,
      CONVERT(datetime, CONVERT(VARCHAR(10), creationTime, 101), 101) as creationDate,
    COUNT(*) totalRequests,
    SUM(attemptCount) totalAttempts,
    SUM(case when failureReason in (0,1, 10, 11) and lastAttemptResult=0 then 1 else 0 end) as ERROR,
    SUM(case when failureReason=2 and lastAttemptResult=0 then 1 else 0 end) as INVALID_CONTACT_INFO,
    SUM(case when failureReason=3 and lastAttemptResult=0 then 1 else 0 end) as INVALID_PARAMS,
    SUM(case when failureReason=4 and lastAttemptResult=0 then 1 else 0 end) as DUPLICATE,
    SUM(case when failureReason=5 and lastAttemptResult=0 then 1 else 0 end) as UNSUBSCRIBED,
    SUM(case when failureReason=6 and lastAttemptResult=0 then 1 else 0 end) as DECLINED,
    SUM(case when failureReason=7 and lastAttemptResult=0 then 1 else 0 end) as EXPIRED,
    SUM(case when failureReason=8 and lastAttemptResult=0 then 1 else 0 end) as OUTSIDE_CALL_WINDOW,
    SUM(case when failureReason=12 and lastAttemptResult=0 then 1 else 0 end) as LOCATION_MAX,
    SUM(case when failureReason=13 and lastAttemptResult=0 then 1 else 0 end) as REPEAT_LIMIT,
    SUM(case when failureReason in (14, 15) and lastAttemptResult=0 then 1 else 0 end) as SYSTEM_ISSUE,
    SUM(case when failureReason=16 and lastAttemptResult=0 then 1 else 0 end) as OFFER_MAX,
    SUM(case when failureReason=17 and lastAttemptResult=0 then 1 else 0 end) as INVALID_TIME_ZONE,
    -------AttemptResultType-------------
    SUM(case when lastAttemptResult=1 then 1 else 0 end) as LIVE_ANSWER,
    SUM(case when lastAttemptResult=2 then 1 else 0 end) as ANSWERING_MACHINE,
    SUM(case when lastAttemptResult=3 then 1 else 0 end) as FAX,
    SUM(case when lastAttemptResult=4 then 1 else 0 end) as BUSY,
    SUM(case when lastAttemptResult=5 then 1 else 0 end) as NO_ANSWER,
    SUM(case when lastAttemptResult=6 then 1 else 0 end) as OPERATOR,
    SUM(case when lastAttemptResult=7 then 1 else 0 end) as INFORMATION_TONE,
    SUM(case when lastAttemptResult=8 then 1 else 0 end) as NO_ATTEMPT,
    SUM(case when lastAttemptResult=9 then 1 else 0 end) as LINE_FAILURE,
    SUM(case when lastAttemptResult=10 then 1 else 0 end) as DISCONNECT,
    SUM(case when lastAttemptResult=11 then 1 else 0 end) as UNKNOWN,
    SUM(case when lastAttemptResult in (1, 2, 3, 8, 9, 10, 11) then 1 else 0 end) as connectedCalls,
    SUM(case when lastAttemptResult in (8, 10, 11) then 1 else 0 end) as undeterminedCalls,
    SUM(case when (lastAttemptResult=0) then 1 else 0 end) as rejectedRecords,
    SUM(case when (lastAttemptResult<>0) then 1 else 0 end) as acceptedRecords,
    SUM(case when attemptCount<1 and failureReason<1 then 1 else 0 end) as systemReportBackFailure,
    SUM(case when attemptCount>0 then 1 else 0 end) as requestsWithAttempts,
    SUM(case when SurveyRequest.surveyResponseObjectId is not null then 1 else 0 end) as responseStarted,
    SUM(minutes) as surveyMinutes,
    AVG(minutes) as avgMinutes,
    SUM(case when complete=1 then 1 else 0 end) as completedSurvey
from SurveyRequest
join SurveyGateway
    on SurveyGateway.objectId=SurveyRequest.surveyGatewayObjectId
left outer join SurveyRequestParam
      on SurveyRequestParam.surveyRequestObjectId = SurveyRequest.objectId
      and SurveyRequestParam.param_name = 'OC'
left outer join OfferCode
	on OfferCode.offerCode=SurveyRequestParam.param_value
left outer join Location
      on Location.objectId = OfferCode.locationObjectId
      and Location.hidden=0
      and Location.enabled=1
left outer join SurveyResponse
      on SurveyRequest.surveyResponseObjectId=SurveyResponse.objectId
where
      --creationTime between '2015-05-01' and '2015-06-11'
      creationTime between @begindt and @enddt
      and SurveyRequest.surveyGatewayObjectId in (select objectId from SurveyGateway where organizationObjectId=1134) and location.name is not null
GROUP BY
	 Location.objectId
      ,Location.name,
      CONVERT(VARCHAR(10), creationTime, 101)
ORDER BY
      Location.name,
      creationDate
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

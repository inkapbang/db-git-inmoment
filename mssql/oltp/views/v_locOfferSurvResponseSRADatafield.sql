SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view [dbo].[v_locOfferSurvResponseSRADatafield] as 
	select 
		l.objectid as lobjectid,
		l.name,
		l.organizationobjectid as lorgid,
		l.hidden,
		l.enabled,
		sr.offercode,
		sr.offerobjectid as offerobjectid,
		sr.objectid srobjectid,
		sr.surveygatewayobjectid,
		sr.ani,sr.begindate,
		sr.complete,
		sr.surveyobjectid,
		sr.redemptioncode,
		sr.begintime,
		sr.minutes,
		sr.modetype,
		sr.loyaltynumber,
		sr.ipaddress,
		sra.objectid as sraobjectid,
		sra.sequence,
		sra.numericvalue,
		sra.textvalue,
		df.objectid as dfobjectid,
		df.name as datafieldname --,df.reporttext
	from location l with (nolock) 
	join surveyresponse sr with (nolock) 
		on sr.locationObjectId = l.objectId 
	join surveyresponseanswer sra with (nolock) 
		on sr.objectid = sra.surveyresponseobjectid 
	join datafield df with (nolock) 
		on df.objectid = sra.datafieldobjectid 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

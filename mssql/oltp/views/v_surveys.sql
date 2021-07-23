SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view [dbo].[v_surveys] as
	select 
		s.objectid as sObjectid,
		s.name,
		s.description,
		s.organizationObjectid,
		s.version,
		sr.objectid as srObjectid,
		sr.surveyGatewayobjectid,
		sr.ani,
		sr.begindate,
		sr.complete,
		sr.dateofservice,
		sr.redemptioncode,
		sr.employeecode,
		sr.begintime,
		sr.minutes,
		sr.version as srverson,
		sr.modetype,
		sr.ipaddress,
		sra.objectid as sraObjectid,
		sra.binarycontentobjectid,
		sra.sequence,
		sra.numericvalue,
		sra.textvalue,
		sra.dateValue,
		sra.BooleanValue,
		sra.version as sraversion,
		sra.datafieldobjectid,
		sra.datafieldoptionObjectid
	from survey s 
	join surveyresponse sr (nolock)
		on s.objectid=sr.surveyobjectid 
	join surveyresponseanswer sra
		on sr.objectid=sra.surveyresponseobjectid
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

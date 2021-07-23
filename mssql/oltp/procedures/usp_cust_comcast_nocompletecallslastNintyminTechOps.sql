SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_comcast_nocompletecallslastNintyminTechOps]
as

/*
This procedure checks listed comcast gateways to see of calls have completed in last thirty min
if not sends out alerts

Bob Luther 09/21/10
exec dbo.usp_cust_comcast_nocompletecallslastthirtymin
select getutcdate()
*/

--initialize
declare @startdt DATETIME

	DECLARE @delim char(1)
	SET @delim = CHAR(9)

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_res]') AND type in (N'U'))
DROP TABLE [dbo].[_res]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_res2]') AND type in (N'U'))
DROP TABLE [dbo].[_res2]

create table _res(surveygatewayobjectid int)
--insert into _res SELECT 1322
insert into _res SELECT 1788
--insert into _res SELECT 1052
--insert into _res SELECT 1424
--insert into _res SELECT 1926
--insert into _res SELECT 2011
--insert into _res SELECT 2014
insert into _res SELECT 2022
--insert into _res SELECT 1678
--insert into _res SELECT 1679

SELECT * FROM _res

set @startdt=dateadd(mi,-90,getutcdate());
--select @startdt;

--get data
with mycte as(
select * from surveyresponse with (nolock)
where begindateUTC >@startdt
AND surveyGatewayObjectId IN (
SELECT surveygatewayobjectid FROM _res
)
AND complete=1
)
select * 
into _res2
from mycte
select * from _res2

--if no completed calls in 30 min alert
--select r.surveygatewayobjectid from _res r LEFT JOIN _res2 r2 ON r.surveygatewayobjectid=r2.surveygatewayobjectid WHERE r2.surveygatewayobjectid IS null
if  exists(select r.surveygatewayobjectid from _res r LEFT JOIN _res2 r2 ON r.surveygatewayobjectid=r2.surveygatewayobjectid WHERE r2.surveygatewayobjectid IS null)
begin 
--		EXEC msdb.dbo.sp_send_dbmail
--		@profile_name = 'Alert', 
--		@recipients = 'bluther@mshare.net;wfrazier@mshare.net;mchriss@mshare.net;asmith@mshare.net;ecdietz@mshare.net',--;wfrazier@mshare.net;mchriss@mshare.net',
--		@subject = 'No Surveys from gateways in last 30 min',
--		@body = 'See attached file for surveygateways without surveys in last thirty minutes ',
--		@importance = 'High'
--		--asmith@mshare.net;ecdietz@mshare.net;
		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = 'bluther@mshare.net;wfrazier@mshare.net;mchriss@mshare.net;asmith@mshare.net;ecdietz@mshare.net',
		@subject = 'No Surveys from gateways Status',
		@body = 'The attached file contains the results from [dbo].[usp_cust_comcast_nocompletecallslastNintyminTechOps].',
		@query = 'select r.surveygatewayobjectid,sg.name  from _res r LEFT JOIN _res2 r2 ON r.surveygatewayobjectid=r2.surveygatewayobjectid join surveygateway sg on sg.objectid=r.surveygatewayobjectid WHERE r2.surveygatewayobjectid IS null',
		@query_result_width = 32767,
		@exclude_query_output = 1,
		@execute_query_database = 'mindshare',
		@attach_query_result_as_file = 1,
		@query_result_separator = @delim,
		@query_attachment_filename = 'NoSurveys.csv',
		@importance = 'High'

end

--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_res]') AND type in (N'U'))
--DROP TABLE [dbo].[_res]
--
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_res2]') AND type in (N'U'))
--DROP TABLE [dbo].[_res2]
-----------
--SELECT * FROM _res2 where surveygatewayobjectid in(
--2022,
--1679,
--2014,
--1926
--)
--select r.surveygatewayobjectid,sg.name  from _res r LEFT JOIN _res2 r2 ON r.surveygatewayobjectid=r2.surveygatewayobjectid join surveygateway sg on sg.objectid=r.surveygatewayobjectid WHERE r2.surveygatewayobjectid IS null
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

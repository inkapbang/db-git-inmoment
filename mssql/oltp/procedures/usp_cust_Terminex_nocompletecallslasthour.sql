SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_Terminex_nocompletecallslasthour]
as

/*
This procedure checks listed comcast gateways to see of calls have completed in last thirty min
if not sends out alerts

Bob Luther 09/21/10
exec [dbo].[usp_cust_Terminex_nocompletecallslasthour]
select getutcdate()
*/

--initialize
declare @startdt DATETIME

	DECLARE @delim char(1)
	SET @delim = CHAR(9)

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_resterm]') AND type in (N'U'))
DROP TABLE [dbo]._resterm

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_resterm2]') AND type in (N'U'))
DROP TABLE [dbo].[_resterm2]

create table _resterm(surveygatewayobjectid int)
insert into _resterm SELECT 1669
insert into _resterm SELECT 1044


--SELECT * FROM _res

set @startdt=dateadd(mi,-70,getutcdate());
--select @startdt;

--get data
with mycte as(
select * from surveyresponse with (nolock)
where begindateUTC >@startdt
AND surveyGatewayObjectId IN (
SELECT surveygatewayobjectid FROM _resterm
)
AND complete=1
)
select * 
into _resterm2
from mycte

select * from _resterm
select * from _resterm2

--if no completed calls in 60 min alert
--select r.surveygatewayobjectid from _res r LEFT JOIN _res2 r2 ON r.surveygatewayobjectid=r2.surveygatewayobjectid WHERE r2.surveygatewayobjectid IS null
if  exists(select r.surveygatewayobjectid from _resterm r LEFT JOIN _resterm2 r2 ON r.surveygatewayobjectid=r2.surveygatewayobjectid WHERE r2.surveygatewayobjectid IS null)
begin 
--		EXEC msdb.dbo.sp_send_dbmail
--		@profile_name = 'Alert', 
--		@recipients = 'bluther@mshare.net;wfrazier@mshare.net;mchriss@mshare.net;asmith@mshare.net;ecdietz@mshare.net',--;wfrazier@mshare.net;mchriss@mshare.net',
--		@subject = 'No Surveys from gateways in last 30 min',
--		@body = 'See attached file for surveygateways without surveys in last thirty minutes ',
--		@importance = 'High'
--		--asmith@mshare.net;ecdietz@mshare.net;
--		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = 'bluther@mshare.net;wfrazier@mshare.net;trees@mshare.net',
		@subject = 'No Surveys from gateways Status',
		@body = 'The attached file contains the results from [dbo].[usp_cust_Terminex_nocompletecallslasthour].',
		@query = 'select r.surveygatewayobjectid,sg.name  from _resterm r LEFT JOIN _resterm2 r2 ON r.surveygatewayobjectid=r2.surveygatewayobjectid join surveygateway sg on sg.objectid=r.surveygatewayobjectid WHERE r2.surveygatewayobjectid IS null',
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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC [Monitor].[LongRunningTransaction_OpsView] (@critical int)
as
DECLARE @subject varchar(200), @body nvarchar(MAX), @longestSpid int, @cmd nvarchar(4000), @xml NVARCHAR(MAX),@subjectName 	varchar(max)
,@recipientList	varchar(max),@dbProfileName	varchar(max)


SELECT top 1 @longestSpid = st.session_id
FROM sys.dm_tran_active_transactions at
LEFT JOIN sys.dm_tran_session_transactions st 
    ON at.transaction_id = st.transaction_id
LEFT JOIN sys.dm_tran_database_transactions dt
	on at.transaction_id = dt.transaction_id
where DB_NAME(dt.database_id) not in ('activemqdb','outboundqactivemqdb','tempdb','acitveMQPlatform')
and datediff(MINUTE,transaction_begin_time,GETDATE()) > @critical
ORDER BY transaction_begin_time

--if @longestSpid is not null
--begin
--IF object_id('tempdb..#output') IS NOT NULL
--drop table #output
--CREATE TABLE #output (EventType varchar(4000),Params varchar(4000),	EventInfo varchar(max))
--DECLARE @query varchar(max)
--set @cmd = 'dbcc inputbuffer('+cast(@longestSpid as varchar)+')'

----print @cmd
--Insert into #output
--exec sp_executesql @cmd

--select @query = EventInfo from #output

--select @cmd = 'kill ' + CAST(@longestSpid as varchar)
----print @cmd
--exec sp_executesql @cmd

--SET @body = '<body><h1>The following query was automatically terminated at '+cast(getdate() as varchar)+'</h1><BR><BR><DIV>'+@query+'</DIV></body>'
--SET @dbProfileName 	= 'Notification'
--SET @recipientList	= 'kmciff@mshare.net;dba@mshare.net;qa@mshare.net;developers@mshare.net;devops@mshare.net;' -- use this for live results
--SET @subjectName	= 'Long Running Query Killed'

--EXEC msdb.dbo.sp_send_dbmail
--@profile_name 	= @dbProfileName 	-- replace with your SQL Database Mail Profile 
--, @body 		= @body
--, @body_format 	='HTML'
--, @recipients 	= @recipientList 		-- replace with your email address
--, @subject 		= @subjectName ;

--end

DECLARE @diff int
SELECT top 1 @diff = datediff(MINUTE,transaction_begin_time,GETDATE())
FROM sys.dm_tran_active_transactions at
LEFT JOIN sys.dm_tran_session_transactions st 
    ON at.transaction_id = st.transaction_id
LEFT JOIN sys.dm_tran_database_transactions dt
	on at.transaction_id = dt.transaction_id
where DB_NAME(dt.database_id)  not in ('activemqdb','outboundqactivemqdb','tempdb','acitveMQPlatform')
ORDER BY transaction_begin_time

Select 'Longest Tran Time in minutes: '+ cast(@diff as varchar)+' |  ''Longest Transaction Time''='+ cast(@diff as varchar) as output, 0 as stateValue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

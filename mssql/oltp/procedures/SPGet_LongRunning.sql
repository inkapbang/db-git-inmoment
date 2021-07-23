SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC SPGet_LongRunning
AS
--exec SPGet_LongRunning
IF OBJECT_ID('tempdb..#CaptureLongProcessWithObjectName') IS NOT NULL
DROP TABLE #CaptureLongProcessWithObjectName

--Capturing All long running operations in Temp table
SELECT
ObjectName
,statement_text
,DatabaseName
,CPU_Time
,RunningMinutes
,Percent_Complete
,RunningFrom
,RunningBy
,SessionID
,BlockingWith
,reads
,writes
,[program_name]
,login_name
,status
,last_request_start_time
,logical_reads
INTO
#CaptureLongProcessWithObjectName
FROM
WhatIsGoingOn
WHERE
--want to capture each query/SP which is taking more than 1 min.
--you can increase limit as per your need
RunningMinutes>1

--Please note that full/differential/log backup may take more time
--if you wish, you can exclude it by filtering either by ObjectName
--or by Statement_Text as per your need

--separating record in two temp table
--based on with and without ObjectName
IF OBJECT_ID('tempdb..#CaptureLongProcessWithoutObjectName') IS NOT NULL
DROP TABLE #CaptureLongProcessWithoutObjectName

SELECT
*
INTO
#CaptureLongProcessWithoutObjectName
FROM
#CaptureLongProcessWithObjectName
WHERE
ObjectName IS NULL

DELETE FROM
#CaptureLongProcessWithObjectName
WHERE
ObjectName IS NULL

ALTER TABLE #CaptureLongProcessWithObjectName
ADD AutoID INT IDENTITY(1,1)

ALTER TABLE #CaptureLongProcessWithoutObjectName
ADD AutoID INT IDENTITY(1,1)

DECLARE @Count INT,@CountMax INT
SET @Count=1

SELECT @CountMax=COUNT(*) FROM #CaptureLongProcessWithoutObjectName

--if there is no ObjectName came by default
--generating ObjectName,
--generally it happens in Ad-Hoc query of in some system processes
WHILE @Count <= @CountMax
BEGIN
DECLARE @Session INT
SELECT
@Session=SessionID
FROM
#CaptureLongProcessWithoutObjectName
WHERE AutoID=@Count

DECLARE
@InputBuffer TABLE
(
EventType NVARCHAR(MAX),
Parameters NVARCHAR(MAX),
EventInfo NVARCHAR(MAX)
)
DECLARE @Command NVARCHAR(MAX),@ObjectName VARCHAR(MAX)

SELECT  @Command = 'DBCC INPUTBUFFER(' + CAST(@Session AS VARCHAR) + ') WITH NO_INFOMSGS'

INSERT INTO @InputBuffer
EXEC (@Command)

SELECT
@ObjectName = LEFT(REPLACE(REPLACE(REPLACE(EventInfo, CHAR(13), ''), CHAR(10),''), '  ', ' '),50) + '.....'
FROM @InputBuffer

UPDATE
#CaptureLongProcessWithoutObjectName
SET
ObjectName=@ObjectName
WHERE
AutoID=@Count

SELECT @Count=@Count+1
END

--inserting all long running query/sp into table
INSERT INTO LongRunningCapture (
ObjectName
,statement_text
,DatabaseName
,CPU_Time
,RunningMinutes
,Percent_Complete
,RunningFrom
,RunningBy
,SessionID
,BlockingWith
,reads
,writes
,[program_name]
,login_name
,status
,last_request_start_time
,logical_reads
)
SELECT
ObjectName
,statement_text
,DatabaseName
,CPU_Time
,RunningMinutes
,Percent_Complete
,RunningFrom
,RunningBy
,SessionID
,BlockingWith
,reads
,writes
,[program_name]
,login_name
,status
,last_request_start_time
,logical_reads
FROM
#CaptureLongProcessWithObjectName
UNION ALL
SELECT
ObjectName
,statement_text
,DatabaseName
,CPU_Time
,RunningMinutes
,Percent_Complete
,RunningFrom
,RunningBy
,SessionID
,BlockingWith
,reads
,writes
,[program_name]
,login_name
,status
,last_request_start_time
,logical_reads
FROM
#CaptureLongProcessWithoutObjectName;
select * from LongRunningCapture
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

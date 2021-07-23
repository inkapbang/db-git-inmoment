SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_maint_SQL_ErrorLog_Alert]
@Minutes [int] = NULL  
AS
BEGIN
SET NOCOUNT ON;
DECLARE @ERRORMSG varchar(8000)
DECLARE @SNO INT
DECLARE @Mins INT





IF @Minutes IS NULL  -- If the optional parameter is not passed, @Mins value is set to 6
 SET @Mins = 6
ELSE
 SET @Mins = @Minutes + 1

DECLARE @FROMTIME DATETIME,@TOTIME DATETIME
SET @TOTIME = GETDATE()
SET @FROMTIME = DATEADD(mi, -1 * @Mins, @TOTIME)


--CREATE TABLE _ErrorLog_Tbl (LogDate DATETIME, ProcessInfo VARCHAR(50),[Text] VARCHAR(4000))
TRUNCATE TABLE _ErrorLog_Tbl


INSERT INTO _ErrorLog_Tbl
EXEC master..xp_ReadErrorLog 0, 1, NULL, NULL, @FROMTIME, @TOTIME

INSERT INTO _ErrorLog_Tbl
EXEC master..xp_ReadErrorLog 1, 1, NULL, NULL, @FROMTIME, @TOTIME



DELETE FROM _ErrorLog_Tbl
WHERE 
 ProcessInfo in ('Backup','Logon')
 OR (([Text] LIKE '%Intel X86%')
 OR ([Text] LIKE '%Copyright%')
 OR ([Text] LIKE '%All rights reserved.%')
 OR ([Text] LIKE '%Server Process ID is %')
 OR ([Text] LIKE '%Logging SQL Server messages in file %')
 OR ([Text] LIKE '%Errorlog has been reinitialized%')
 OR ([Text] LIKE '%This instance of SQL Server has been using a process ID %')
 OR ([Text] LIKE '%Starting up database %')
 OR ([Text] LIKE '%SQL Server Listening %')
 OR ([Text] LIKE '%SQL Server is ready %')
 OR ([Text] LIKE '%Clearing tempdb %')
 OR ([Text] LIKE '%to execute extended stored procedure %')
 OR ([Text] LIKE '% was deadlocked on %')
 OR ([Text] LIKE '%Error: 1205, Severity: 13, State: 51%')
 OR ([Text] LIKE '%Analysis of database %'))



SELECT * FROM _ErrorLog_Tbl ORDER BY LogDate ASC

--SELECT  @ERRORMSG = COALESCE(@ERRORMSG + CHAR(13) , '') 
--   + CAST(LogDate AS VARCHAR(23)) + '  ' 
--   + [Text] FROM #ErrorLog_Tbl
--SELECT @ERRORMSG as Msg

TRUNCATE TABLE _ErrorLog_Tbl


RETURN 0

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_admin_AccessEventLog_DataRemovel]
AS

/******************************  Access Event Log Stored Procedure  ******************************
		
		usp_admin_AccessEventLog_DataRemoval
		
		To be executed on OLTP.  Removes entries that are older than 1 year based on
		beginning of current month.
		
		Uses a cursor to slow the deletion process down as to not swamp replication.
		Job execution should be scheduled for first friday thru sun of month.
		
		As of initial writing of script, approximately 2,600,000 rows will be removed
		during a job execution.


**************************************************************************************************/



		
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_00accessEventLog_DataRemovel') AND type = (N'U'))    DROP TABLE _00accessEventLog_DataRemovel		
CREATE TABLE _00accessEventLog_DataRemovel
	(
		rowId						bigInt Identity(1,1)
		, accessEventLogObjectId	bigInt
	)

	
INSERT INTO _00accessEventLog_DataRemovel ( accessEventLogObjectId )
SELECT
		objectId
FROM
		accessEventLog
WHERE
		timeStamp < DATEADD( m, -6, DATEADD( d, -(DATEPART(d, getDate())-1), CAST(FLOOR(CAST( getDate() AS float)) AS dateTime)))		--> any entries older than one year from beginning of current month.
ORDER BY 1 ASC


--SELECT TOP 10 * FROM _00accessEventLog_DataRemovel





/************************  Beginning of Cursor  ************************/

DECLARE @count 						int
		, @accessEventLogObjectId 	bigInt

SET @count = 0

DECLARE myCursor CURSOR FOR
SELECT accessEventLogObjectId 	 FROM _00accessEventLog_DataRemovel

OPEN myCursor
FETCH next FROM myCursor INTO @accessEventLogObjectId

WHILE @@Fetch_Status = 0
BEGIN

	  
PRINT cast(@count as varchar)+', '+cast(@accessEventLogObjectId as varchar)




----*******************  W A R N I N G  ***************************

DELETE FROM AccessEventLog	WITH (ROWLOCK)
WHERE objectId = @accessEventLogObjectId


----***************************************************************




SET @count = @count + 1
FETCH next FROM myCursor INTO @accessEventLogObjectId

END--WHILE
CLOSE myCursor
DEALLOCATE myCursor
PRINT cast(@count as varchar)+' Records Processed'



/************************  End of Cursor  ************************/




DROP TABLE _00accessEventLog_DataRemovel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

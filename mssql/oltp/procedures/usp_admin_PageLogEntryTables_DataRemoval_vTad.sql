SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_admin_PageLogEntryTables_DataRemoval_vTad]
AS

/******************************  Page Log Entry Stored Procedure  ******************************
		
		usp_admin_PageLogEntryTables_DataRemoval_vTad
		
		To be executed on OLTP.  Removes entries that are older than 1 year based on
		beginning of current month.
		
		Uses a cursor to slow the deletion process down as to not swamp replication.
		Job execution should be scheduled for second friday thru sun of month.
		
		This job removes data from pageLogEntryUserAccount, pageLogEntryOrganization
		and pageLogEntry based on pageLogEntryObjectId.  Deletes data from the order
		as listed tables.
			

**************************************************************************************************/




IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_pageLogEntry_DataRemovel') AND type = (N'U'))    DROP TABLE _pageLogEntry_DataRemovel		
CREATE TABLE _pageLogEntry_DataRemovel
	(
		rowId						bigInt Identity(1,1)
		, pageLogEntryObjectId		bigInt
	)


	
INSERT INTO _pageLogEntry_DataRemovel ( pageLogEntryObjectId )
SELECT
		objectId
FROM
		pageLogEntry
WHERE
		creationDateTime < DATEADD( m, -6, DATEADD( d, -(DATEPART(d, getDate())-1), CAST(FLOOR(CAST( getDate() AS float)) AS dateTime)))		--> any entries older than one year from beginning of current month.
ORDER BY 1 ASC





/***********************  Stored Procedure Cursor For DELETEING Old Rows In PageLogEntryUserAccount  **********/

DECLARE @count 						int
		, @pageLogEntryObjectId 	bigInt

SET @count = 0

DECLARE myCursor CURSOR FOR
SELECT pageLogEntryObjectId 	 FROM _pageLogEntry_DataRemovel

OPEN myCursor
FETCH next FROM myCursor INTO @pageLogEntryObjectId

WHILE @@Fetch_Status = 0
BEGIN

	  
PRINT cast(@count as varchar)+', '+cast(@pageLogEntryObjectId as varchar)




----*******************  W A R N I N G  ***************************

DELETE FROM PageLogEntryUserAccount	WITH (ROWLOCK)
WHERE pageLogEntryObjectId = @pageLogEntryObjectId


----***************************************************************




SET @count = @count + 1
FETCH next FROM myCursor INTO @pageLogEntryObjectId

END--WHILE
CLOSE myCursor
DEALLOCATE myCursor
PRINT cast(@count as varchar)+' Records Processed'




/******************************************************************************************************************/





/***********************  Stored Procedure Cursor For DELETEING Old Rows In PageLogEntryOrganizationalUnit  **********/

DECLARE @count2 					int
		, @pageLogEntryObjectId2 	bigInt

SET @count2 = 0

DECLARE myCursor CURSOR FOR
SELECT pageLogEntryObjectId 	 FROM _pageLogEntry_DataRemovel

OPEN myCursor
FETCH next FROM myCursor INTO @pageLogEntryObjectId2

WHILE @@Fetch_Status = 0
BEGIN

	  
PRINT cast(@count2 as varchar)+', '+cast(@pageLogEntryObjectId2 as varchar)




----*******************  W A R N I N G  ***************************

DELETE FROM PageLogEntryOrganizationalUnit	WITH (ROWLOCK)
WHERE pageLogEntryObjectId = @pageLogEntryObjectId2


----***************************************************************




SET @count2 = @count2 + 1
FETCH next FROM myCursor INTO @pageLogEntryObjectId2

END--WHILE
CLOSE myCursor
DEALLOCATE myCursor
PRINT cast(@count2 as varchar)+' Records Processed'




/******************************************************************************************************************/




/***********************  Stored Procedure Cursor For DELETEING Old Rows In PageLogEntry  **********/

DECLARE @count3 					int
		, @pageLogEntryObjectId3 	bigInt

SET @count3 = 0

DECLARE myCursor CURSOR FOR
SELECT pageLogEntryObjectId 	 FROM _pageLogEntry_DataRemovel 

OPEN myCursor
FETCH next FROM myCursor INTO @pageLogEntryObjectId3

WHILE @@Fetch_Status = 0
BEGIN

	  
PRINT cast(@count3 as varchar)+', '+cast(@pageLogEntryObjectId3 as varchar)




----*******************  W A R N I N G  ***************************

DELETE FROM PageLogEntry	WITH (ROWLOCK)
WHERE objectId = @pageLogEntryObjectId3


----***************************************************************




SET @count3 = @count3 + 1
FETCH next FROM myCursor INTO @pageLogEntryObjectId3

END--WHILE
CLOSE myCursor
DEALLOCATE myCursor
PRINT cast(@count3 as varchar)+' Records Processed'




/******************************************************************************************************************/





--Clean Up Environment
IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_pageLogEntry_DataRemovel') AND type = (N'U'))
DROP TABLE _pageLogEntry_DataRemovel		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

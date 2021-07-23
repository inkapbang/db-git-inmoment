SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--ALTER Procedure sp_BackFillOptionsAutoDeliver
CREATE Procedure [dbo].[sp_BackFillOptionsAutoDeliver]
	@userEmail			varchar(255)
	, @dataFieldId01	bigInt	
	, @dataFieldId02	bigInt	
	, @dataFieldId03	bigInt	
	, @dataFieldId04	bigInt	
	, @dataFieldId05	bigInt	
	



AS



DECLARE @xml NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)

DECLARE @subjectName 		varchar(max)
DECLARE @recipientList		varchar(max)
DECLARE @dbProfileName		varchar(max)
DECLARE @querySqlStatement	varchar(max)
DECLARE @currentDate		varchar(10)
DECLARE @attachmentName		varchar(50)
DECLARE @userEmailCombined	varchar(max)

SET @dbProfileName		=	'Internal Request'
--SET @recipientList		=	@userEmail--'tpeterson@mshare.net'	--seperated by semi-colon
SET @subjectName		=	'DataFieldOption Answers & Ids    Processed By ' + @@SERVERNAME

SET @querySqlStatement	=	'EXEC sp_BackFillOptionsAutoDeliver_CsvPortion'
SET	@currentDate		=	CONVERT(char(8), GETDATE(), 112)
SET @attachmentName		=	@currentDate + 'dataFieldOptionAnswersIds.csv'
SET @userEmailCombined	=	@userEmail + '; tpeterson@mshare.net'


-----Place query statment below
--DECLARE @dataFieldId01		bigInt
--		,  @dataFieldId02	bigInt
--		,  @dataFieldId03	bigInt
--		,  @dataFieldId04	bigInt
--		,  @dataFieldId05	bigInt

--SET		@dataFieldId01	= 56561

IF OBJECT_ID('tempdb..##dataFieldId01') IS NOT NULL		DROP TABLE ##dataFieldId01
CREATE TABLE ##dataFieldId01
	(
		value	bigInt
	)
	
INSERT INTO ##dataFieldId01
SELECT @dataFieldId01



IF OBJECT_ID('tempdb..##dataFieldId02') IS NOT NULL		DROP TABLE ##dataFieldId02
CREATE TABLE ##dataFieldId02
	(
		value	bigInt
	)
	
INSERT INTO ##dataFieldId02
SELECT @dataFieldId02


IF OBJECT_ID('tempdb..##dataFieldId03') IS NOT NULL		DROP TABLE ##dataFieldId03
CREATE TABLE ##dataFieldId03
	(
		value	bigInt
	)
	
INSERT INTO ##dataFieldId03
SELECT @dataFieldId03


IF OBJECT_ID('tempdb..##dataFieldId04') IS NOT NULL		DROP TABLE ##dataFieldId04
CREATE TABLE ##dataFieldId04
	(
		value	bigInt
	)
	
INSERT INTO ##dataFieldId04
SELECT @dataFieldId04


IF OBJECT_ID('tempdb..##dataFieldId05') IS NOT NULL		DROP TABLE ##dataFieldId05
CREATE TABLE ##dataFieldId05
	(
		value	bigInt
	)
	
INSERT INTO ##dataFieldId05
SELECT @dataFieldId05


SET @xml = CAST(( 



SELECT 	
	t01.name																			
																																					AS 'td',''
	, t01.objectId																				
																																					AS 'td',''
	, t02.objectId 																													
																																					AS 'td','' 
	, t02.name		
																																					AS 'td',''
	, t02.Sequence																													
																																					AS 'td',''
	, CASE WHEN CAST(t02.ScorePoints as varchar )IS NULL THEN 'n/a' ELSE CAST( t02.ScorePoints as varchar ) END 															
																																					AS 'td',''
	, t02.Version  																											
																																					AS 'td',''
	, t02.LabelObjectId																										
																																					AS 'td',''
	, CASE WHEN CAST(t02.OrdinalLevel as varchar )IS NULL THEN 'n/a' ELSE CAST( t02.OrdinalLevel as varchar ) END 															
																										
																																					AS 'td'
FROM 
		DataField				t01		WITH (NOLOCK)
	JOIN	
		DataFieldOption			t02		WITH (NOLOCK)		
			ON t01.objectId = t02.dataFieldObjectId
WHERE 
		dataFieldObjectId IN ( @dataFieldId01,  @dataFieldId02, @dataFieldId03, @dataFieldId04, @dataFieldId05 ) 
	
ORDER BY 
		dataFieldObjectId 	 
		, t02.sequence




FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))





-----Header Naming and Column Naming below

SET @body =											
													'<html><body><H1><font color="#4040C5">
Internal Request													
													</font></H1><br /><H4>													
BackFill Required Setup: Response Id  |  DataField Id  |  DataFieldOption Id
	
													</H4><table border = 2><tr><th> 
DataField Name							
													</th><th><font color="#FF0000"> 
DataField Id 							
													</font></th><th><font color="#FF0000"> 
DataFieldOption Id								
													</font></th><th> 
DataFieldOption Name								
													</th><th>
Sequence									
													</th><th>
ScorePoints										
													</th><th>
Version									
													</th><th>
LabelObjectId									
													</th><th>
OrdinalLevel							
													</th></tr>'    

 
 
 
 
SET @body = @body + @xml +'</table></body></html>'



EXEC msdb.dbo.sp_send_dbmail
@profile_name = @dbProfileName 	-- replace with your SQL Database Mail Profile 
, @body = @body
, @body_format ='HTML'
, @recipients = @userEmailCombined	--@recipientList 		-- replace with your email address
, @subject = @subjectName 

, @query_result_no_padding = 1
, @query_result_separator = ','
, @query_attachment_filename = @attachmentName --@resultFileName
, @query_result_header = 1
, @query_result_width = 32767
, @attach_query_result_as_file = 1
--, @execute_query_database = 'Warehouse'
, @execute_query_database = 'Mindshare'
, @query = @querySqlStatement
;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

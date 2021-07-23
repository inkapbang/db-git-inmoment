SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.Scalable_Importing_vRsP
	@DisplayInfo					int 			= 1
	, @ShowChecks					int 			= 0
	, @ValidateTableStructureOnly	int 			= 1	
	, @ValidateIdentitiesOnly		int 			= 1
	, @NetworkLocation				nvarchar(255)	= NULL	
	, @FileName_SR					varchar(255) 	= NULL
	, @FileName_SRA					varchar(255) 	= NULL
	, @FileName_SRSC				varchar(255) 	= NULL	
	, @FileName_Comment				varchar(255) 	= NULL

	, @SingleTableLoad				int 			= 0	
	, @LoadFilesOnly				int				= 0
	, @ProcessFiles					int				= 0
	


AS

/**********************************  Scalable_Importing_vRsP  **********************************

	Comments

		may need to login with sa if access denied during bulk insert.
			
		starting to build the RsP process
		
		Files cannot have NULLs; fields must be empty like the following.
		40466724101|1515762054||0|||||0|119299|253150||0


		sed -i 's/\t/|/g' /tmp/FileName_SR.csv; sed -i 's/NULL//g' /tmp/FileName_SR.csv; sed -i '$d' /tmp/FileName_SR.csv; sed -i 's/$/\r/' /tmp/FileName_SR.csv; file /tmp/FileName_SR.csv
		
		
		sed -i 's/\t/|/g' /tmp/FileName_SR.csv;
		sed -i 's/NULL//g' /tmp/FileName_SR.csv;
		sed -i '$d' /tmp/FileName_SR.csv;
		sed -i 's/$/\r/' /tmp/FileName_SR.csv;
		file /tmp/FileName_SR.csv


		-- Prep only
		USE Scalable_Import_OLTP
		DELETE FROM SurveyResponseDeleted

		DELETE FROM TermAnnotation
		DELETE FROM TagAnnotation
		DELETE FROM SurveyResponseAlert

		DELETE FROM Comment
		DELETE FROM SurveyResponseAnswer
		DELETE FROM SurveyResponse



		
		Needing
			

				
		completed
			table structures
			identity checks
			fk checks
			file name(s) variables
			re-runnable
			counts after upload
			added zero row file upload exit
			proper ids exist in files
			return a failure code when exiting early
			Load files only flag, print out select statements for troublshooting
		
			

	History
		10.08.2014	Tad Peterson
			-- started
			
		01.07.2015	Tad Peterson
			-- verified return 99 failure properly terminates and causes XACT_ABORT
			-- verified multiple servers can access files simultaneously
			
		01.15.2015	Tad Peterson
			-- added SRSC support
			
		02.05.2015	Tad Peterson
			-- load files only support
		
		02.09.2015	Tad Peterson
			-- single file loading support
			
		02.19.2015	Tad Peterson
			-- added duration processing info


*********************************************************************************************/
SET NOCOUNT ON

-- For use with RAISERROR
DECLARE @message	nvarchar(200)



-- Processing Checks
DECLARE @DisplayInfoCheck					int
DECLARE @ShowChecksCheck					int
DECLARE @ValidateTableStructureOnlyCheck	int
DECLARE @ValidateIdentitiesOnlyCheck		int
DECLARE @SingleTableLoadCheck				int
DECLARE @NetworkLocationCheck				int
DECLARE @FileName_SRCheck					int
DECLARE @FileName_SRACheck					int
DECLARE @FileName_SRSCCheck					int
DECLARE @FileName_CommentCheck				int
DECLARE @LoadFilesOnlyCheck					int
DECLARE @ProcessFilesCheck					int
DECLARE @BeginTime							dateTime
DECLARE @EndTime							dateTime
DECLARE @Duration							int
DECLARE @OverallInsertBeginTime				dateTime
DECLARE @OverallInsertEndTime				dateTime
DECLARE @OverallInsertDuration				int



SET @DisplayInfoCheck						= CASE 	WHEN @DisplayInfo						= 1			THEN 1							ELSE 0		END
SET @ShowChecksCheck						= CASE 	WHEN @ShowChecks						= 1			THEN 1							ELSE 0		END
SET @ValidateTableStructureOnlyCheck		= CASE 	WHEN @ValidateTableStructureOnly		= 1			THEN 1							ELSE 0		END
SET @ValidateIdentitiesOnlyCheck			= CASE 	WHEN @ValidateIdentitiesOnly 		    = 1			THEN 1							ELSE 0		END



SET @NetworkLocationCheck					= CASE	WHEN @NetworkLocation 					IS NULL 	THEN 0
													WHEN LEN(@NetworkLocation) 				= 0			THEN 0
													WHEN LEN(@NetworkLocation) 				> 0			THEN 1
												END


SET @FileName_SRCheck						= CASE	WHEN @FileName_SR 						IS NULL 	THEN 0
													WHEN LEN(@FileName_SR) 					= 0			THEN 0
													WHEN LEN(@FileName_SR) 					> 0			THEN 1
												END

												
SET @FileName_SRACheck						= CASE	WHEN @FileName_SRA 						IS NULL 	THEN 0
													WHEN LEN(@FileName_SRA) 				= 0			THEN 0
													WHEN LEN(@FileName_SRA) 				> 0			THEN 1
												END

												
SET @FileName_SRSCCheck						= CASE	WHEN @FileName_SRSC 					IS NULL 	THEN 0
													WHEN LEN(@FileName_SRSC) 				= 0			THEN 0
													WHEN LEN(@FileName_SRSC) 				> 0			THEN 1
												END

												
SET @FileName_CommentCheck					= CASE	WHEN @FileName_Comment 					IS NULL 	THEN 0
													WHEN LEN(@FileName_Comment) 			= 0			THEN 0
													WHEN LEN(@FileName_Comment) 			> 0			THEN 1
												END

												

SET @SingleTableLoadCheck					= CASE 	WHEN @SingleTableLoad 					IS NULL 	THEN 0
													WHEN @SingleTableLoad					!= 1		THEN 0
													WHEN @SingleTableLoad					= 1			THEN 1
												END

												

SET @LoadFilesOnlyCheck						= CASE 	WHEN @LoadFilesOnly 					IS NULL 	THEN 0
													WHEN @LoadFilesOnly						!= 1		THEN 0
													WHEN @LoadFilesOnly						= 1			THEN 1
												END

												

SET @ProcessFilesCheck						= CASE 	WHEN @ProcessFiles 						IS NULL 	THEN 0
													WHEN @ProcessFiles						!= 1		THEN 0
													WHEN @ProcessFiles						= 1			THEN 1
												END
													

													
													
													
												


-- Other variables
DECLARE @FileUploadCount						int
DECLARE @SurveyResponseConflictValue			int
DECLARE @SurveyResponseAnswerConflictValue		int
DECLARE @SurveyResponseScoreConflictValue		int
DECLARE @CommentConflictValue					int
DECLARE @SR_UnidentifiedObjectIds				int
DECLARE @SRA_UnidentifiedObjectIds				int
DECLARE @SRSC_UnidentifiedObjectIds				int
DECLARE @TableColumnList_SR						varchar(max)
DECLARE @TableColumnList_SRA					varchar(max)
DECLARE @TableColumnList_SRSC					varchar(max)
DECLARE @TableColumnList_Comment				varchar(max)
DECLARE @IdentityInsert_Statement_SR			varchar(max)
DECLARE @IdentityInsert_Statement_SRA			varchar(max)
DECLARE @IdentityInsert_Statement_SRSC			varchar(max)
DECLARE @IdentityInsert_Statement_Comment		varchar(max)
DECLARE @IdentityInsert_Statement_SR_Check		int
DECLARE @IdentityInsert_Statement_SRA_Check		int
DECLARE @IdentityInsert_Statement_SRSC_Check	int
DECLARE @IdentityInsert_Statement_Comment_Check	int



DECLARE @RowIdMin								int
DECLARE @RowIdMax								int
DECLARE @RowIdCurrent							int


DECLARE @SqlStatement							nvarchar(max)
DECLARE @SqlTableColumn							nvarchar(max)



DECLARE @Origin_Table							nvarchar(max)
DECLARE @FK_Column								nvarchar(max)
DECLARE @FK_Table								nvarchar(max)
DECLARE @FK_Referencing_Column					nvarchar(max)

DECLARE @FK_BadValue							int








-- Displays Info 
IF @DisplayInfoCheck = 1
BEGIN

	PRINT N' '
	PRINT N' '	
	PRINT N'-- Processing, Variables & Inputs '
	PRINT N' '
	PRINT N'EXEC dbo.Scalable_Importing_vRsP'
	PRINT N'	@DisplayInfo			            = 0'
	PRINT N'	, @ShowChecks                       = 0'	
	PRINT N'	, @ValidateTableStructureOnly       = 1'
	PRINT N'	, @ValidateIdentitiesOnly           = 1'
	PRINT N'    , @NetworkLocation                  = ''C:\TmpUpload\'''	
	PRINT N'    , @FileName_SR                      = ''FileName_SR.csv'''
	PRINT N'    , @FileName_SRA                     = ''FileName_SRA.csv'''
	PRINT N'    , @FileName_SRSC                    = ''FileName_SRSC.csv'''	
	PRINT N'    , @FileName_Comment                 = ''FileName_Comment.csv'''

	PRINT N'    , @SingleTableLoad                  = 0'
	PRINT N'    , @LoadFilesOnly                    = 0'	
	PRINT N'    , @ProcessFiles                     = 0'	
	PRINT N' '
	PRINT N' '
	PRINT N' '


	RETURN

	
END






-- Enables input checking
IF @ShowChecksCheck = 1
BEGIN
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  


	SELECT
				
			@ShowChecksCheck						AS ShowChecksCheck
			, @ShowChecks							AS ShowChecks
			
			, @ValidateTableStructureOnlyCheck		AS ValidateTableStructureOnlyCheck
			, @ValidateTableStructureOnly			AS ValidateTableStructureOnly
			
			, @ValidateIdentitiesOnlyCheck			AS ValidateIdentitiesOnlyCheck
			, @ValidateIdentitiesOnly				AS ValidateIdentitiesOnly
			
			, @NetworkLocationCheck					AS NetworkLocationCheck
			, @NetworkLocation						AS NetworkLocation

			, @FileName_SRCheck						AS FileName_SRCheck
			, @FileName_SR							AS FileName_SR

			, @FileName_SRACheck					AS FileName_SRACheck
			, @FileName_SRA							AS FileName_SRA

			, @FileName_SRSCCheck					AS FileName_SRSCCheck
			, @FileName_SRSC						AS FileName_SRSC

			, @FileName_CommentCheck				AS FileName_CommentCheck
			, @FileName_Comment						AS FileName_Comment

			, @SingleTableLoadCheck					AS SingleTableLoadCheck			
			, @SingleTableLoad						AS SingleTableLoad
			
			, @LoadFilesOnlyCheck					AS LoadFilesOnlyCheck
			, @LoadFilesOnly						AS LoadFilesOnly
			
			, @ProcessFilesCheck					AS ProcessFilesCheck
			, @ProcessFiles							AS ProcessFiles
			
			
END




IF @SingleTableLoadCheck = 1 AND ( SELECT @FileName_SRCheck + @FileName_SRACheck + @FileName_SRSCCheck + @FileName_CommentCheck ) != 1
BEGIN
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'SingleTableLoad flag is set to 1, but more than 1 file is present.'
	RAISERROR (@message,0,1) with NOWAIT  
	
	SET @message = 'Please adjust your inputs and reprocess.'
	RAISERROR (@message,0,1) with NOWAIT  
	
	RETURN 99

END



-- Validating Table Structure
DECLARE @RowId_Current				int 
DECLARE @RowId_Max					int 
DECLARE @ColumnName_Current			varchar(max)
DECLARE @ColumnDataType_Current		varchar(max)
DECLARE @TableStatement				varchar(max)




IF OBJECT_ID('tempdb..#DynamicTableBuild_Tmp01') IS NOT NULL			DROP TABLE #DynamicTableBuild_Tmp01		
CREATE TABLE #DynamicTableBuild_Tmp01
	(
		RowId						int Identity
		, Column_Name				varchar(225)
		, Column_Data_Type			varchar(25)
		, Is_Identity				int
	)



IF OBJECT_ID('tempdb..#DynamicTableBuild_Tmp02') IS NOT NULL			DROP TABLE #DynamicTableBuild_Tmp02	
CREATE TABLE #DynamicTableBuild_Tmp02
	(
		RowId						int Identity
		, Column_Name				varchar(225)
		, Column_Data_Type			varchar(25)
		, Is_Identity				int
		
	)



IF OBJECT_ID('tempdb..##FKeysList') IS NOT NULL			DROP TABLE ##FKeysList		
CREATE TABLE ##FKeysList 
	( 
		RowId						int Identity
		, Origin_Table				varchar(50)
		, FK_Column					varchar(50)
		, FK_Table					varchar(50)
		, FK_Referencing_Column		varchar(50)
	)

IF OBJECT_ID('tempdb..##SurveyResponseConflictDetails') IS NOT NULL			DROP TABLE ##SurveyResponseConflictDetails		
CREATE TABLE ##SurveyResponseConflictDetails 
	( 
		Item						varchar(150)
		, Conflicts					int
	)
	

IF OBJECT_ID('tempdb..##SurveyResponseAnswerConflictDetails') IS NOT NULL			DROP TABLE ##SurveyResponseAnswerConflictDetails		
CREATE TABLE ##SurveyResponseAnswerConflictDetails 
	( 
		Item						varchar(150)
		, Conflicts					int
	)
	

IF OBJECT_ID('tempdb..##SurveyResponseScoreConflictDetails') IS NOT NULL			DROP TABLE ##SurveyResponseScoreConflictDetails		
CREATE TABLE ##SurveyResponseScoreConflictDetails 
	( 
		Item						varchar(150)
		, Conflicts					int
	)
	

IF OBJECT_ID('tempdb..##CommentConflictDetails') IS NOT NULL			DROP TABLE ##CommentConflictDetails		
CREATE TABLE ##CommentConflictDetails
	( 
		Item						varchar(150)
		, Conflicts					int
	)
	
	

DECLARE @dtt10 TABLE
	(
		Value 	int
	)


	
	



-- SurveyResponse Dynamic Table Build
IF @FileName_SRCheck = 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Building SurveyResponse Table'
	RAISERROR (@message,0,1) with NOWAIT  


	INSERT INTO #DynamicTableBuild_Tmp01 ( Column_Name, Column_Data_Type, Is_Identity )
	SELECT
			c.name 			AS Column_Name
			, st.name + '(' + CASE WHEN c.max_length = - 1 THEN 'max' ELSE CAST(c.max_length AS varchar(100)) END + ')' 	AS Column_Data_Type
			, Is_Identity

	FROM 
			sys.columns AS c 
		JOIN
			sys.systypes AS st 
				ON st.xtype = c.user_type_id 
		JOIN
			sys.tables AS t 
				ON c.object_id = t.object_id 
	WHERE
			( t.name NOT IN ( 'sysdiagrams', 'DataDictionary' ) ) 
		AND 
			( st.name NOT LIKE '%sysname%' )
		AND
			t.name NOT LIKE '\_%' ESCAPE '\'
			
		/* Filters for specific table if present */
		AND	
			t.name LIKE 'SurveyResponse'
	ORDER BY 
			c.column_id		ASC




	-- Fix data type int
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'int'
	WHERE
			Column_Data_Type LIKE 'int%'



	-- Fix data type BigInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'bigInt'
	WHERE
			Column_Data_Type LIKE 'bigInt%'



	-- Fix data type BigInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'tinyInt'
	WHERE
			Column_Data_Type LIKE 'tinyInt%'



	-- Fix data type SmallInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'smallInt'
	WHERE
			Column_Data_Type LIKE 'smallInt%'



	-- Fix data type DateTime;  fix
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'dateTime'
	WHERE
			Column_Data_Type LIKE 'dateTime%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'bit'
	WHERE
			Column_Data_Type LIKE 'bit%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'float'
	WHERE
			Column_Data_Type LIKE 'float%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'timestamp'
	WHERE
			Column_Data_Type LIKE 'timestamp%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'real'
	WHERE
			Column_Data_Type LIKE 'real%'





	INSERT INTO #DynamicTableBuild_Tmp02 ( Column_Name, Column_Data_Type, Is_Identity )
	SELECT
			Column_Name
			, Column_Data_Type
			, Is_Identity			
	FROM
			#DynamicTableBuild_Tmp01
	ORDER BY
			RowId



	-- Test
	--SELECT *	FROM #DynamicTableBuild_Tmp01
	--SELECT *	FROM #DynamicTableBuild_Tmp01


	-- Identity check on table
	SET @IdentityInsert_Statement_SR_Check = ( SELECT SUM( Is_Identity )	FROM #DynamicTableBuild_Tmp02 )





	SET		@RowId_Current				= ( SELECT MIN( RowId )	FROM #DynamicTableBuild_Tmp02 )
	SET		@RowId_Max					= ( SELECT MAX( RowId )	FROM #DynamicTableBuild_Tmp02 )


	SET		@ColumnName_Current			= ( SELECT Column_Name		FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
	SET		@ColumnDataType_Current		= ( SELECT Column_Data_Type	FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )


	SET		@TableStatement 			= 'IF OBJECT_ID(''tempdb..##SurveyResponse_Scalable_Import'') IS NOT NULL  DROP TABLE ##SurveyResponse_Scalable_Import;		CREATE TABLE ##SurveyResponse_Scalable_Import ( '

	SET		@TableColumnList_SR 		= '^^^'


	-- Testing
	-- SELECT @TableStatement, @RowId_Current, @RowId_Max, @ColumnName_Current, @ColumnDataType_Current



	WHILE @RowId_Current <= @RowId_Max
	BEGIN

		SET @ColumnName_Current			= ( SELECT Column_Name		FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
		SET @ColumnDataType_Current		= ( SELECT Column_Data_Type	FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
		
		SET @TableStatement				= @TableStatement + @ColumnName_Current + ' ' + @ColumnDataType_Current + ', '

		SET @TableColumnList_SR			= @TableColumnList_SR + @ColumnName_Current  + ', '
		

		SET	@RowId_Current				= @RowId_Current + 1


	END


		SET @TableStatement				= @TableStatement + ')'

		SET @TableStatement				= ( SELECT REPLACE( @TableStatement, ', )', ' )' )	)
		
		
		SET @TableColumnList_SR			= @TableColumnList_SR + ')'
		
		SET @TableColumnList_SR			= ( SELECT REPLACE( @TableColumnList_SR, ', )', '' )	)
		
		SET	@TableColumnList_SR 		= ( SELECT REPLACE( @TableColumnList_SR, '^^^', '')	)



	-- Testing
	-- SELECT @TableStatement, @RowId_Current, @RowId_Max, @ColumnName_Current, @ColumnDataType_Current
		
		
	-- Creates the dynamically built SurveyResponse
	EXECUTE ( @TableStatement )



	-- Truncate working tables
	TRUNCATE TABLE #DynamicTableBuild_Tmp01
	TRUNCATE TABLE #DynamicTableBuild_Tmp02




	-- Testing
	-- SELECT @TableStatement
	 --SELECT *	FROM #DynamicTableBuild_Tmp01
	 --SELECT *	FROM #DynamicTableBuild_Tmp02
	 --SELECT *	FROM ##SurveyResponse_Scalable_Import






END









-- SurveyResponseAnswer Dynamic Table Build
IF @FileName_SRACheck = 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Building SurveyResponseAnswer Table'
	RAISERROR (@message,0,1) with NOWAIT  


	INSERT INTO #DynamicTableBuild_Tmp01 ( Column_Name, Column_Data_Type, Is_Identity )
	SELECT
			c.name 			AS Column_Name
			, st.name + '(' + CASE WHEN c.max_length = - 1 THEN 'max' ELSE CAST(c.max_length AS varchar(100)) END + ')' 	AS Column_Data_Type
			, Is_Identity

	FROM 
			sys.columns AS c 
		JOIN
			sys.systypes AS st 
				ON st.xtype = c.user_type_id 
		JOIN
			sys.tables AS t 
				ON c.object_id = t.object_id 
	WHERE
			( t.name NOT IN ( 'sysdiagrams', 'DataDictionary' ) ) 
		AND 
			( st.name NOT LIKE '%sysname%' )
		AND
			t.name NOT LIKE '\_%' ESCAPE '\'
			
		/* Filters for specific table if present */
		AND	
			t.name LIKE 'SurveyResponseAnswer'
	ORDER BY 
			c.column_id		ASC



	-- Fix data type int
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'int'
	WHERE
			Column_Data_Type LIKE 'int%'



	-- Fix data type BigInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'bigInt'
	WHERE
			Column_Data_Type LIKE 'bigInt%'



	-- Fix data type BigInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'tinyInt'
	WHERE
			Column_Data_Type LIKE 'tinyInt%'



	-- Fix data type SmallInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'smallInt'
	WHERE
			Column_Data_Type LIKE 'smallInt%'



	-- Fix data type DateTime
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'dateTime'
	WHERE
			Column_Data_Type LIKE 'dateTime%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'bit'
	WHERE
			Column_Data_Type LIKE 'bit%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'float'
	WHERE
			Column_Data_Type LIKE 'float%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'timestamp'
	WHERE
			Column_Data_Type LIKE 'timestamp%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'real'
	WHERE
			Column_Data_Type LIKE 'real%'





	INSERT INTO #DynamicTableBuild_Tmp02 ( Column_Name, Column_Data_Type, Is_Identity )
	SELECT
			Column_Name
			, Column_Data_Type
			, Is_Identity
	FROM
			#DynamicTableBuild_Tmp01
	ORDER BY
			RowId



	-- Test
	--SELECT *	FROM #DynamicTableBuild_Tmp01
	--SELECT *	FROM #DynamicTableBuild_Tmp02





	-- Identity check on table
	SET @IdentityInsert_Statement_SRA_Check = ( SELECT SUM( Is_Identity )	FROM #DynamicTableBuild_Tmp02 )









	SET		@RowId_Current				= ( SELECT MIN( RowId )	FROM #DynamicTableBuild_Tmp02 )
	SET		@RowId_Max					= ( SELECT MAX( RowId )	FROM #DynamicTableBuild_Tmp02 )


	SET		@ColumnName_Current			= ( SELECT Column_Name		FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
	SET		@ColumnDataType_Current		= ( SELECT Column_Data_Type	FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )


	SET		@TableStatement 			= 'IF OBJECT_ID(''tempdb..##SurveyResponseAnswer_Scalable_Import'') IS NOT NULL  DROP TABLE ##SurveyResponseAnswer_Scalable_Import;		CREATE TABLE ##SurveyResponseAnswer_Scalable_Import ( '

	SET		@TableColumnList_SRA 		= '^^^'


	-- Testing
	--SELECT @TableStatement, @RowId_Current, @RowId_Max, @ColumnName_Current, @ColumnDataType_Current



	WHILE @RowId_Current <= @RowId_Max
	BEGIN

		SET @ColumnName_Current			= ( SELECT Column_Name		FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
		SET @ColumnDataType_Current		= ( SELECT Column_Data_Type	FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
		
		SET @TableStatement				= @TableStatement + @ColumnName_Current + ' ' + @ColumnDataType_Current + ', ' 

		SET @TableColumnList_SRA		= @TableColumnList_SRA + @ColumnName_Current  + ', '		
		
		SET	@RowId_Current				= @RowId_Current + 1


	END


		SET @TableStatement				= @TableStatement + ')'

		SET @TableStatement				= ( SELECT REPLACE( @TableStatement, ', )', ' )' )	)
		
		
		SET @TableColumnList_SRA		= @TableColumnList_SRA + ')'
		
		SET @TableColumnList_SRA		= ( SELECT REPLACE( @TableColumnList_SRA, ', )', '' )	)
		
		SET	@TableColumnList_SRA 		= ( SELECT REPLACE( @TableColumnList_SRA, '^^^', '')	)



	-- Testing
	-- SELECT @TableStatement, @RowId_Current, @RowId_Max, @ColumnName_Current, @ColumnDataType_Current
		
		

		
		
	-- Creates the dynamically built SurveyResponseAnswer
	EXECUTE ( @TableStatement )



	-- Truncate working tables
	TRUNCATE TABLE #DynamicTableBuild_Tmp01
	TRUNCATE TABLE #DynamicTableBuild_Tmp02




	-- Testing
	-- SELECT @TableStatement
	-- SELECT *	FROM #DynamicTableBuild_Tmp01
	-- SELECT *	FROM #DynamicTableBuild_Tmp02
	-- SELECT *	FROM ##SurveyResponse_Scalable_Import






END








-- SurveyResponseScore Dynamic Table Build
IF @FileName_SRSCCheck = 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Building SurveyResponseScore Table'
	RAISERROR (@message,0,1) with NOWAIT  


	INSERT INTO #DynamicTableBuild_Tmp01 ( Column_Name, Column_Data_Type, Is_Identity )
	SELECT
			c.name 			AS Column_Name
			, st.name + '(' + CASE WHEN c.max_length = - 1 THEN 'max' ELSE CAST(c.max_length AS varchar(100)) END + ')' 	AS Column_Data_Type
			, Is_Identity

	FROM 
			sys.columns AS c 
		JOIN
			sys.systypes AS st 
				ON st.xtype = c.user_type_id 
		JOIN
			sys.tables AS t 
				ON c.object_id = t.object_id 
	WHERE
			( t.name NOT IN ( 'sysdiagrams', 'DataDictionary' ) ) 
		AND 
			( st.name NOT LIKE '%sysname%' )
		AND
			t.name NOT LIKE '\_%' ESCAPE '\'
			
		/* Filters for specific table if present */
		AND	
			t.name LIKE 'SurveyResponseScore'
	ORDER BY 
			c.column_id		ASC




	-- Fix data type int
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'int'
	WHERE
			Column_Data_Type LIKE 'int%'



	-- Fix data type BigInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'bigInt'
	WHERE
			Column_Data_Type LIKE 'bigInt%'



	-- Fix data type BigInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'tinyInt'
	WHERE
			Column_Data_Type LIKE 'tinyInt%'



	-- Fix data type SmallInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'smallInt'
	WHERE
			Column_Data_Type LIKE 'smallInt%'



	-- Fix data type DateTime;  fix
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'dateTime'
	WHERE
			Column_Data_Type LIKE 'dateTime%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'bit'
	WHERE
			Column_Data_Type LIKE 'bit%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'float'
	WHERE
			Column_Data_Type LIKE 'float%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'timestamp'
	WHERE
			Column_Data_Type LIKE 'timestamp%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'real'
	WHERE
			Column_Data_Type LIKE 'real%'





	INSERT INTO #DynamicTableBuild_Tmp02 ( Column_Name, Column_Data_Type, Is_Identity )
	SELECT
			Column_Name
			, Column_Data_Type
			, Is_Identity			
	FROM
			#DynamicTableBuild_Tmp01
	ORDER BY
			RowId



	-- Test
	--SELECT *	FROM #DynamicTableBuild_Tmp01
	--SELECT *	FROM #DynamicTableBuild_Tmp01


	-- Identity check on table
	SET @IdentityInsert_Statement_SRSC_Check = ( SELECT SUM( Is_Identity )	FROM #DynamicTableBuild_Tmp02 )





	SET		@RowId_Current				= ( SELECT MIN( RowId )	FROM #DynamicTableBuild_Tmp02 )
	SET		@RowId_Max					= ( SELECT MAX( RowId )	FROM #DynamicTableBuild_Tmp02 )


	SET		@ColumnName_Current			= ( SELECT Column_Name		FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
	SET		@ColumnDataType_Current		= ( SELECT Column_Data_Type	FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )


	SET		@TableStatement 			= 'IF OBJECT_ID(''tempdb..##SurveyResponseScore_Scalable_Import'') IS NOT NULL  DROP TABLE ##SurveyResponseScore_Scalable_Import;		CREATE TABLE ##SurveyResponseScore_Scalable_Import ( '

	SET		@TableColumnList_SRSC 		= '^^^'


	-- Testing
	-- SELECT @TableStatement, @RowId_Current, @RowId_Max, @ColumnName_Current, @ColumnDataType_Current



	WHILE @RowId_Current <= @RowId_Max
	BEGIN

		SET @ColumnName_Current			= ( SELECT Column_Name		FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
		SET @ColumnDataType_Current		= ( SELECT Column_Data_Type	FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
		
		SET @TableStatement				= @TableStatement + @ColumnName_Current + ' ' + @ColumnDataType_Current + ', '

		SET @TableColumnList_SRSC		= @TableColumnList_SRSC + @ColumnName_Current  + ', '
		

		SET	@RowId_Current				= @RowId_Current + 1


	END


		SET @TableStatement				= @TableStatement + ')'

		SET @TableStatement				= ( SELECT REPLACE( @TableStatement, ', )', ' )' )	)
		
		
		SET @TableColumnList_SRSC			= @TableColumnList_SRSC + ')'
		
		SET @TableColumnList_SRSC			= ( SELECT REPLACE( @TableColumnList_SRSC, ', )', '' )	)
		
		SET	@TableColumnList_SRSC 		= ( SELECT REPLACE( @TableColumnList_SRSC, '^^^', '')	)



	-- Testing
	-- SELECT @TableStatement, @RowId_Current, @RowId_Max, @ColumnName_Current, @ColumnDataType_Current
		
		
	-- Creates the dynamically built SurveyResponseScore
	EXECUTE ( @TableStatement )



	-- Truncate working tables
	TRUNCATE TABLE #DynamicTableBuild_Tmp01
	TRUNCATE TABLE #DynamicTableBuild_Tmp02




	-- Testing
	-- SELECT @TableStatement
	 --SELECT *	FROM #DynamicTableBuild_Tmp01
	 --SELECT *	FROM #DynamicTableBuild_Tmp02
	 --SELECT *	FROM ##SurveyResponse_Scalable_Import






END

















-- Comment Dynamic Table Build
IF @FileName_CommentCheck = 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Building Comment Table'
	RAISERROR (@message,0,1) with NOWAIT  


	INSERT INTO #DynamicTableBuild_Tmp01 ( Column_Name, Column_Data_Type, Is_Identity )
	SELECT
			c.name 			AS Column_Name
			, st.name + '(' + CASE WHEN c.max_length = - 1 THEN 'max' ELSE CAST(c.max_length AS varchar(100)) END + ')' 	AS Column_Data_Type
			, Is_Identity
	FROM 
			sys.columns AS c 
		JOIN
			sys.systypes AS st 
				ON st.xtype = c.user_type_id 
		JOIN
			sys.tables AS t 
				ON c.object_id = t.object_id 
	WHERE
			( t.name NOT IN ( 'sysdiagrams', 'DataDictionary' ) ) 
		AND 
			( st.name NOT LIKE '%sysname%' )
		AND
			t.name NOT LIKE '\_%' ESCAPE '\'
			
		/* Filters for specific table if present */
		AND	
			t.name LIKE 'Comment'
	ORDER BY 
			c.column_id		ASC



	-- Fix data type int
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'int'
	WHERE
			Column_Data_Type LIKE 'int%'



	-- Fix data type BigInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'bigInt'
	WHERE
			Column_Data_Type LIKE 'bigInt%'



	-- Fix data type BigInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'tinyInt'
	WHERE
			Column_Data_Type LIKE 'tinyInt%'



	-- Fix data type SmallInt
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'smallInt'
	WHERE
			Column_Data_Type LIKE 'smallInt%'



	-- Fix data type DateTime
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'dateTime'
	WHERE
			Column_Data_Type LIKE 'dateTime%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'bit'
	WHERE
			Column_Data_Type LIKE 'bit%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'float'
	WHERE
			Column_Data_Type LIKE 'float%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'timestamp'
	WHERE
			Column_Data_Type LIKE 'timestamp%'



	-- Fix data type bit
	UPDATE 
			#DynamicTableBuild_Tmp01
	SET		
			Column_Data_Type = 'real'
	WHERE
			Column_Data_Type LIKE 'real%'





	INSERT INTO #DynamicTableBuild_Tmp02 ( Column_Name, Column_Data_Type, Is_Identity )
	SELECT
			Column_Name
			, Column_Data_Type
			, Is_Identity
	FROM
			#DynamicTableBuild_Tmp01
	ORDER BY
			RowId



	-- Test
	--SELECT *	FROM #DynamicTableBuild_Tmp01





	-- Identity check on table
	SET @IdentityInsert_Statement_Comment_Check = ( SELECT SUM( Is_Identity )	FROM #DynamicTableBuild_Tmp02 )









	SET		@RowId_Current				= ( SELECT MIN( RowId )	FROM #DynamicTableBuild_Tmp02 )
	SET		@RowId_Max					= ( SELECT MAX( RowId )	FROM #DynamicTableBuild_Tmp02 )


	SET		@ColumnName_Current			= ( SELECT Column_Name		FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
	SET		@ColumnDataType_Current		= ( SELECT Column_Data_Type	FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )


	SET		@TableStatement = 'IF OBJECT_ID(''tempdb..##Comment_Scalable_Import'') IS NOT NULL  DROP TABLE ##Comment_Scalable_Import;		CREATE TABLE ##Comment_Scalable_Import ( '

	SET		@TableColumnList_Comment 		= '^^^'


	-- Testing
	-- SELECT @TableStatement, @RowId_Current, @RowId_Max, @ColumnName_Current, @ColumnDataType_Current



	WHILE @RowId_Current <= @RowId_Max
	BEGIN

		SET @ColumnName_Current			= ( SELECT Column_Name		FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
		SET @ColumnDataType_Current		= ( SELECT Column_Data_Type	FROM #DynamicTableBuild_Tmp02		WHERE RowId = @RowId_Current )
		
		SET @TableStatement				= @TableStatement + @ColumnName_Current + ' ' + @ColumnDataType_Current + ', ' 

		SET @TableColumnList_Comment	= @TableColumnList_Comment + @ColumnName_Current  + ', '		

		SET	@RowId_Current				= @RowId_Current + 1


	END


		SET @TableStatement				= @TableStatement + ')'

		SET @TableStatement				= ( SELECT REPLACE( @TableStatement, ', )', ' )' )	)
		
		
		SET @TableColumnList_Comment	= @TableColumnList_Comment + ')'
		
		SET @TableColumnList_Comment	= ( SELECT REPLACE( @TableColumnList_Comment, ', )', '' )	)
		
		SET	@TableColumnList_Comment 	= ( SELECT REPLACE( @TableColumnList_Comment, '^^^', '')	)



	-- Testing
	-- SELECT @TableStatement, @RowId_Current, @RowId_Max, @ColumnName_Current, @ColumnDataType_Current
		
		

		
		
	-- Creates the dynamically built Comment
	EXECUTE ( @TableStatement )



	-- Truncate working tables
	TRUNCATE TABLE #DynamicTableBuild_Tmp01
	TRUNCATE TABLE #DynamicTableBuild_Tmp02




	-- Testing
	-- SELECT @TableStatement
	-- SELECT *	FROM #DynamicTableBuild_Tmp01
	-- SELECT *	FROM #DynamicTableBuild_Tmp02
	-- SELECT *	FROM ##SurveyResponse_Scalable_Import






END









-- Sets the Network Path
SET		@NetworkLocation				= CASE	WHEN	CHARINDEX( '\', REVERSE( @NetworkLocation ) )				= 1		THEN	@NetworkLocation		ELSE @NetworkLocation + '\'		END








-- Uploading Files
DECLARE @FileNameBulkInsertStatement	nvarchar(2000)



-- SurveyResponse Upload File
IF @FileName_SRCheck = 1
BEGIN 

	-- Upload start time
	SET @BeginTime = GETDATE()

	
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Uploading SurveyResponse File'
	RAISERROR (@message,0,1) with NOWAIT  


	SET		@FileNameBulkInsertStatement	= 'BULK INSERT ##SurveyResponse_Scalable_Import  	FROM ''' + @NetworkLocation + @FileName_SR + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'' )'



	-- Processes the Bulk Insert
	EXECUTE ( @FileNameBulkInsertStatement )


	SET @FileUploadCount	= ( SELECT COUNT(1) FROM ##SurveyResponse_Scalable_Import )
	
	SET @message = 'Count: ' + CAST( @FileUploadCount as varchar )
	RAISERROR (@message,0,1) with NOWAIT  

	
	
	-- End duration caluculations
	SET @EndTime = GETDATE()

	SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

	-- Print Iteration Count Value
	SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
	RAISERROR (@message,0,1) with NOWAIT

	
	
	IF @FileUploadCount = 0
	BEGIN 
		SET @message = 'Something appears to be wrong with the file, zero rows were uploaded.  Exiting.'
		RAISERROR (@message,0,1) with NOWAIT  
		
		RETURN 99
	END

		
	-- Testing
	--SELECT @FileNameBulkInsertStatement

END






-- SurveyResponseAnswer Upload File
IF @FileName_SRACheck = 1
BEGIN

	-- Upload start time
	SET @BeginTime = GETDATE()

	

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Uploading SurveyResponseAnswer File'
	RAISERROR (@message,0,1) with NOWAIT  



	SET		@FileNameBulkInsertStatement	= 'BULK INSERT ##SurveyResponseAnswer_Scalable_Import  	FROM ''' + @NetworkLocation + @FileName_SRA + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'' )'



	-- Processes the Bulk Insert
	EXECUTE ( @FileNameBulkInsertStatement )


	SET @FileUploadCount	= ( SELECT COUNT(1) FROM ##SurveyResponseAnswer_Scalable_Import )
	
	
	SET @message = 'Count: ' + CAST( @FileUploadCount as varchar )
	RAISERROR (@message,0,1) with NOWAIT  

	
	
	-- End duration caluculations
	SET @EndTime = GETDATE()

	SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

	-- Print Iteration Count Value
	SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
	RAISERROR (@message,0,1) with NOWAIT

	
	

	
	IF @FileUploadCount = 0
	BEGIN 
		SET @message = 'Something appears to be wrong with the file, zero rows were uploaded.  Exiting.'
		RAISERROR (@message,0,1) with NOWAIT  
		
		RETURN 99
	END

		

	-- Testing
	--SELECT @FileNameBulkInsertStatement

END






-- SurveyResponseScore Upload File
IF @FileName_SRSCCheck = 1
BEGIN

	-- Upload start time
	SET @BeginTime = GETDATE()

	

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Uploading SurveyResponseScore File'
	RAISERROR (@message,0,1) with NOWAIT  



	SET		@FileNameBulkInsertStatement	= 'BULK INSERT ##SurveyResponseScore_Scalable_Import  	FROM ''' + @NetworkLocation + @FileName_SRSC + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'' )'



	-- Processes the Bulk Insert
	EXECUTE ( @FileNameBulkInsertStatement )


	SET @FileUploadCount	= ( SELECT COUNT(1) FROM ##SurveyResponseScore_Scalable_Import )
	
	
	SET @message = 'Count: ' + CAST( @FileUploadCount as varchar )
	RAISERROR (@message,0,1) with NOWAIT  

	
	
	-- End duration caluculations
	SET @EndTime = GETDATE()

	SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

	-- Print Iteration Count Value
	SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
	RAISERROR (@message,0,1) with NOWAIT

	
	

	
	IF @FileUploadCount = 0
	BEGIN 
		SET @message = 'Something appears to be wrong with the file, zero rows were uploaded.  Exiting.'
		RAISERROR (@message,0,1) with NOWAIT  
		
		RETURN 99
	END

		

	-- Testing
	--SELECT @FileNameBulkInsertStatement

END







-- Comment Upload File
IF @FileName_CommentCheck = 1
BEGIN

	-- Upload start time
	SET @BeginTime = GETDATE()

	

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Uploading Comment File'
	RAISERROR (@message,0,1) with NOWAIT  



	SET		@FileNameBulkInsertStatement	= 'BULK INSERT ##Comment_Scalable_Import  	FROM ''' + @NetworkLocation + @FileName_Comment + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'' )'



	-- Processes the Bulk Insert
	EXECUTE ( @FileNameBulkInsertStatement )


	SET @FileUploadCount	= ( SELECT COUNT(1) FROM ##Comment_Scalable_Import )
	
	
	SET @message = 'Count: ' + CAST( @FileUploadCount as varchar )
	RAISERROR (@message,0,1) with NOWAIT  

	
	
	-- End duration caluculations
	SET @EndTime = GETDATE()

	SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

	-- Print Iteration Count Value
	SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
	RAISERROR (@message,0,1) with NOWAIT

	
	

	
	IF @FileUploadCount = 0
	BEGIN 
		SET @message = 'Something appears to be wrong with the file, zero rows were uploaded.  Exiting.'
		RAISERROR (@message,0,1) with NOWAIT  
		
		RETURN 99
	END

		

	-- Testing
	--SELECT @FileNameBulkInsertStatement

END









/************************************  Validating Identities and FKs  ************************************/




-- SurveyResponse Validating Identity
IF @FileName_SRCheck = 1
BEGIN

	-- Upload start time
	SET @BeginTime = GETDATE()

	


	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'SurveyResponse Conflict Details'
	RAISERROR (@message,0,1) with NOWAIT  



	-- Check to see if there are identity conflicts
	SET @SurveyResponseConflictValue = 
										(
											SELECT
													COUNT(1)
											FROM
													##SurveyResponse_Scalable_Import		t10
												JOIN
													SurveyResponse							t20
														ON t10.objectId = t20.objectId
										)
				


				
	SET @message = '     Identity :  ' + CAST( @SurveyResponseConflictValue as varchar )
	RAISERROR (@message,0,1) with NOWAIT  

	INSERT INTO ##SurveyResponseConflictDetails ( Item, Conflicts )
	SELECT
			'SurveyResponse.Indentity'
			, @SurveyResponseConflictValue
	

	
	TRUNCATE TABLE ##FKeysList

	INSERT INTO ##FKeysList ( Origin_Table, FK_Column, FK_Table, FK_Referencing_Column )
	SELECT   
					
			Origin_Table = t01.TABLE_NAME
			, FK_Column = t02.COLUMN_NAME
			, FK_Table =  t03.TABLE_NAME
			, FK_Referencing_Column = t03.COLUMN_NAME

			--, 
						
	FROM   
			INFORMATION_SCHEMA.TABLE_CONSTRAINTS	t01 
		JOIN
			INFORMATION_SCHEMA.KEY_COLUMN_USAGE		t02
					ON t01.CONSTRAINT_NAME = t02.CONSTRAINT_NAME
		JOIN			                
			INFORMATION_SCHEMA.KEY_COLUMN_USAGE		t03
					ON t02.COLUMN_NAME = (t03.TABLE_NAME + t03.COLUMN_NAME)
	 
	WHERE
			t01.CONSTRAINT_TYPE LIKE 'FOREIGN KEY'
		AND
			t01.TABLE_NAME = 'SurveyResponse'



	SET 	@RowIdMin					= ( SELECT MIN( RowId )		FROM ##FKeysList )
	SET 	@RowIdMax					= ( SELECT MAX( RowId )		FROM ##FKeysList )
	SET		@RowIdCurrent				= @RowIdMin

	
	
	WHILE @RowIdCurrent <= @RowIdMax
	BEGIN
	
		SET		@Origin_Table				= ( SELECT Origin_Table				FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Column					= ( SELECT FK_Column				FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Table					= ( SELECT FK_Table					FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Referencing_Column		= ( SELECT FK_Referencing_Column	FROM ##FKeysList	WHERE RowId = @RowIdCurrent )

		SET		@SqlTableColumn				= ( SELECT Origin_Table + '.' + FK_Column	FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@SqlStatement				= 'SELECT COUNT(1) FROM ##SurveyResponse_Scalable_Import	t10		LEFT JOIN ' + @FK_Table + ' t20 ON t10.' + @FK_Column + ' = t20.' + @FK_Referencing_Column + ' WHERE t20.' +  @FK_Referencing_Column + ' IS NULL '

		
		INSERT INTO @dtt10( Value )
		EXEC ( @SqlStatement )

		SET	@FK_BadValue = ( SELECT TOP 1 Value		FROM @dtt10 )

		
		INSERT INTO ##SurveyResponseConflictDetails ( Item, Conflicts )
		SELECT @SqlTableColumn, @FK_BadValue
		
		SET @message = '     ' + @SqlTableColumn + ':  ' + CAST( @FK_BadValue as varchar )
		RAISERROR (@message,0,1) with NOWAIT  


		DELETE @dtt10	WHERE 1 = 1

		
		SET @RowIdCurrent = @RowIdCurrent + 1

		
	END
	
	
	-- End duration caluculations
	SET @EndTime = GETDATE()

	SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

	-- Print Iteration Count Value
	SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
	RAISERROR (@message,0,1) with NOWAIT


END









-- SurveyResponseAnswer Validating Identity
IF @FileName_SRACheck = 1
BEGIN

	-- Upload start time
	SET @BeginTime = GETDATE()

	


	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'SurveyResponseAnswer Conflict Details'
	RAISERROR (@message,0,1) with NOWAIT  



	-- Check to see if there are identity conflicts
	SET @SurveyResponseAnswerConflictValue = 	
												(
													SELECT
															COUNT(1)
													FROM
															##SurveyResponseAnswer_Scalable_Import		t10
														JOIN
															SurveyResponseAnswer						t20
																ON t10.objectId = t20.objectId
												)
						


				
	SET @message = '     Identity :  ' + CAST( @SurveyResponseAnswerConflictValue as varchar )
	RAISERROR (@message,0,1) with NOWAIT  

	INSERT INTO ##SurveyResponseAnswerConflictDetails ( Item, Conflicts )
	SELECT
			'SurveyResponseAnswer.Indentity'
			, @SurveyResponseAnswerConflictValue
	

	
	TRUNCATE TABLE ##FKeysList

	INSERT INTO ##FKeysList ( Origin_Table, FK_Column, FK_Table, FK_Referencing_Column )
	SELECT   
					
			Origin_Table = t01.TABLE_NAME
			, FK_Column = t02.COLUMN_NAME
			, FK_Table =  t03.TABLE_NAME
			, FK_Referencing_Column = t03.COLUMN_NAME

			--, 
						
	FROM   
			INFORMATION_SCHEMA.TABLE_CONSTRAINTS	t01 
		JOIN
			INFORMATION_SCHEMA.KEY_COLUMN_USAGE		t02
					ON t01.CONSTRAINT_NAME = t02.CONSTRAINT_NAME
		JOIN			                
			INFORMATION_SCHEMA.KEY_COLUMN_USAGE		t03
					ON t02.COLUMN_NAME = (t03.TABLE_NAME + t03.COLUMN_NAME)
	 
	WHERE
			t01.CONSTRAINT_TYPE LIKE 'FOREIGN KEY'
		AND
			t01.TABLE_NAME = 'SurveyResponseAnswer'


	-- This is necessary as the SurveyResponse is not there yet
	IF @SingleTableLoadCheck = 0
	BEGIN
		DELETE FROM ##FKeysList WHERE FK_Table = 'SurveyResponse'
	END

	SET 	@RowIdMin					= ( SELECT MIN( RowId )		FROM ##FKeysList )
	SET 	@RowIdMax					= ( SELECT MAX( RowId )		FROM ##FKeysList )
	SET		@RowIdCurrent				= @RowIdMin

	
	
	WHILE @RowIdCurrent <= @RowIdMax
	BEGIN
	
		SET		@Origin_Table				= ( SELECT Origin_Table				FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Column					= ( SELECT FK_Column				FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Table					= ( SELECT FK_Table					FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Referencing_Column		= ( SELECT FK_Referencing_Column	FROM ##FKeysList	WHERE RowId = @RowIdCurrent )

		SET		@SqlTableColumn				= ( SELECT Origin_Table + '.' + FK_Column	FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@SqlStatement				= 'SELECT COUNT(1) FROM ##SurveyResponseAnswer_Scalable_Import	t10		LEFT JOIN ' + @FK_Table + ' t20 ON t10.' + @FK_Column + ' = t20.' + @FK_Referencing_Column + ' WHERE t10.' + @FK_Column + ' IS NOT NULL AND t20.' +  @FK_Referencing_Column + ' IS NULL '

		
		INSERT INTO @dtt10( Value )
		EXEC ( @SqlStatement )

		SET	@FK_BadValue = ( SELECT TOP 1 Value		FROM @dtt10 )

		
		INSERT INTO ##SurveyResponseAnswerConflictDetails ( Item, Conflicts )
		SELECT @SqlTableColumn, @FK_BadValue
		
		SET @message = '     ' + @SqlTableColumn + ':  ' + CAST( @FK_BadValue as varchar )
		RAISERROR (@message,0,1) with NOWAIT  


		DELETE @dtt10	WHERE 1 = 1

		
		SET @RowIdCurrent = @RowIdCurrent + 1

		
	END
	
	
	-- End duration caluculations
	SET @EndTime = GETDATE()

	SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

	-- Print Iteration Count Value
	SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
	RAISERROR (@message,0,1) with NOWAIT


END









-- SurveyResponseScore Validating Identity
IF @FileName_SRSCCheck = 1
BEGIN

	-- Upload start time
	SET @BeginTime = GETDATE()

	


	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'SurveyResponseScore Conflict Details'
	RAISERROR (@message,0,1) with NOWAIT  



	-- Check to see if there are identity conflicts
	SET @SurveyResponseScoreConflictValue = 	
												(
													SELECT
															COUNT(1)
													FROM
															##SurveyResponseScore_Scalable_Import		t10
														JOIN
															SurveyResponseScore						t20
																ON t10.objectId = t20.objectId
												)
						


				
	SET @message = '     Identity :  ' + CAST( @SurveyResponseScoreConflictValue as varchar )
	RAISERROR (@message,0,1) with NOWAIT  

	INSERT INTO ##SurveyResponseScoreConflictDetails ( Item, Conflicts )
	SELECT
			'SurveyResponseScore.Indentity'
			, @SurveyResponseScoreConflictValue
	

	
	TRUNCATE TABLE ##FKeysList

	INSERT INTO ##FKeysList ( Origin_Table, FK_Column, FK_Table, FK_Referencing_Column )
	SELECT   
					
			Origin_Table = t01.TABLE_NAME
			, FK_Column = t02.COLUMN_NAME
			, FK_Table =  t03.TABLE_NAME
			, FK_Referencing_Column = t03.COLUMN_NAME

			--, 
						
	FROM   
			INFORMATION_SCHEMA.TABLE_CONSTRAINTS	t01 
		JOIN
			INFORMATION_SCHEMA.KEY_COLUMN_USAGE		t02
					ON t01.CONSTRAINT_NAME = t02.CONSTRAINT_NAME
		JOIN			                
			INFORMATION_SCHEMA.KEY_COLUMN_USAGE		t03
					ON t02.COLUMN_NAME = (t03.TABLE_NAME + t03.COLUMN_NAME)
	 
	WHERE
			t01.CONSTRAINT_TYPE LIKE 'FOREIGN KEY'
		AND
			t01.TABLE_NAME = 'SurveyResponseScore'


	-- This is necessary as the SurveyResponse is not there yet	
	IF @SingleTableLoadCheck = 0
	BEGIN	
		DELETE FROM ##FKeysList WHERE FK_Table = 'SurveyResponse'
	END

	SET 	@RowIdMin					= ( SELECT MIN( RowId )		FROM ##FKeysList )
	SET 	@RowIdMax					= ( SELECT MAX( RowId )		FROM ##FKeysList )
	SET		@RowIdCurrent				= @RowIdMin

	
	
	WHILE @RowIdCurrent <= @RowIdMax
	BEGIN
	
		SET		@Origin_Table				= ( SELECT Origin_Table				FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Column					= ( SELECT FK_Column				FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Table					= ( SELECT FK_Table					FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Referencing_Column		= ( SELECT FK_Referencing_Column	FROM ##FKeysList	WHERE RowId = @RowIdCurrent )

		SET		@SqlTableColumn				= ( SELECT Origin_Table + '.' + FK_Column	FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@SqlStatement				= 'SELECT COUNT(1) FROM ##SurveyResponseScore_Scalable_Import	t10		LEFT JOIN ' + @FK_Table + ' t20 ON t10.' + @FK_Column + ' = t20.' + @FK_Referencing_Column + ' WHERE t10.' + @FK_Column + ' IS NOT NULL AND t20.' +  @FK_Referencing_Column + ' IS NULL '

		
		INSERT INTO @dtt10( Value )
		EXEC ( @SqlStatement )

		SET	@FK_BadValue = ( SELECT TOP 1 Value		FROM @dtt10 )

		
		INSERT INTO ##SurveyResponseScoreConflictDetails ( Item, Conflicts )
		SELECT @SqlTableColumn, @FK_BadValue
		
		SET @message = '     ' + @SqlTableColumn + ':  ' + CAST( @FK_BadValue as varchar )
		RAISERROR (@message,0,1) with NOWAIT  


		DELETE @dtt10	WHERE 1 = 1

		
		SET @RowIdCurrent = @RowIdCurrent + 1

		
	END
	
	
	-- End duration caluculations
	SET @EndTime = GETDATE()

	SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

	-- Print Iteration Count Value
	SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
	RAISERROR (@message,0,1) with NOWAIT


END










-- Comment Validating Identity
IF @FileName_CommentCheck = 1
BEGIN

	-- Upload start time
	SET @BeginTime = GETDATE()

	


	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Comment Conflict Details'
	RAISERROR (@message,0,1) with NOWAIT  



	-- Check to see if there are identity conflicts
	SET @CommentConflictValue = 
									(
										SELECT
												COUNT(1)
										FROM
												##Comment_Scalable_Import		t10
											JOIN
												Comment							t20
													ON t10.objectId = t20.objectId
									)
				


				
	SET @message = '     Identity :  ' + CAST( @CommentConflictValue as varchar )
	RAISERROR (@message,0,1) with NOWAIT  

	INSERT INTO ##CommentConflictDetails ( Item, Conflicts )
	SELECT
			'Comment.Indentity'
			, @CommentConflictValue
	

	
	TRUNCATE TABLE ##FKeysList

	INSERT INTO ##FKeysList ( Origin_Table, FK_Column, FK_Table, FK_Referencing_Column )
	SELECT   
					
			Origin_Table = t01.TABLE_NAME
			, FK_Column = t02.COLUMN_NAME
			, FK_Table =  t03.TABLE_NAME
			, FK_Referencing_Column = t03.COLUMN_NAME

			--, 
						
	FROM   
			INFORMATION_SCHEMA.TABLE_CONSTRAINTS	t01 
		JOIN
			INFORMATION_SCHEMA.KEY_COLUMN_USAGE		t02
					ON t01.CONSTRAINT_NAME = t02.CONSTRAINT_NAME
		JOIN			                
			INFORMATION_SCHEMA.KEY_COLUMN_USAGE		t03
					ON t02.COLUMN_NAME = (t03.TABLE_NAME + t03.COLUMN_NAME)
	 
	WHERE
			t01.CONSTRAINT_TYPE LIKE 'FOREIGN KEY'
		AND
			t01.TABLE_NAME = 'Comment'


	-- This is necessary as the SurveyResponseAnswer is not there yet
	IF @SingleTableLoadCheck = 0
	BEGIN	
		DELETE FROM ##FKeysList WHERE FK_Table = 'SurveyResponseAnswer'
	END
	
	SET 	@RowIdMin					= ( SELECT MIN( RowId )		FROM ##FKeysList )
	SET 	@RowIdMax					= ( SELECT MAX( RowId )		FROM ##FKeysList )
	SET		@RowIdCurrent				= @RowIdMin

	
	
	WHILE @RowIdCurrent <= @RowIdMax
	BEGIN
	
		SET		@Origin_Table				= ( SELECT Origin_Table				FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Column					= ( SELECT FK_Column				FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Table					= ( SELECT FK_Table					FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@FK_Referencing_Column		= ( SELECT FK_Referencing_Column	FROM ##FKeysList	WHERE RowId = @RowIdCurrent )

		SET		@SqlTableColumn				= ( SELECT Origin_Table + '.' + FK_Column	FROM ##FKeysList	WHERE RowId = @RowIdCurrent )
		SET		@SqlStatement				= 'SELECT COUNT(1) FROM ##Comment_Scalable_Import	t10		LEFT JOIN ' + @FK_Table + ' t20 ON t10.' + @FK_Column + ' = t20.' + @FK_Referencing_Column + ' WHERE t20.' +  @FK_Referencing_Column + ' IS NULL '

		
		INSERT INTO @dtt10( Value )
		EXEC ( @SqlStatement )

		SET	@FK_BadValue = ( SELECT TOP 1 Value		FROM @dtt10 )

		
		INSERT INTO ##CommentConflictDetails ( Item, Conflicts )
		SELECT @SqlTableColumn, @FK_BadValue
		
		SET @message = '     ' + @SqlTableColumn + ':  ' + CAST( @FK_BadValue as varchar )
		RAISERROR (@message,0,1) with NOWAIT  


		DELETE @dtt10	WHERE 1 = 1

		
		SET @RowIdCurrent = @RowIdCurrent + 1

		
	END
	
	
	-- End duration caluculations
	SET @EndTime = GETDATE()

	SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

	-- Print Iteration Count Value
	SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
	RAISERROR (@message,0,1) with NOWAIT


END




-- Validating files have correct rows
IF @FileName_SRACheck = 1 AND @SingleTableLoadCheck = 0
BEGIN
	SET @SR_UnidentifiedObjectIds = ( SELECT COUNT(1)		FROM ##SurveyResponse_Scalable_Import t10		RIGHT JOIN ##SurveyResponseAnswer_Scalable_Import  t20		ON t10.objectId = t20.SurveyResponseObjectId		WHERE t10.ObjectId IS NULL )
END

IF @FileName_SRSCCheck = 1 AND @SingleTableLoadCheck = 0
BEGIN
	SET @SRSC_UnidentifiedObjectIds = ( SELECT COUNT(1)		FROM ##SurveyResponse_Scalable_Import t10		RIGHT JOIN ##SurveyResponseScore_Scalable_Import  t20		ON t10.objectId = t20.SurveyResponseObjectId		WHERE t10.ObjectId IS NULL )
END

IF @FileName_CommentCheck = 1 AND @SingleTableLoadCheck = 0
BEGIN
	SET @SRA_UnidentifiedObjectIds = ( SELECT COUNT(1)		FROM ##SurveyResponseAnswer_Scalable_Import t10		RIGHT JOIN ##Comment_Scalable_Import  t20		ON t10.objectId = t20.SurveyResponseAnswerObjectId		WHERE t10.ObjectId IS NULL )
END








-- Exits process if validating identity flag is set 1
IF @ValidateIdentitiesOnly = 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Validating Identities Only flag is set to 1.'
	RAISERROR (@message,0,1) with NOWAIT 

	SET @message = 'Exiting process.'
	RAISERROR (@message,0,1) with NOWAIT  

	RETURN 99

END



IF @FileName_SRCheck = 1
BEGIN
	SET @SurveyResponseConflictValue = ( SELECT SUM( Conflicts )	FROM ##SurveyResponseConflictDetails )
END


IF @FileName_SRACheck = 1
BEGIN
	SET @SurveyResponseAnswerConflictValue = ( SELECT SUM( Conflicts )	FROM ##SurveyResponseAnswerConflictDetails )
END


IF @FileName_SRSCCheck = 1
BEGIN
	SET @SurveyResponseScoreConflictValue = ( SELECT SUM( Conflicts )	FROM ##SurveyResponseScoreConflictDetails )
END


IF @FileName_CommentCheck = 1
BEGIN
	SET @CommentConflictValue = ( SELECT SUM( Conflicts )	FROM ##CommentConflictDetails )
END





IF @LoadFilesOnlyCheck = 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  
	
	SET @message = 'Load Files Only flag set to 1'
	RAISERROR (@message,0,1) with NOWAIT  
	
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  


	PRINT N'-- Useful Statements'	
	PRINT N'SELECT *	FROM ##SurveyResponse_Scalable_Import'
	PRINT N'SELECT *	FROM ##SurveyResponseAnswer_Scalable_Import'
	PRINT N'SELECT *	FROM ##SurveyResponseScore_Scalable_Import'
	PRINT N'SELECT *	FROM ##Comment_Scalable_Import'
	
	

	RETURN 99
END





-- Exits process if indetity conflics exists
IF @SurveyResponseConflictValue >= 1 OR @SurveyResponseAnswerConflictValue >= 1 OR @SurveyResponseScoreConflictValue >= 1 OR @CommentConflictValue >= 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Conflicts exists.  Exiting process.'
	RAISERROR (@message,0,1) with NOWAIT 
	
	RETURN 99

END




-- Exits process if indetity conflics exists
IF @SR_UnidentifiedObjectIds >= 1 OR @SRA_UnidentifiedObjectIds >= 1 OR @SRSC_UnidentifiedObjectIds >= 1
BEGIN

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT  

	SET @message = 'Unidentified Ids exists.  Exiting process.'
	RAISERROR (@message,0,1) with NOWAIT 

	RETURN 99

END






/******************  Live Import Processing Below  ******************/

IF @ProcessFilesCheck = 1 AND  @ValidateIdentitiesOnlyCheck = 0
BEGIN

	-- Upload start time
	SET @OverallInsertBeginTime = GETDATE()

	


	IF ( @SingleTableLoadCheck = 1 AND @FileName_SRCheck = 1 ) OR ( @FileName_SRCheck = 1 )
	BEGIN

		-- Upload start time
		SET @BeginTime = GETDATE()

	
		-- Live Importing
		SET @message = ''
		RAISERROR (@message,0,1) with NOWAIT
		RAISERROR (@message,0,1) with NOWAIT


		-- Import Processing SurveyResponse
		SET @message = ''
		RAISERROR (@message,0,1) with NOWAIT

		SET @message = 'Starting identity inserts on SurveyResponse.'
		RAISERROR (@message,0,1) with NOWAIT

		
		-- Testing
		--SELECT @TableColumnList_SR

		
		-- Builds proper insert statement
		IF @IdentityInsert_Statement_SR_Check > 0
			BEGIN 	
				SET @IdentityInsert_Statement_SR = 'SET IDENTITY_INSERT SurveyResponse ON; INSERT INTO SurveyResponse ( ' + @TableColumnList_SR + ' ) SELECT ' + @TableColumnList_SR + ' FROM ##SurveyResponse_Scalable_Import; SET IDENTITY_INSERT SurveyResponse OFF;'
			END
		ELSE
			BEGIN
				SET @IdentityInsert_Statement_SR = 'INSERT INTO SurveyResponse ( ' + @TableColumnList_SR + ' ) SELECT ' + @TableColumnList_SR + ' FROM ##SurveyResponse_Scalable_Import;'
			END

		
		-- Testing
		--SELECT @IdentityInsert_Statement_SR


		EXECUTE ( @IdentityInsert_Statement_SR )


		SET @message = 'Identity inserts on SurveyResponse has completed.'
		RAISERROR (@message,0,1) with NOWAIT
	
	
		-- End duration caluculations
		SET @EndTime = GETDATE()

		SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

		-- Print Iteration Count Value
		SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
		RAISERROR (@message,0,1) with NOWAIT



	END




	IF ( @SingleTableLoadCheck = 1 AND @FileName_SRACheck = 1 ) OR ( @FileName_SRCheck = 1 AND @FileName_SRACheck = 1  )
	BEGIN

		-- Upload start time
		SET @BeginTime = GETDATE()

	
	
		-- Live Importing
		SET @message = ''
		RAISERROR (@message,0,1) with NOWAIT
		RAISERROR (@message,0,1) with NOWAIT


		-- Import Processing SurveyResponseAnswer
		SET @message = ''
		RAISERROR (@message,0,1) with NOWAIT

		SET @message = 'Starting identity inserts on SurveyResponseAnswer.'
		RAISERROR (@message,0,1) with NOWAIT

		
		-- Testing
		--SELECT @TableColumnList_SRA



		-- Builds proper insert statement
		IF @IdentityInsert_Statement_SRA_Check > 0
			BEGIN 	
				SET @IdentityInsert_Statement_SRA = 'SET IDENTITY_INSERT SurveyResponseAnswer ON; INSERT INTO SurveyResponseAnswer ( ' + @TableColumnList_SRA + ' ) SELECT ' + @TableColumnList_SRA + ' FROM ##SurveyResponseAnswer_Scalable_Import; SET IDENTITY_INSERT SurveyResponseAnswer OFF;'
			END
		ELSE
			BEGIN
				SET @IdentityInsert_Statement_SRA = 'INSERT INTO SurveyResponseAnswer ( ' + @TableColumnList_SRA + ' ) SELECT ' + @TableColumnList_SRA + ' FROM ##SurveyResponseAnswer_Scalable_Import'
			END

		

		-- Testing
		--SELECT @IdentityInsert_Statement_SRA
		
		
		EXECUTE ( @IdentityInsert_Statement_SRA )


		SET @message = 'Identity inserts on SurveyResponseAnswer has completed.'
		RAISERROR (@message,0,1) with NOWAIT
	
	
		-- End duration caluculations
		SET @EndTime = GETDATE()

		SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

		-- Print Iteration Count Value
		SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
		RAISERROR (@message,0,1) with NOWAIT





	END






	IF ( @SingleTableLoadCheck = 1 AND @FileName_SRSCCheck = 1 ) OR ( @FileName_SRCheck = 1 AND @FileName_SRSCCheck = 1  )
	BEGIN

		-- Upload start time
		SET @BeginTime = GETDATE()

	
	
		-- Live Importing
		SET @message = ''
		RAISERROR (@message,0,1) with NOWAIT
		RAISERROR (@message,0,1) with NOWAIT


		-- Import Processing SurveyResponseScore
		SET @message = ''
		RAISERROR (@message,0,1) with NOWAIT

		SET @message = 'Starting identity inserts on SurveyResponseScore.'
		RAISERROR (@message,0,1) with NOWAIT

		
		-- Testing
		--SELECT @TableColumnList_SRSC



		-- Builds proper insert statement
		IF @IdentityInsert_Statement_SRSC_Check > 0
			BEGIN 	
				SET @IdentityInsert_Statement_SRSC = 'SET IDENTITY_INSERT SurveyResponseScore ON; INSERT INTO SurveyResponseScore ( ' + @TableColumnList_SRSC + ' ) SELECT ' + @TableColumnList_SRSC + ' FROM ##SurveyResponseScore_Scalable_Import; SET IDENTITY_INSERT SurveyResponseScore OFF;'
			END
		ELSE
			BEGIN
				SET @IdentityInsert_Statement_SRSC = 'INSERT INTO SurveyResponseScore ( ' + @TableColumnList_SRSC + ' ) SELECT ' + @TableColumnList_SRSC + ' FROM ##SurveyResponseScore_Scalable_Import'
			END

		

		-- Testing
		--SELECT @IdentityInsert_Statement_SRSC


		
		EXECUTE ( @IdentityInsert_Statement_SRSC )

		
		SET @message = 'Identity inserts on SurveyResponseScore has completed.'
		RAISERROR (@message,0,1) with NOWAIT
	
	
		-- End duration caluculations
		SET @EndTime = GETDATE()

		SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

		-- Print Iteration Count Value
		SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
		RAISERROR (@message,0,1) with NOWAIT




	END



	IF ( @SingleTableLoadCheck = 1 AND @FileName_CommentCheck = 1 ) OR ( @FileName_SRCheck = 1 AND @FileName_SRACheck = 1 AND @FileName_CommentCheck = 1  )
	BEGIN

		-- Upload start time
		SET @BeginTime = GETDATE()

	
	
		-- Live Importing
		SET @message = ''
		RAISERROR (@message,0,1) with NOWAIT
		RAISERROR (@message,0,1) with NOWAIT


		-- Import Processing Comment
		SET @message = ''
		RAISERROR (@message,0,1) with NOWAIT

		SET @message = 'Starting identity inserts on Comment.'
		RAISERROR (@message,0,1) with NOWAIT


		-- Testing
		--SELECT @TableColumnList_Comment




		-- Builds proper insert statement
		IF @IdentityInsert_Statement_Comment_Check > 0
			BEGIN 	
				SET @IdentityInsert_Statement_Comment = 'SET IDENTITY_INSERT Comment ON; INSERT INTO Comment ( ' + @TableColumnList_Comment + ' ) SELECT ' + @TableColumnList_Comment + ' FROM ##Comment_Scalable_Import; SET IDENTITY_INSERT Comment OFF;'
			END
		ELSE
			BEGIN
				SET @IdentityInsert_Statement_Comment = 'INSERT INTO Comment ( ' + @TableColumnList_Comment + ' ) SELECT ' + @TableColumnList_Comment + ' FROM ##Comment_Scalable_Import;'
			END
		


		
		-- Testing
		--SELECT @IdentityInsert_Statement_Comment

		
		EXECUTE ( @IdentityInsert_Statement_Comment )


		SET @message = 'Identity inserts on Comment has completed.'
		RAISERROR (@message,0,1) with NOWAIT
	
	
		-- End duration caluculations
		SET @EndTime = GETDATE()

		SET @Duration = DATEDIFF( Second, @BeginTime, @EndTime )

		-- Print Iteration Count Value
		SET @message = 'Duration sec: ' + CAST( @Duration  as varchar )
		RAISERROR (@message,0,1) with NOWAIT




	END

	-- End duration caluculations
	SET @OverallInsertEndTime  = GETDATE()

	SET @OverallInsertDuration = DATEDIFF( Second, @OverallInsertBeginTime, @OverallInsertEndTime )

	
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT


	-- Print Iteration Count Value
	SET @message = 'Overall Insert Duration sec: ' + CAST( @OverallInsertDuration  as varchar )
	RAISERROR (@message,0,1) with NOWAIT


	-- Processing complete
	SET @message = ' '
	RAISERROR (@message,0,1) with NOWAIT
	RAISERROR (@message,0,1) with NOWAIT

	SET @message = 'Processing complete.'
	RAISERROR (@message,0,1) with NOWAIT

END





-- Testing
--SELECT @TableColumnList_SR
--SELECT @IdentityInsert_Statement_SR
--SELECT *	FROM ##SurveyResponse_Scalable_Import
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

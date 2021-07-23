SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Create the procedure
CREATE PROCEDURE [dbo].[usp_admin_DropDefaultConstraint]
(
	@tableName SYSNAME, 
	@columnName SYSNAME,
	@terminateOnError BIT = 0
) AS
BEGIN

	-- *************************************************
	--	Utility proc to drop a default constraint with
	--  an auto-generated name.
	-- *************************************************
	
	DECLARE @severity INT;
	IF @terminateOnError = 0
		SET @severity = 16;
	ELSE
		SET @severity = 20;

	DECLARE @defaultName sysname
	set @defaultName = ''
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[' + @tableName + N']') AND type in (N'U'))
	BEGIN
		IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[' + @tableName + N']') AND name = @columnName)
		BEGIN

			-- Get the name of the default constraint
			SELECT 
				@defaultName = s.name --default name
			FROM 
				sys.sysobjects s
					join sys.syscolumns c ON s.parent_obj = c.id
			WHERE 
				s.xtype = 'd'
					and c.cdefault = s.id
					and parent_obj = OBJECT_ID(@tableName)
					and c.name = @columnName;
			 
			--test first
			IF NOT @defaultName = ''
			BEGIN
				PRINT 'Executing: ALTER TABLE [dbo].[' + @tableName +'] DROP CONSTRAINT [' + @defaultName + '];';
				exec ('ALTER TABLE [dbo].[' + @tableName +'] DROP CONSTRAINT [' + @defaultName + '];');
			END
		END
		ELSE
		BEGIN
			IF @severity < 20
				RAISERROR('Unable to drop default constraint: Table name: %s Invalid column name - %s', @severity, 1, @tableName, @columnName);
			ELSE
				RAISERROR('Unable to drop default constraint: Table name: %s Invalid column name - %s', @severity, 1, @tableName, @columnName) WITH LOG;
		END
	END
	ELSE
	BEGIN
		RAISERROR('Unable to drop default constraint: Invalid table name - %s', 16, 1, @tableName);
		IF @severity < 20
			RAISERROR('Unable to drop default constraint: Invalid table name: %s Column name - %s', @severity, 1, @tableName, @columnName);
		ELSE
			RAISERROR('Unable to drop default constraint: Invalid table name: %s Column name - %s', @severity, 1, @tableName, @columnName) WITH LOG;
	END

	-- Usage
	--Exec [usp_admin_DropDefaultConstraint] 'SurveyResponseAnswerComment', 'surveyResponseAnswerObjectId';

	-- Silently skip columns without a default constraint
	--Exec [usp_admin_DropDefaultConstraint] 'SurveyResponseAnswerComment', 'surveyResponseAnswerObjectId';

	-- Throw errors
	--Exec [usp_admin_DropDefaultConstraint] 'SurveyResponseAnswerComment', 'badcolumn';
	--Exec [usp_admin_DropDefaultConstraint] 'SurveyResponseAnswerCommen234t', 'badcolumn';

	-- Throw errors, and terminate the process if an error occurs
	--Exec [usp_admin_DropDefaultConstraint] @tableName = 'SignupProperties2q134', @columnName = 'badcolumn', @terminateOnError = 1;

END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

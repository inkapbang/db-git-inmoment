SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Create the procedure
CREATE PROCEDURE [dbo].[usp_admin_DropForeignKeyConstraint]
(
	@tableName SYSNAME, 
	@columnName SYSNAME, 
	@filterText VARCHAR(MAX) = NULL,
	@terminateOnError BIT = 0
) AS
BEGIN

	-- *************************************************
	--	Utility proc to drop a foreign-key constraint 
	--  with an auto-generated name.
	-- *************************************************
	
	DECLARE @severity INT;
	IF @terminateOnError = 0
		SET @severity = 16;
	ELSE
		SET @severity = 20;

	DECLARE @defaultName SYSNAME;
	SET @defaultName = '';
	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[' + @tableName + N']') AND type in (N'U'))
	BEGIN
		IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[' + @tableName + N']') AND name = @columnName)
		BEGIN

			-- Set up our table variable
			DECLARE @foreignKeys TABLE
			(
				[keyName] SYSNAME
			);

			-- Get the name of the foreign key constraint
			WITH a AS (
				SELECT [column_id] 
				FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[' + @tableName + ']') AND name = @columnName
			),
			b AS (
				SELECT 
					[constraint_object_id], 
					[parent_column_id]
				FROM sys.foreign_key_columns WHERE [parent_object_id] = OBJECT_ID(N'[dbo].[' + @tableName + ']')
			),
			c AS (
				select
					[id],
					[name]
				from
					sys.sysobjects
				where
					[xtype] = 'f'
					and [parent_obj] = OBJECT_ID(@tableName)
			)

			-- Query our CTE that we just set up
			INSERT INTO @foreignKeys 
				SELECT c.[name]
				FROM a 
					JOIN b ON a.[column_id] = b.[parent_column_id]
					JOIN c ON c.[id] = b.[constraint_object_id];

			-- Apply the filterText, if provided
			IF NOT @filterText = NULL
			BEGIN
				-- Appropriately handle the number of foreign keys found
				IF ((SELECT COUNT([keyName]) FROM @foreignKeys WHERE [keyName] LIKE @filterText) = 1)
				BEGIN

					-- Single foreign key match - select it
					SELECT @defaultName = [keyName] FROM @foreignKeys WHERE [keyName] LIKE @filterText;
				END
				ELSE IF ((SELECT COUNT([keyName]) FROM @foreignKeys WHERE [keyName] LIKE @filterText) > 1)
				BEGIN

					-- Multiple foreign key matches - throw an error
					IF @severity < 20
						RAISERROR('Unable to drop foreign key constraint. Multiple foreign key constraints on table %s column %s matching filter text %s', @severity, 1, @tableName, @columnName, @filterText);
					ELSE
						RAISERROR('Unable to drop foreign key constraint. Multiple foreign key constraints on table %s column %s matching filter text %s', @severity, 1, @tableName, @columnName, @filterText) WITH LOG;
				END
			END
			ELSE
			BEGIN				
				-- Appropriately handle the number of foreign keys found
				IF ((SELECT COUNT([keyName]) FROM @foreignKeys) = 1)
				BEGIN

					-- Handle the column participating in a single foreign key
					SELECT @defaultName = [keyName] FROM @foreignKeys;
				END
				ELSE IF ((SELECT COUNT([keyName]) FROM @foreignKeys) > 1)
				BEGIN

					-- Multiple foreign key matches - throw an error
					IF @severity < 20
						RAISERROR('Unable to drop foreign key constraint. Multiple foreign key constraints on table %s, column %s and no filter text provided', @severity, 1, @tableName, @columnName);
					ELSE
						RAISERROR('Unable to drop foreign key constraint. Multiple foreign key constraints on table %s, column %s and no filter text provided', @severity, 1, @tableName, @columnName) WITH LOG;
				END
			END

			-- Drop the constraint, if one was found
			IF NOT @defaultName = ''
			BEGIN
				PRINT 'Executing: ALTER TABLE [dbo].[' + @tableName +'] DROP CONSTRAINT [' + @defaultName + '];';
				EXEC ('ALTER TABLE [dbo].[' + @tableName +'] DROP CONSTRAINT [' + @defaultName + '];');
			END
		END
		ELSE
		BEGIN
			IF @severity < 20
				RAISERROR('Unable to drop foreign key constraint. Table name: %s Invalid column name: %s', @severity, 1, @tableName, @columnName);
			ELSE
				RAISERROR('Unable to drop foreign key constraint. Table name: %s Invalid column name: %s', @severity, 1, @tableName, @columnName) WITH LOG;
		END
	END
	ELSE
	BEGIN
		IF @severity < 20
			RAISERROR('Unable to drop foreign key constraint. Invalid table name: %s', @severity, 1, @tableName);
		ELSE
			RAISERROR('Unable to drop foreign key constraint. Invalid table name: %s', @severity, 1, @tableName) WITH LOG;
	END

	-- Usage
	--Exec [usp_admin_DropForeignKeyConstraint] 'SignupProperties', 'organizationObjectId';
	--Exec [usp_admin_DropForeignKeyConstraint] 'SignupRemovedLocation', 'locationObjectId', '*__locat__*';

	-- Silently skip columns without a default constraint
	--Exec [usp_admin_DropForeignKeyConstraint] 'SignupProperties', 'locationCategoryTypeObjectId';

	-- Throw errors
	--Exec [usp_admin_DropForeignKeyConstraint] 'SignupProperties', 'badcolumn';
	--Exec [usp_admin_DropForeignKeyConstraint] 'SignupProperties2q134', 'badcolumn';

	-- Throw errors, and terminate the process if an error occurs
	--Exec [usp_admin_DropForeignKeyConstraint] @tableName = 'SignupProperties2q134', @columnName = 'badcolumn', @terminateOnError = 1;
END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO

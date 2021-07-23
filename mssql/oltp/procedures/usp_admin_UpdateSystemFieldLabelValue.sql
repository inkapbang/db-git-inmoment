SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Add the new version of the stored procedure
CREATE proc [dbo].[usp_admin_UpdateSystemFieldLabelValue] 
	@fieldName varchar(50), @fieldType int, @localeKey VARCHAR(25), @labelValue NVARCHAR(MAX)
AS
BEGIN
	declare @countMatches int;
	select @countMatches = count(*)from DataField df where df.fieldType = @fieldType and df.systemField = 1;
	if (0 < (select @countMatches))
	begin
		if(1 = (select @countMatches))
		begin
			if exists(select count(*) from Locale l where l.localeKey = @localeKey COLLATE Latin1_General_CS_AS)
			begin
				if(0 != (select  count(*) from DataField df inner join LocalizedStringValue lsv on df.labelObjectId = lsv.localizedStringObjectId and lsv.localeKey = @localeKey where df.fieldType = @fieldType and df.systemField = 1))
				begin
					update 
						LocalizedStringValue 
					set 
						value = @labelValue COLLATE Latin1_General_CS_AS
					from
						DataField df 
						inner join LocalizedStringValue lsv 
							on df.labelObjectId = lsv.localizedStringObjectId 
								and lsv.localeKey = @localeKey 
					where 
						df.fieldType = @fieldType and df.systemField = 1
						and (N'b' + lsv.value + N'b') != (N'b' + @labelValue + N'b') COLLATE Latin1_General_CS_AS
						-- SQL pads the strings to the same length with spaces prior to comparison, 
						-- so the prefix and suffix are necessary to catch mismatches where the only
						-- difference is trailing spaces. A hack, but it works.
						-- For details, see 
						-- https://support.microsoft.com/en-us/help/316626/inf-how-sql-server-compares-strings-with-trailing-spaces
						
					IF @@ROWCOUNT != 0
					BEGIN
						print 'Updated system field ''' + @fieldName + ''' label for locale ''' + @localeKey + ''' to value ''' + @labelValue + '''.';
					END
				end
				else
				begin
					declare @localizedStringObjectId int;
					select @localizedStringObjectId = labelObjectId from DataField df where df.fieldType = @fieldType and df.systemField = 1;
					insert into LocalizedStringValue (
						localizedStringObjectId,
						localeKey,
						value
					) values (
						@localizedStringObjectId,
						@localeKey,
						@labelValue
					)
						
					print 'Inserted new value ''' + @labelValue + ''' for system field ''' + @fieldName + ''' label for locale ''' + @localeKey + '''.';
				end
			end
			else
			begin
				RAISERROR('No supported locale with locale key "%s" exists.', 16, 1, @localeKey);
			end
		end
		else
		begin
			RAISERROR('Multiple system fields with fieldType "%d" exist.', 16, 1, @fieldType);
		end
	end
	else
	begin
		print 'No system field with fieldType ''' + cast(@fieldType as varchar(100)) + ''' exists. Skipping label update for locale ''' + @localeKey + ''' with value ''' + @labelValue + '''.';
	end
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
